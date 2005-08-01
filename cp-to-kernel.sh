#!/bin/sh

# Copy klibc to kernel - integrating klibc with the kbuild infrastructure
# Most files are located in the usr/ directory structure in the kernel

# fetch kernel directory
if [ -z $1 ]; then
	echo "Copy klibc to kernel"
	echo "$0: path-to-kernel-src"
	exit 1
fi

kernel=$1
if [ ! -d $kernel ]; then
	echo "$kernel is not a directory"
	exit 1
fi

if [ -z $2 ]; then
	echo "Copying source files"
	# 1) Copy all klibc source files
	if [ ! -d $kernel/usr/klibc ]; then
		mkdir $kernel/usr/klibc
	fi
	cp -R klibc/* $kernel/usr/klibc

	echo "Copying header files"
	# 2) And the include files
	if [ ! -d $kernel/usr/include ]; then
		mkdir $kernel/usr/include
	fi
	cp -R include/* $kernel/usr/include
fi

echo "Copying gzip"
if [ ! -d $kernel/usr/gzip ]; then
	mkdir -p $kernel/usr/gzip
fi
cp -R gzip/* $kernel/usr/gzip

echo "Copying kinit"
if [ ! -d $kernel/usr/kinit ]; then
	mkdir -p $kernel/usr/kinit
fi
cp -R kinit/* $kernel/usr/kinit

echo "Copying ipconfig"
if [ ! -d $kernel/usr/kinit/ipconfig ]; then
	mkdir -p $kernel/usr/kinit/ipconfig
fi
cp -R ipconfig/* $kernel/usr/kinit/ipconfig

echo "Copying nfsmount"
if [ ! -d $kernel/usr/kinit/nfsmount ]; then
	mkdir -p $kernel/usr/kinit/nfsmount
fi
cp -R nfsmount/* $kernel/usr/kinit/nfsmount

echo "Copying ash"
if [ ! -d $kernel/usr/ash ]; then
	mkdir -p $kernel/usr/ash
fi
cp -R ash/* $kernel/usr/ash

echo "Copying utils"
if [ ! -d $kernel/usr/utils ]; then
	mkdir -p $kernel/usr/utils
fi
cp -R utils/* $kernel/usr/utils

echo "Copying kbuild files"
cp scripts/Kbuild.klibc       $kernel/scripts
# Newer kernel versions have Kbuild.include, so do not overwrite it
if [ ! -f $kernel/scripts/Kbuild.include ]; then
	cp scripts/Kbuild.include $kernel/scripts
fi
cp usr/Kbuild               $kernel/usr
cp klibc/Kbuild             $kernel/usr/klibc
cp klibc/syscalls/Kbuild    $kernel/usr/klibc/syscalls
cp klibc/socketcalls/Kbuild $kernel/usr/klibc/socketcalls


