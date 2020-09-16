#!/bin/bash

#check DirectHW loaded
directHWloaded=$(kextstat -b org.apple.dont.block.DirectHW);


chmod +x pciutils/lspci
chmod +x pciutils/setpci

tmp_system_profiler='tmp_system_profiler.txt';
tmp_lspci='tmp_lspci.txt';

rm -f $tmp_system_profiler
rm -f $tmp_lspci

pcidata=$(system_profiler SPPCIDataType > $tmp_system_profiler);
pcieports=$(sudo ./pciutils/lspci -nnvt > $tmp_lspci);

# remove whitespaces
replaceName='tmp_sys_info_tr.txt';
tr -d " \t" < $tmp_system_profiler > $replaceName

# replace original file with cleanded file
rm -f $tmp_system_profiler
mv $replaceName $tmp_system_profiler


index=1
while read line; do
	if [[ $line = Type*NVMExpressController* ]]
	then
		second=1
		while read value; do
		if (( $second > $index ))
		then
			if [[ $value = VendorID* ]]
			then
			vendorID=${value:9}
			fi
			if [[ $value = DeviceID* ]]
			then
			deviceID=${value:9}
			break
			fi
		fi
		second=$((second+1))
		done < $tmp_system_profiler
	fi
index=$((index+1))
done < $tmp_system_profiler

if [ true ]
then
	echo found NVMExpressController!
	echo vendorID: $vendorID
	echo deviceID: $deviceID

	pci_id="["${vendorID:2}":"${deviceID:2}"]"

	echo pci-id: $pci_id
fi

# scan tmp_lspci
while read pci_line; do
	if [[ "$pci_line" == *"$pci_id"* ]]; then
		rootport=00:${$pci_line:2-3}
	fi
done < $tmp_lspci

echo rootport: $rootport

speed=2


linkstatus=$(sudo ./pciutils/setpci -s $rootport CAP_EXP+12.w);
echo '# Before: PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))

sudo ./pciutils/setpci -s $rootport CAP_EXP+30.w=$speed:F # Set Link Speed
sudo ./pciutils/setpci -s $rootport CAP_EXP+10.w=20:20 # Start Retrain

linkstatus=$(sudo ./pciutils/setpci -s $rootport CAP_EXP+12.w);
echo '# After: PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))

rm -f $tmp_system_profiler
rm -f $tmp_lspci