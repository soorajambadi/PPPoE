# run - run the server.
# Copyright (C) 2016  Sooraj Mandotti, Puneet Arora.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# sooraj.mandotti@stud.tu-darmstadt.de, Technical University Darmstadt
# puneet.arora@stud.tu-darmstadt.de, Technical University Darmstadt

#!/bin/bash

DPDK_DIR=deps/dpdk
DPDK_PLAF=x86_64-native-linuxapp-gcc

#Required kernel modules
modprobe uio
insmod $DPDK_DIR/$DPDK_PLAF/kmod/igb_uio.ko
insmod $DPDK_DIR/$DPDK_PLAF/kmod/rte_kni.ko

#The following must be done for every device we want to use. Only for VirtIO devices this is not required.
$DPDK_DIR/tools/dpdk_nic_bind.py --bind igb_uio 0000:00:08.0

export LD_LIBRARY_PATH=$DPDK_DIR/$DPDK_PLAF/lib
./main -c3 -n4 -d $DPDK_DIR/$DPDK_PLAF/lib/librte_pmd_virtio.so

