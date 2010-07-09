require "test/unit"

require "time_range"

class Test_time_range < Test::Unit::TestCase
  def test_initialize
    range = TimeRange.new("1w")
    assert_equal(1,range.amount)
    assert_equal(:week, range.unit)
  end
  def test_init2
    range = TimeRange.new("3d")
    assert_equal(3, range.amount)
    assert_equal(:day, range.unit)
  end
  def test_init3
    assert_raise RuntimeError do
      TimeRange.new("m2")
    end
  end
end
