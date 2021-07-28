#!/usr/bin/env ruby

# Script to parse the output from vfat.tools and turn it into useful, better formatted data.

# Useful blocks start with /^\d+ - \[/ and end with a blank line.
POOL_START = /^(\d+) - \[/
POOL_END = "\n"

class Pool
  attr_reader :pool_id, :name, :tokens_staked, :usd_value, :day_apr, :rewards

  def initialize(text)
    parse text.split("\n")
  end

  def to_s
    [name, tokens_staked, usd_value, rewards, day_apr].join("\t")
  end

  private

  def parse(lines)
    parse_header lines.first
    parse_value lines.grep(/You are staking/).first
    parse_apr lines.grep(/^APR/).first
    parse_rewards lines.grep(/^Claim/).first
  end

  def parse_header(line)
    arr = line.split(" ")
    @pool_id = arr[0].to_i
    @name = arr[2].gsub(/[\[\]]/, "")
  end

  def parse_value(line)
    if line =~ /You are staking ([\d\.]+) .* \(\$(.*)\)/
      @tokens_staked = $1.to_f
      @usd_value = $2.to_f
    end
  end

  def parse_apr(line)
    if line =~ /APR: Day (.*?)%/
      @day_apr = $1.to_f
    end
  end

  def parse_rewards(line)
    if line =~ /Claim ([\d\.]+)/
      @rewards = $1.to_f
    end
  end

end

############################################################

pools = []
current_pool = ""

while line = gets
  if line =~ POOL_START .. line == POOL_END
    if line == POOL_END
      pools << current_pool
      current_pool = ""
    else
      current_pool += line
    end
  end
end

puts "Name\t\tTokens\tUSD\tRewards\tAPR/day"
pools.each do |text|
  p = Pool.new(text)
  puts p if p.usd_value > 0
end
