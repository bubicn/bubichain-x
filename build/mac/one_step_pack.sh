#/bin/bash

#git fetch --all;
#git reset --hard origin/release/1.0.0.0
#git reset --hard origin/develop

DATE=$(date +%Y_%m%d_%H%M)

cd ../../
rm -rf pack/
echo 'make clean'
make clean

echo "make clean build"
make clean_build


#update git

version=`git log |grep commit |head -1`
echo 'version: ' + $version

#get shortest hash
v=${version:7:7}

#make 
make chain_version=$v

mkdir -p pack
cd pack/
rm -rf buchain/ 
mkdir buchain
mkdir buchain/config
mkdir buchain/data
mkdir buchain/jslib
mkdir buchain/bin
mkdir buchain/log
mkdir buchain/coredump
cp ../build/win32/jslib/jslint.js buchain/jslib/
cp ../build/win32/config/config-mainnet.json buchain/config/
cp ../build/win32/config/config-testnet.json buchain/config/
cp ../build/win32/config/config-single.json  buchain/config/
cp ../build/win32/config/ReadMe.txt  buchain/config/
cp ../bin/chain buchain/bin/
cp ../src/3rd/v8_target/mac/*.bin buchain/bin/
cp ../src/3rd/v8_target/mac/*.dat buchain/bin/

tar czvf buchain-mac-$DATE-$v.tar.gz buchain/
rm -rf buchain/ 

echo "build ok...."



