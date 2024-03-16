#!/bin/bash
apt update
apt upgrade -y
apt install -y build-essential gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabi qemu qemu-user-static gcc g++ libc6-dbg-armhf-cross

mkdir -p /usr/local/bin
mkdir -p /usr/local/include/valgrind
mkdir -p /usr/local/libexec/valgrind
mkdir -p /usr/local/lib/pkgconfig
mkdir -p /usr/local/lib/valgrind

cp -r prebuilt/usr_local_bin /usr/local/bin/
cp -r prebuilt/usr_local_include_valgrind /usr/local/include/valgrind/
cp -r prebuilt/usr_local_libexec_valgrind /usr/local/libexec/valgrind/
cp -r prebuilt/usr_local_lib_pkgconfig /usr/local/lib/pkgconfig/
cp -r prebuilt/usr_local_lib_valgrind /usr/local/lib/valgrind/

cp /usr/arm-linux-gnueabihf/lib/ld-linux-armhf.so.3 /lib/
cp -r /usr/arm-linux-gnueabihf/lib/debug/ /usr/lib/debug
ln -s /usr/arm-linux-gnueabihf/lib/libc.so.6 /lib/

chmod +x /usr/local/libexec/valgrind/memcheck-arm-linux
