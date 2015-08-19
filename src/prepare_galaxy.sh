#!/bin/sh

galaxy_dir="../galaxy"
current_dir=$PWD

# Clone or pull galaxy code
if [ -d $galaxy_dir ]; then
    cd $galaxy_dir
    git pull 
    cd $current_dir
else
    git clone https://github.com/galaxyproject/galaxy.git $galaxy_dir
fi

#
user="bebatut-galaxy"
sudo groupadd docker
sudo gpasswd -a $user docker
sudo service docker restart

# Prepare galaxy tools
sh src/prepare_galaxy_tools.sh $galaxy_dir

# Prepare galaxy config
cp config/* $galaxy_dir/config/

# Launch galaxy
cd $galaxy_dir
sh run.sh