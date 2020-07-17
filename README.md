### 介绍
- easyk8s是一款引导式安装k8s集群个人小应用
- easyk8s并未打算重复造轮子

### 功能
- 支持Centos7
- 支持 HA 高可用部署K8s集群
- 支持 离线 在线 两种安装模式

### 安装
```
# version="0.0.4"
# wget https://github.com/The-Last-Name/easyk8s/archive/v${version}.tar.gz
# tar -xvf easyk8s-${version}.tar.gz
# cd easyk8s-${version}
# chmod +x easyk8s
# ./easyk8s install
```

### 安装失败
```
在线或离线安装均可，执行安装命令提示是否覆盖，输入no回车，会继续安装
# ./easyk8s install
配置文件已存在是否覆盖 请输入:(yes/no) no
```

### 增加新的node节点
```
# ./easyk8s addon
```
