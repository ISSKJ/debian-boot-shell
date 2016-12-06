#!/bin/bash

source ./my.cfg

function execute {
    echo "$1"
    eval $1
}

hd_img=
install_iso=`basename $netinst_url`

if [ -f $install_iso ]; then
    echo "installer have already installed."
else
    execute "wget $netinst_url"
    if [ $? == 0 ]; then
        install_iso=`basename $netinst_url`
        echo "downloaded install iso: $install_iso"
    else
        exit
    fi
fi

hd_filename="$hd_name.$hd_filetype.img"
if [ -f $hd_filename ]; then
    echo "hd have already created."
else
    execute "qemu-img create -f $hd_filetype $hd_filename $hd_size"
    if [ $? == 0 ]; then
        echo "hd created: $hd_filename [$hd_size]"
    else
        exit
    fi
fi

execute "$qemu -hda $hd_filename -cdrom $install_iso -boot d -m $memory_size"
