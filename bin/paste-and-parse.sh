#!/bin/bash

d=$(date +%Y-%m-%d)
file="${d}.txt"
pbpaste > $file && cat $file | bin/parse-vfat-output.rb
