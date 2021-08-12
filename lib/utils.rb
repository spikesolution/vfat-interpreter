# Useful blocks start with /^\d+ - \[/ and end with a blank line.
POOL_START = /^(\d+) - \[/
POOL_END = "\n"

def output_staked_pools(list)
  puts "Name\t\tTokens\tUSD\tRewards\tAPR/day"
  list.each do |p|
    puts p if p.usd_value > 0
  end
end

def sort_by_apr(list)
  list.sort { |a,b| a.day_apr <=> b.day_apr }
    .reverse
end

def output_highest_apr_pool(list)
  p = sort_by_apr(list).first
  puts "Highest (day) APR:"
  puts [p.name, p.day_apr].join(", ")
end

def parse_report
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

  pools.map { |text| Pool.new(text) }
end
