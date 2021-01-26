#!/usr/bin/with-contenv bashio

echo "########################"
cd /vcontrold/vcontrold/build
ls -la *

echo "########################"
lsusb
echo "########################"
echo ">ls -la /dev/tty*"
ls -la /dev/tty*
echo "########################"
echo "USER:"
echo "$USER"
echo "########################"
echo "GROUPS:"
echo "groups"
echo "########################"
echo ">test -w /dev/ttyUSB0 || echo Error"
test -w /dev/ttyUSB0 || echo Error
echo "########################"
sleep 30

echo "########################"
echo "starting vcontrold ..."
vcontrold -n
echo "vcontrold finished."
