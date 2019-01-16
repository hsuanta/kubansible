# kubansible
`kubansible`提供快速部署高可用`kubernetes`集群的工具,基于外置`etcd`+`kubeadm`方式部署, 利用`ansible-playbook`实现自动化安装,这种模式基本兼容`kubernetes`**v1.9.x** - **v1.11.x** 版本.

|组件|支持|
|:-|:-|
|OS|CentOS/RedHat 7|
|kubernetes|v1.9, v1.10, v1.11|
|docker|17.03.2-ce, 17.12.1-ce|
|network|flannel|
|DNS|kubeDNS|

## 安装指南

### 基础系统配置

+ 推荐内存4G/硬盘50G以上
+ 最小化安装`CentOS 7 Minimal`
+ 配置基础网络、更新源、SSH免密码登陆等

### ansible安装及免密钥登录配置

CentOS 7 请执行以下脚本：

``` bash
# 文档中脚本默认均以root用户执行
# 安装ansible
yum install -y ansible
# 配置ansible ssh密钥登陆
ssh-keygen
ssh-copy-id $IP #$IP为服务器的地址，按照提示输入yes 和root密码
```

## 使用指南

### 下载离线镜像

使用`images`目录里的`images_pull.sh`和`images_save.sh`脚本下载/保存`kubernetes`离线镜像.

```
cd images
bash images_pull.sh && bash images_save.sh
```

### 配置集群参数

- 1.将代码文件复制到`/etc/ansible`,然后实际情况修改此hosts文件
- 2.验证ansible 安装：`ansible all -m ping` 正常能看到节点返回 SUCCESS


### 开始安装
``` bash
ansible-playbook kubernetes.yml
```

### 验证安装
如果提示kubectl: command not found，退出重新ssh登陆一下，环境变量生效即可

``` bash
kubectl version
kubectl get componentstatus # 可以看到scheduler/controller-manager/etcd等组件 Healthy
kubectl cluster-info # 可以看到kubernetes master(apiserver)组件 running
kubectl get node # 可以看到 node Ready状态
kubectl get pod --all-namespaces # 可以查看所有集群pod状态，默认已安装网络插件、coredns、metrics-server等
kubectl get svc --all-namespaces # 可以查看所有集群服务状态
```

### 清理集群

如果环境崩溃了，可以清理集群后重新创建。

``` bash
ansible-playbook clean.yml
```
