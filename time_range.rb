class TimeRange
  attr_reader :amount, :unit

  def initialize(string_rep)
    pattern = /(\d+)(d|w|m)/i
    range = string_rep.scan pattern
    if $~ != nil && $~.size == 3
      @amount = $1.to_i
      case $2
      when /w/i
        @unit = :week
      when /m/i
        @unit = :month
      else
        @unit = :day
      end
    else
      raise "#{string_rep} is not a valid time range"
    end
  end
end
