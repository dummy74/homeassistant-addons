#!/usr/bin/with-contenv bashio

cd /vcontrold/vcontrold/build
ls -la *

lsusb

sleep 5

echo "starting vcontrold ..."
vcontrold -n
echo "vcontrold finished."
