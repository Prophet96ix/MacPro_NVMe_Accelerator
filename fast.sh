#!/bin/bash
# No arguments sanity checking done

rootport=$1
speed=2;

linkstatus=$(sudo ./setpci -s $rootport CAP_EXP+12.w);
echo '# Initial PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))

sudo ./setpci -s $rootport CAP_EXP+30.w=$speed:F
sudo ./setpci -s $rootport CAP_EXP+10.w=20:20

linkstatus=$(sudo ./setpci -s $rootport CAP_EXP+12.w);
echo '# Final PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))