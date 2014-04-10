#!/bin/bash
#by anton lindman anton.lindman@gmail.com

# Update and upgrade
sudo apt-get -y update 
sudo apt-get -y upgrade

mkdir gns3
cd gns3
sudo apt-get -y install build-essential libelf-dev uuid-dev libpcap-dev python3-dev python3-pyqt4

# Install Dynamips
wget https://github.com/GNS3/dynamips/archive/master.zip
unzip master.zip
cd dynamips-master/
sudo make && sudo make install
cd ..

# Get pip
wget -O get-pip.py https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python3 get-pip.py

# Get python stuff
sudo pip3 install pyzmq             
sudo pip3 install tornado
sudo pip3 install netifaces-py3

# Install GNS3 Sever
wget https://github.com/GNS3/gns3-server/archive/master.zip
unzip master.zip.1
cd gns3-server-master
sudo python3 setup.py install
cd ..

# Install GNS3 GUI
wget https://github.com/GNS3/gns3-gui/archive/master.zip
unzip master.zip.2
cd gns3-gui-master
sudo python3 setup.py install
cd ..

# steps to get IOU working on 64-bit
# http://forum.gns3.net/topic9030.html?sid=da741dfdb208cbedc14538757bfa1714
sudo apt-get -y install lib32z1 lib32ncurses5 lib32bz2-1.0
sudo apt-get -y install libssl1.0.0:i386
sudo apt-get -y install libtinfo5:i386
# Fix the missing library for IOU
sudo ln -s /lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.4

# Get Files for iouyap 
wget -F http://downloads.sourceforge.net/project/gns-3/Tools/iouyap.tar.gz?r=
tar zxvf iouyap.tar.gz?r=
sudo cp iouyap /usr/local/bin/iouyap

rm -f master*
rm -f get-pip.py
rm -f examples.desktop
rm -f iouyap.tar*

echo Note: This script does not install or configure the IOU related GNS3 support and related utilities
echo "done"