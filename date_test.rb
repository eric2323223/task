require 'test/unit'
require 'my_date'
require 'time_range'

class Date
  include Eric::EDate

  def self.today
    return Date.new(2010,6,18)
  end
end

class DateTest < Test::Unit::TestCase
  def setup
  end

  def test_months_from_now
    date = Date.new(2010,6,19)
    assert_equal(0, date.months_from_now)
  end

  def test_days_from_now
    date = Date.new(2010,5,31)
    assert_equal(18, date.days_from_now)
  end
  def test_weeks_from_now
    date = Date.new(2010,6,19)
    assert_equal(0, date.weeks_from_now)
    date = Date.new(2010,6,1)
    assert_equal(2, date.weeks_from_now)
  end
  def test_fall_into
    range = TimeRange.new("2w")
    date = Date.new(2010,6,1)
    assert_equal(true,date.fall_into(range)) 
  end
end
