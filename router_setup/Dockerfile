FROM ubuntu:20.04 as ubuntu-network
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        curl        wget            telnet      dnsutils \
        net-tools   netcat-openbsd  traceroute  nmap \
        jq          traceroute      ssh         ssh-askpass \
        python3     python3-pip     virtualenv  inetutils-ping \
        unzip       zip             make        vim \
        iproute2    iptables        tcpdump \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

FROM kalilinux/kali-last-release as kali-linux
RUN apt update -y
RUN apt install -y \ 
        mc          curl        iptables    inetutils-ping \    
        net-tools   procps      vim         openjdk-11-jre-headless \
        ssh         tcpdump     nmap
RUN apt install -y python3 metasploit-framework
ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py /bin/systemctl
RUN chmod +x /bin/systemctl
