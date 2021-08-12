#!/usr/bin/env ruby

require "./lib/utils"
require "./lib/pool"

sort_by_apr(parse_report).each {|p| puts [p.name, p.day_apr].join("\t") }

