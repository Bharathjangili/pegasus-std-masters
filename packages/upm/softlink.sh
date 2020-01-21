#!/bin/bash

cd /usr/local/lib ; \
FILE=`find . -name "libupm*.so.1.3.0"`

for i in $FILE; \
do \
    echo "Inside for"; \
    LINK1=$i; \
    LINK2=$i; \
    SYM_LINK1="so.1"; \
    SYM_LINK2="so"; \

    LINK1=${LINK1/so.1.3.0/$SYM_LINK1}; \
    LINK2=${LINK2/so.1/$SYM_LINK2}; \

    echo "File     : $i"
    echo "Symlink1 : $LINK1"
    echo "Symlink2 : $LINK2"

    ln -sf $i $LINK1; \
    ln -sf $LINK1 $LINK2; \
done
         
rm -rf ./Temporary_file
