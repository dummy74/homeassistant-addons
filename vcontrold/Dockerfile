ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache --virtual build-deps alpine-sdk linux-headers cmake git automake autoconf libxml2-dev && \
    mkdir /vcontrold && \
    cd /vcontrold && \
    git clone https://github.com/openv/vcontrold.git vcontrold && \
    mkdir /vcontrold/vcontrold/build && \
    cd /vcontrold/vcontrold/build && \
    cmake -DVCLIENT=ON -DVSIM=ON -DMANPAGES=OFF .. && \
    make && \
    make install && \
    apk del build-deps && \
    cd / && \
    rm -r /vcontrold && \
    apk add --no-cache mosquitto-clients jq

# Copy data for add-on
ADD vcontrold.xml /etc/vcontrold/
ADD vito.xml /etc/vcontrold/

# Create a user and group 'vcontrol'
RUN addgroup -S vcontrol \
    adduser -S -D -h /usr/app/src vcontrol vcontrol && \
    addgroup vcontrol dialout

# Switch to user 'vcontrol'
USER vcontrol

COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /home/vcontrol

# Define an environment variable
# Use this variable when creating a container to specify the MQTT broker host.
ENV MQTT_HOST="hassio.local"
ENV MQTT_USER="guest"
ENV MQTT_PASS="guest"
ENV MQTT_TOPIC="homeassistant/sensor/vcontrold"

CMD [ "/run.sh" ]

