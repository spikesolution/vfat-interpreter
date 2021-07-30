#!/bin/bash

prefix=$1

d=$(date +%Y-%m-%d)
file="${prefix}-${d}.txt"
pbpaste > $file && cat $file | bin/parse-vfat-output.rb
