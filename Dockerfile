#FROM centos:8
FROM rockylinux/rockylinux:9
#FROM harbor.qytang.com/public/centos:8
#定义启动jenkins的用户
USER root

#修改时区为东八区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    echo 'Asia/Shanghai' >/etc/timezone

# 安装必要工具
RUN yum -y update && yum clean all && yum makecache && \
    yum install -y nginx python3 python3-pip net-tools bind-utils lrzsz curl dos2unix --allowerasing
# 安装Python模块
RUN pip3 install flask

# 工作目录
WORKDIR /qytang

# 拷贝APP
COPY app.py .

# 转码
RUN dos2unix app.py

# 添加执行权限
RUN chmod +x app.py

# 启动Nginx
ENTRYPOINT ["/qytang/app.py"]
