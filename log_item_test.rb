require 'test/unit'
require 'log_item'
require 'log_type'
require 'date'

class LogItemTest < Test::Unit::TestCase
    def setup

    end

    def test_commontype_property
        item = LogItem.new("2010-10-10_10:10:10 sample\n")
        assert_equal(1, item.type)
    end

    def test_fcrtype_property
        item = LogItem.new("2010-10-10_10:10:10 opened cr\n")
        assert_equal(LogType::FCR, item.type)
    end
    def test_vcrtype_property
        item = LogItem.new("2010-10-10_10:10:10 verified cr\n")
        assert_equal(LogType::VCR, item.type)
    end
    def test_date_property
        item = LogItem.new("2010-11-12_13:14:15 sample\n")
        assert_equal(2010, item.date.year)
        assert_equal(11, item.date.month)
        assert_equal(12, item.date.day)
        assert_equal(13, item.date.hour)
        assert_equal(14, item.date.min)
        assert_equal(15, item.date.sec)
    end
    def test_task_property
        item = LogItem.new("2010-10-10_10:10:10 sample\n")
        assert_equal("sample", item.task)
    end
end

