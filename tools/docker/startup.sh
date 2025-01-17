#!/bin/sh

## initialize environment
if [ ! -f "/docker_config/init_flag" ]; then
    # create user
    groupadd -g $GID $USER
    useradd --create-home --no-log-init -u $UID -g $GID $USER
    usermod -aG sudo $USER
    echo "$USER:$PASSWORD" | chpasswd
    chsh -s /bin/bash $USER
    # copy xfce4 config
    mkdir /home/$USER/.config
    cp -r /docker_config/xfce4 /home/$USER/.config
    chown -R $UID:$GID /home/$USER/.config
    chown -R $UID:$GID /data1
    # vgl for user
    echo "export PATH=/usr/NX/scripts/vgl:\$PATH" >> /home/$USER/.bashrc
    # custom init
    bash /docker_config/init.sh
    # update init flag
    echo  "ok" > /docker_config/init_flag
fi

/usr/sbin/sshd
/etc/init.d/dbus start
/etc/NX/nxserver --startup
tail -f /usr/NX/var/log/nxserver.log