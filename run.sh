#!/bin/bash

source ./my.cfg

hd_filename="$hd_name.$hd_filetype.img"

$qemu -hda $hd_filename -m $memory_size
