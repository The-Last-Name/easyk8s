#!/bin/bash
# Time: 2020.7.18
# BY: The Last Name

# 判断离线安装还是在线安装
localhost=$(cd `dirname $0`; pwd)
cd $localhost
Offline_status=`cat ../hosts | grep Offline | awk -F "=" '{print $2}'`


# 删除所有yum
cd /etc/yum.repos.d/ && rm -rf ./*


if [[ $Offline_status = '"yes"' ]];
then
cat > /etc/yum.repos.d/ansible.repo << EOF
[ansible]
name=ansible
baseurl=file://$localhost/../roles/Set_Base/files/Offline/rpm
gpgcheck=0
EOF

else

cat > /etc/yum.repos.d/ansible.repo << EOF
[ansible]
name=ansible
baseurl=https://mirror.tuna.tsinghua.edu.cn/epel/7/x86_64/
gpgcheck=0
EOF

curl -s -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
curl -s -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

fi


yum install -y ansible

sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg
sed -i 's/# command_warnings = False/command_warnings = False/g' /etc/ansible/ansible.cfg
