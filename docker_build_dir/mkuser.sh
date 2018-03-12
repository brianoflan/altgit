
# addgroup -g $GID $GROUP
echo "$GROUP:x:$GID:" >> /etc/group
# adduser -h $HOME -s /bin/bash -G $GROUP -D -u $UID $USER
echo "$USER:x:$UID:$GID:$USER:$HOME:/bin/bash" >> /etc/passwd
echo "$USER:"'!'":$(($(date +%s) / 60 / 60 / 24)):0:99999:7:::" >> /etc/shadow
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/0-$USER
mkdir -p $(dirname "$HOME") && mv /resources/home "$HOME"
echo '[[ $LOADED_BASH_PROFILE ]] || source ~/.bash_profile' >> $HOME/.bashrc
echo 'PATH=$HOME/pre-bin:$PATH:$HOME/bin' >> $HOME/.bash_profile
echo '[[ $INIT_DONE ]] || bash ~/.init.sh' >> $HOME/.bash_profile
echo 'export LOADED_BASH_PROFILE=true' >> $HOME/.bash_profile
chown -R $USER:$GROUP $HOME
chmod -R a+rwx $HOME/bin; chmod a+r $HOME/*
