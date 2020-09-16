# classic Mac Pro PCIe 2.0 Activator
This script activates PCIe 2.0 speeds on classic Mac Pro for NVMe SSD drives.
It scans all connected PCIe-devices and if it finds an NVMe it sets the PCIe-speed from 1.0 to 2.0.
This doubles the bandwith and boosts R/W Speeds by factor 2.

## requirements
- classic Mac Pro 3,1 or 4,1/5,1
- DirectHW kext loaded (SIP disabled)

## installation
The Automator application needs to be set as login item for every user that wants to have full NVMe speed
