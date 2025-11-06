# ---- Базовый образ Ubuntu 22.04 ----
FROM ubuntu:22.04

ENV container docker

# ---- Установка systemd и SSH ----
RUN apt-get update && \
    apt-get install -y systemd systemd-sysv openssh-server sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ---- Разрешаем root вход через SSH ----
RUN mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# ---- Создаем пользователя ubuntu ----
RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo

# ---- Systemd должна быть PID 1 ----
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
