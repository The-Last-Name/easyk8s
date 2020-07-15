#-*- coding: utf-8 -*-
#!/usr/bin/python
# Time: 2020.6.30
# BY: The Last Name
# 函数返回必须是字符串类型
import platform,os,sys,re

#辅助函数用于判断版本号使用
def if_max(version_a,version_b):
    for_len=0
    if len(version_a.split(".")) == len(version_b.split(".")):
      for_len=len(version_a.split("."))
    elif len(version_a.split(".")) > len(version_b.split(".")):
      for_len=len(version_a.split("."))
      version_b=version_b + (".0" * (len(version_a.split(".")) - len(version_b.split("."))))
    else:
      for_len=len(version_b.split("."))
      version_a=version_a + (".0" * (len(version_b.split(".")) - len(version_a.split("."))))
    for i in range(for_len):
      if int(version_a.split(".")[i]) > int(version_b.split(".")[i]):
        return version_a
    return version_b

#判断是否需要升级内核比较内核版本号
def if_kernel_version(kernel_min_version="4.19.0"):
    kernel_version=platform.release().split("-")[0]
    if if_max(kernel_min_version,kernel_version) == kernel_min_version:
      return "up"
    else:
      return "not up"

#获取Centos系统版本
def if_system_version():
    if os.path.isfile("/etc/redhat-release"):
      f = open("/etc/redhat-release","r")
      system_version = f.read()
      f.close()
      return system_version.split()[3].split(".")[0]
    else:
      return "System Distro Not Support"


#设置新内核为默认启动
def up_kernel():
    kernel_list=[]
    #获取所有内核
    for line in open("/boot/grub2/grub.cfg"):
      searchObj_1 = re.match( r'^menuentry \'(.*\))\'', line)
      if searchObj_1:
        searchObj_2 = re.search( r'([0-9]\..*)-', searchObj_1.group(1))
        if searchObj_2:
          kernel_list.append([searchObj_1.group(1),searchObj_2.group(1)])
    #比较内核版本
    if len(kernel_list) <= 1:
      return "Not Up kernel"
    max_kernel_version = kernel_list[0]
    for kernel_version in kernel_list:
        tmp_kernel_version = if_max(max_kernel_version[1],kernel_version[1])
        if tmp_kernel_version != max_kernel_version[1]:
          max_kernel_version = kernel_version
    cmd_status = os.system("(grub2-editenv list | grep '"+ max_kernel_version[0] +"')  > /dev/null 2>&1")
    if cmd_status != 0:
      os.system("grub2-set-default '" + max_kernel_version[0] + "'")
      return "Yes change"
    else:
      return "No change"

if __name__=='__main__':
    fun_key={"kernel":if_kernel_version,"version":if_system_version,"up_kernel":up_kernel}
    if len(sys.argv) == 2 and sys.argv[1] in fun_key:
      print(fun_key[sys.argv[1]]())
    else:
      print("Option Error")
