#!/bin/bash

grep APR \
  | grep -v You.are \
  | sed 's/.*Year //' \
  | sort -n \
  | tail -1
