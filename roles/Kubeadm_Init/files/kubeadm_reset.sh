#!/bin/bash
# Time: 2020.07.03
# BY: The Last Name

expect << EOF
spawn  kubeadm reset
set timeout 120
expect "y/N" {send "y\r"}
expect "kube/config file" {send "\r"}
expect "#" {send "\r"}
EOF