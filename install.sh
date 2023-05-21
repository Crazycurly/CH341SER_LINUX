# Check if is raspberry pi
if cat /proc/cpuinfo | grep -q BCM; then
    echo "This is a Raspberry Pi. Install raspberrypi-kernel-headers"
    sudo apt-get install raspberrypi-kernel-headers
else
    if ! dpkg -s linux-headers-$(uname -r) > /dev/null 2>&1; then
        echo "No linux-header installed. Installing linux-header..."
        sudo apt-get install linux-headers-$(uname -r)
    fi
fi

# make under driver
cd driver
echo "Making driver..."
sudo make clean
sudo make -j
echo "Loading driver..."
sudo make load
echo "Installing driver..."
sudo make install
echo "Done."