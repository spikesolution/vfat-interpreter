#!/usr/bin/env ruby

# Script to parse the output from vfat.tools and turn it into useful, better formatted data.

require "./lib/pool"
require "./lib/utils"

############################################################

list = parse_report
output_staked_pools(list)
puts
output_highest_apr_pool(list)
