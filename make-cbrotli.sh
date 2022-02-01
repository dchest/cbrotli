#!/bin/sh

#
# Makes cbrotli CGO bindings
# Run this script in the root directory of
# https://github.com/google/brotli
#

mkdir -p cbrotli/enc
mkdir -p cbrotli/dec

cp LICENSE cbrotli/

cp c/common/* cbrotli/

cp c/enc/* cbrotli/enc/
cd cbrotli/enc
mv prefix.h enc_prefix.h
for i in *.[ch]; do sed -i .bak -e 's/prefix\.h/enc_prefix.h/g' "$i"; done
mv * ../
cd ../..

cp c/dec/* cbrotli/dec/
cd cbrotli/dec
mv prefix.h dec_prefix.h
for i in *.[ch]; do sed -i .bak -e 's/prefix\.h/dec_prefix.h/g' "$i"; done
mv * ../
cd ../..


cd cbrotli
for i in *.[ch]; do sed -i .bak -e 's/\.\.\/common\//.\//g' "$i"; done
rmdir enc dec
cp ../go/cbrotli/* .
sed -i .bak -e 's/#cgo LDFLAGS: -lbrotlicommon/#cgo LDFLAGS: -lm/g' cgo.go
sed -i .bak -e 's/#cgo LDFLAGS: -lbrotlidec/#cgo CFLAGS: -I${SRCDIR}\/include/g' cgo.go
sed -i .bak -e 's/#cgo LDFLAGS: -lbrotlienc//g' cgo.go

rm *.bak BUILD go.mod

cp -r ../c/include .

cd ..
