#!/usr/bin/with-contenv bashio

echo "########################"
cd /vcontrold/vcontrold/build
ls -la *

echo "########################"
lsusb
echo "########################"
ls -la /dev/tty*
echo "########################"
sleep 10

echo "########################"
echo "starting vcontrold ..."
vcontrold -n
echo "vcontrold finished."
