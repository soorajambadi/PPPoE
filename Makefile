# Makefile - Makes the server executable.
# Copyright (C) 2016  Sooraj Mandotti
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

CC=gcc

# Should contain pre-built DPDK at least.
RTE_SDK=deps/dpdk

# Default target, can be overriden by command line or environment
RTE_TARGET ?= x86_64-native-linuxapp-gcc

LDDIRS += -L$(RTE_SDK)/$(RTE_TARGET)/lib	#Here, libdpdk.so should reside.

LDLIBS += -ldpdk
LDLIBS += -ldl
LDLIBS += -lpthread
#LDLIBS += -lxml2 
LDLIBS += -lm

app: main.o
	$(CC) $(LDDIRS) -o main main.o $(LDLIBS)

main.o: main.c pppoe_dp.c
	$(CC) -mssse3 -I../grt -I$(RTE_SDK)/$(RTE_TARGET)/include -c main.c

