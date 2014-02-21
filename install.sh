#!/bin/bash

function check_root()
{
  if [ $EUID -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
  fi
}

function configure_selinux()
{
  setenforce 0
  sed -i s/'SELINUX=enforcing'/'SELINUX=disabled'/g /etc/selinux/config 
}

function stop_iptables()
{
  /etc/init.d/iptables stop
}

function install_salt()
{
  rpm -qa | grep epel-release-6-8
  if [ $? -ne 0 ]; then
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  fi
}
