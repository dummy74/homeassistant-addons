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
    apk add --no-cache mosquitto-clients jq

# Copy data for add-on
ADD vcontrold.xml /etc/vcontrold/
ADD vito.xml /etc/vcontrold/

COPY run.sh /
RUN chmod a+x /run.sh


# Define an environment variable
# Use this variable when creating a container to specify the MQTT broker host.
ENV MQTT_HOST="hassio.local"
ENV MQTT_USER="guest"
ENV MQTT_PASS="guest"
ENV MQTT_TOPIC="homeassistant/sensor/vcontrold"

CMD [ "/run.sh" ]

#FROM debian:stable-slim
#
#RUN apt-get update && \
#    apt-get upgrade && \
#    apt-get install -y build-essential subversion automake autoconf telnet #libxml2-dev && \
#    mkdir openv && \
#    cd openv && \
#    svn checkout svn://svn.code.sf.net/p/vcontrold/code/trunk vcontrold-#code && \
#    cd vcontrold-code/vcontrold && \
#    chmod +x auto-build.sh && \
#    ./auto-build.sh && \
#    ./configure && \
#    make && \
#    make install 
#
#ADD vcontrold.xml /etc/vcontrold/
#ADD vito.xml /etc/vcontrold/
#ADD startup.sh /
#
#ENTRYPOINT ["/startup.sh"]
