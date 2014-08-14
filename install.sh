#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#===============================================================================================
#   System Required:  CentOS / RedHat / Fedora 
#   Description:  auto back mysqldatabase
#   Author: Lurenjia <cn.lurenjian@gmial.com>
#   Intro:  http://lurenjian.org.cn Version=1.0
#===============================================================================================
clear
echo "#############################################################"
echo "# SVN Auto Install Script for CentOS / RedHat / Fedora"
echo "# Intro: http://lurenjian.org.cn Version=1.0" 
echo "#"
echo "# Author: Lurenjia <cn.lurenjian@gmial.com>"
echo "#"
echo "#############################################################"
echo ""
#禁用SELINUX
if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi
#时间配置准确
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yum -y install ntp
ntpdate us.pool.ntp.org
hwclock -w
#安装环境要求
yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum -y install gcc make cmake tar unzip perl-ExtUtils-MakeMaker perl-ExtUtils-CBuilder
#下载源码文件
cd /usr/local/src
wget --no-check-certificate https://github.com/git/git/archive/v2.1.0-rc2.tar.gz
#解压源码文件
clear
tar -zxvf v2.1.0-rc2.tar.gz
rm -rf v2.1.0-rc2.tar.gz
cd /usr/local/src/git-2.1.0-rc2/
if [ ! -d /usr/local/git ]; then
	#开始安装软件
	make prefix=/usr/local/git all && make prefix=/usr/local/git install
	#配置环境软链
	clear
	ln -s /usr/local/git/bin/git /bin/
fi
echo "Successfully install GIT!!"
