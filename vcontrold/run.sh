#!/usr/bin/with-contenv bashio

echo "########################"
echo "pwd"
pwd
echo "########################"
echo "cd /vcontrold/vcontrold/build"
cd /vcontrold/vcontrold/build
ls -la *
cd -

echo "########################"
lsusb
echo "########################"
echo ">ls -la /dev/tty*"
ls -la /dev/tty*
echo "########################"
for f in $(ls /dev/tty*); do
	echo ">test -w $f || echo Error"
	test -w $f && echo Success || echo Error
	chmod 666 $f
done
echo "########################"
echo "GROUPS:"
groups
echo "########################"
#sleep 10

echo "########################"
echo "starting vcontrold ..."
vcontrold --verbose #--nodaemon
#echo "vcontrold finished."
echo "vcontrold daemonized."


CONFIG_PATH=/data/options.json
MQTT_HOST="$(jq --raw-output '.mqtt_host' $CONFIG_PATH)"
MQTT_USER="$(jq --raw-output '.mqtt_user' $CONFIG_PATH)"
MQTT_PASS="$(jq --raw-output '.mqtt_password' $CONFIG_PATH)"
INTERVAL="$(jq --raw-output '.interval' $CONFIG_PATH)"

echo "-------------------------------------------"
echo "Parameters:"
echo "MQTT Host =" $MQTT_HOST
echo "Sleep interval =" $INTERVAL
echo "-------------------------------------------"
# Enter endless loop
echo "Enter endless loop ..."
sleep 10
while true; do
	for cmd in "getTempA getTempWW"; do
		msg=$(vclient -h 127.0.0.1:3002 -c $cmd -k | awk 'BEGIN{FS=":"} {print $2}')
		echo "$cmd: $msg"
		/usr/bin/mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS -r -t vcontrold/$cmd -m $msg
	done
	sleep $INTERVAL
done
