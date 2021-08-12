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
      @usd_value = to_float($2)
    end
  end

  def parse_apr(line)
    if line =~ /APR: Day (.*?)%/
      @day_apr = to_float($1)
    end
  end

  def parse_rewards(line)
    if line =~ /Claim ([\d\.]+)/
      @rewards = $1.to_f
    end
  end

  def to_float(str)
    str.gsub(",", "").to_f
  end

end
