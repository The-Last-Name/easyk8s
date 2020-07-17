#!/bin/bash
# Time:2020.7.16
# BY: The Last Name
token_sum=`kubeadm token list  | wc -l`
if [[ $token_sum -gt 1 ]];
then
  kubeadm token list  | awk -F" " '{print $1}' |tail -n 1
else
  kubeadm token create > /dev/null 2>&1
  kubeadm token list  | awk -F" " '{print $1}' |tail -n 1
fi


