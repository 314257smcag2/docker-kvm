FROM ubuntu:20.04
LABEL MAINTAINER=shakugan

RUN \
  apt-get update && \
  apt-get install -y qemu-kvm qemu-utils telnet iptables bridge-utils iproute2 iputils-ping dnsmasq net-tools && \
  apt-get autoclean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*
RUN wget -O /kvm/Porteus-CINNAMON-v5.0-x86_64.iso http://ftp.vim.org/ftp/os/Linux/distr/porteus/x86_64/Porteus-v5.0/Porteus-CINNAMON-v5.0-x86_64.iso
ADD runvm.sh /

ENV OS_ISO=/kvm/Porteus-CINNAMON-v5.0-x86_64.iso
ENV DRV_ISO=/kvm/drv.iso
ENV RAM=6144
ENV SMP=1
ENV SOCKETS=1
ENV CORES=2
ENV THREADS=1
ENV MAXCPUS=2
ENV VM_NAME=virtual-desktop
ENV VGAID='8086 1916'
ENV VGAHOST='0000:00:02.0'
ENV VGAHOST_SHORT='00:02.0'
ENV QEMU_AUDIO_DRV=alsa
ENV VNC='0.0.0.0:1'
ENV ROM_FILE='/kvm/vbios.bin'
ENV AUDIO_DEVICE='AC97'
ENV BOOT_ORDER='c'
ENV DISK_FILE=/kvm/disk.qcow2
ENV TELNET='127.0.0.1:55555'
ENV DNS_SERVERS=114.114.114.114
ENV EXT_DEVICES=

RUN chmod 755 runvm.sh
VOLUME /data

ENTRYPOINT ["/runvm.sh"]
