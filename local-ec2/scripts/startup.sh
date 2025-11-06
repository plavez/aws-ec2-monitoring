#!/bin/bash
set -e

# Установка пакетов только один раз
if [ ! -f /setup_done ]; then
  echo "[INIT] Installing SSH and user ubuntu..."
  apt update -y
  DEBIAN_FRONTEND=noninteractive apt install -y openssh-server sudo iproute2

  useradd -m -s /bin/bash ubuntu || true
  echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/90-ubuntu

  mkdir -p /home/ubuntu/.ssh /var/run/sshd
  cp /seed/authorized_keys /home/ubuntu/.ssh/authorized_keys
  chown -R ubuntu:ubuntu /home/ubuntu/.ssh
  chmod 700 /home/ubuntu/.ssh
  chmod 600 /home/ubuntu/.ssh/authorized_keys

  sed -i 's@^#\?PasswordAuthentication .*@PasswordAuthentication no@' /etc/ssh/sshd_config
  sed -i 's@^#\?PermitRootLogin .*@PermitRootLogin no@' /etc/ssh/sshd_config

  echo "[INIT] Setup complete." > /setup_done
fi

echo "[RUN] Starting SSH service..."
service ssh start

# держим контейнер в фоне
tail -f /dev/null
