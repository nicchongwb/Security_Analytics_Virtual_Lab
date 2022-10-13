FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        curl \
        wget \
        telnet \
        dnsutils \
        net-tools \
        netcat-openbsd \
        traceroute \
        nmap \
        jq \
        traceroute \
        ssh \
        ssh-askpass \
        python3 \
        python3-pip \
        virtualenv \
        inetutils-ping \
        unzip \
        zip \
        make \
        vim \
        iproute2 \
        iptables \
        tcpdump \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
