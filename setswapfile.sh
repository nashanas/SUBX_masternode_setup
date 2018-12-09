#!/bin/sh
echo Creating swapfile
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile;wait
echo Enabling swap...
sudo swapon /swapfile;wait
echo Set swappiness
sudo sysctl vm.swappiness=10;wait
echo Adjusting Cache Pressure
sudo sysctl vm.vfs_cache_pressure=50
