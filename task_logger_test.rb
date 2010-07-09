require "task_logger"
require 'rubygems'
require 'flexmock/test_unit'

class TaskLoggerTest < Test::Unit::TestCase
  def setup
  end

  def faked_tasks
    tasks = [] 
    tasks << LogItem.new("2010-10-10_10:10:10 sample tasks\n")
    tasks << LogItem.new("2010-10-11_10:10:10 verified cr#111111\n")
    tasks << LogItem.new("2010-10-12_10:10:10 opened cr#122222\n")
    tasks << LogItem.new("2010-10-12_10:10:10 verify cr123445\n")
    tasks << LogItem.new("2010-10-12_10:10:10 filed cr124123\n")
    return tasks
  end

  def test_get_opened_cr
    assert_equal(4, TaskLogger.get_opened_cr.length)
  end
end
