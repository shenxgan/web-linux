FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash sudo vim curl \
    net-tools iputils-ping \
    python3 python3-pip \
 && apt clean && rm -rf /var/lib/apt/lists/*

# 创建普通用户
RUN useradd -m -s /bin/bash xyz && \
    echo "xyz ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 拷贝 .bashrc 增量内容
COPY safe-shell.sh bashrc.append vimrc /tmp/
# 追加内容到用户原始 .bashrc
RUN cat /tmp/bashrc.append >> /home/xyz/.bashrc && \
    chown xyz:xyz /home/xyz/.bashrc && \
    mv /tmp/safe-shell.sh /home/xyz && \
    chown xyz:xyz /home/xyz/safe-shell.sh && \
    chmod +x /home/xyz/safe-shell.sh && \
    mv /tmp/vimrc /home/xyz/.vimrc && \
    chown xyz:xyz /home/xyz/.vimrc && \
    ln -sf /usr/bin/python3 /usr/bin/python

USER xyz
WORKDIR /home/xyz

CMD ["./safe-shell.sh"]
