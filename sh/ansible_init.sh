#!/bin/bash
# Time: 2020.7.18
# BY: The Last Name

net_code=`curl -I -s www.baidu.com | grep HTTP/1.1 | awk '{print $2}'`
if [[ $net_code -ne 200 ]];
then
  cd /etc/yum.repos.d/
  mkdir bak
  mv *.repo bak
fi

yum install -y ansible > /dev/null 2>&1

which ansible > /dev/null 2>&1
if [[ $? -ne 0 ]];
then
   cd $(dirname $0)
   cd sh/
   /usr/bin/cp -r ./rpm /tmp/
cat > /etc/yum.repos.d/ansible.repo << EOF
[ansible]
name=ansible
baseurl=file:///tmp/rpm/
gpgcheck=0
EOF
  yum install -y ansible
  sleep 5
  rm -rf /etc/yum.repos.d/ansible.repo
fi

sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg
sed -i 's/# command_warnings = False/command_warnings = False/g' /etc/ansible/ansible.cfg

