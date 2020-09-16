#!/bin/bash

#check DirectHW loaded


#pcieports=$(sudo ./lspci -nnvt);

sys_info_tmp='Documents/temp_sys_info.txt';
#rm -f ~/$sys_info_tmp

#pcidata=$(system_profiler SPPCIDataType > ~/$sys_info_tmp);

# remove whitespaces
#tr -d " \t" < ~/$sys_info_tmp > ~/Documents/temp_sys_info_tr.txt

# replace original file with cleanded file
#rm -f ~/$sys_info_tmp
#mv ~/Documents/temp_sys_info_tr.txt ~/$sys_info_tmp


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
		done < ~/$sys_info_tmp
	fi
index=$((index+1))
done < ~/$sys_info_tmp

if [ true ]
then
	echo found NVMExpressController!
	echo vendorID: $vendorID
	echo deviceID: $deviceID

	pcie_id="["${vendorID:2}":"${deviceID:2}"]"

	echo pcie-id: $pcie_id
fi





speed=2
rootport=00:1


#linkstatus=$(sudo ./setpci -s $rootport CAP_EXP+12.w);
#echo '# Before: PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))

#sudo ./setpci -s $rootport CAP_EXP+30.w=$speed:F # Set Link Speed
#sudo ./setpci -s $rootport CAP_EXP+10.w=20:20 # Start Retrain

#linkstatus=$(sudo ./setpci -s $rootport CAP_EXP+12.w);
#echo '# After: PCIe' $(( 0x$linkstatus & 15)).0 x$(( 0x$linkstatus >> 4 & 31))

#rm -f $sys_info_tmp