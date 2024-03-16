# env
apt update
apt upgrade -y
apt install -y build-essential gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabi qemu qemu-user-static  \
    wget gcc g++ bzip2 libc6-dbg-armhf-cross file

# cross compile valgrind
wget https://sourceware.org/pub/valgrind/valgrind-3.22.0.tar.bz2
tar -jxf valgrind-3.22.0.tar.bz2
cd valgrind-3.22.0
sed -i 's/armv7/arm/g' ./configure
./configure --host=arm-linux-gnueabi \
            --prefix=/usr/local \
            CFLAGS=-static \
            CC=arm-linux-gnueabihf-gcc \
            CPP=arm-linux-gnueabihf-cpp
make CFLAGS+="-fPIC"
make install

# libs
cp /usr/arm-linux-gnueabihf/lib/ld-linux-armhf.so.3 /lib/
cp -r /usr/arm-linux-gnueabihf/lib/debug/ /usr/lib/debug
ln -s /usr/arm-linux-gnueabihf/lib/libc.so.6 /lib/

# clean 
cd ..
rm -rf valgrind-3.22.0 valgrind-3.22.0.tar.bz2

# memcheck wrapper and rename
mv /usr/local/libexec/valgrind/memcheck-arm-linux /usr/local/libexec/valgrind/memcheck-arm-linux-wrapper
echo '#!/bin/bash' > /usr/local/libexec/valgrind/memcheck-arm-linux
echo 'exec qemu-arm-static /usr/local/libexec/valgrind/memcheck-arm-linux-wrapper "$@"' >> /usr/local/libexec/valgrind/memcheck-arm-linux
chmod +x /usr/local/libexec/valgrind/memcheck-arm-linux
mv /usr/local/bin/valgrind /usr/local/bin/valgrind-arm

# if x86 valgrind also needed, install it after the above script
# avoid dealing with conflicting debug files
# apt install -y valgrind
