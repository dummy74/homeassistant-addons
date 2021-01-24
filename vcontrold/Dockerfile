ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache --virtual build-deps alpine-sdk cmake git libusb-dev automake autoconf telnet libxml2-dev && \
    mkdir /tmp/src && \
    cd /tmp/src && \
    git clone https://github.com/openv/vcontrold.git vcontrold && \
    mkdir /tmp/src/vcontrold/build && \
    cd /tmp/src/vcontrold && \
    chmod +x auto-build.sh && \
    ./auto-build.sh && \
    ./configure && \
    make && \
    make install && \
    apk del build-deps && \
    rm -r /tmp/src

# Copy data for add-on
ADD vcontrold.xml /etc/vcontrold/
ADD vito.xml /etc/vcontrold/

COPY run.sh /
RUN chmod a+x /run.sh

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
