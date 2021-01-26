#!/usr/bin/with-contenv bashio

echo "########################"
echo "pwd"
pwd
echo "########################"
echo "cd /vcontrold/vcontrold/build"
cd /vcontrold/vcontrold/build
ls -la *

echo "########################"
lsusb
echo "########################"
echo ">ls -la /dev/tty*"
ls -la /dev/tty*
echo "########################"
for f in $(ls /dev/tty*); do
	echo ">test -w $f || echo Error"
	test -w $f || echo Error
done
echo "########################"
echo "GROUPS:"
echo "groups"
echo "########################"
sleep 30

echo "########################"
echo "starting vcontrold ..."
vcontrold -n
echo "vcontrold finished."
