#!/usr/bin/with-contenv bashio

cd /vcontrold/vcontrold/build
ls -la *

echo "starting vcontrold ..."
vcontrold -n
echo "vcontrold finished."
