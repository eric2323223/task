require File.dirname(__FILE__)+"/log_type.rb"
require 'date'

class LogItem
  attr_reader :type, :date, :task

  def initialize(log_line)
    parts = log_line.scan(/(\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}) ([^\n]*)\n/)
    if $~ != nil && $~.size == 3
      @date = parse_date_time($1.to_s)
      @type, @task = parse_task($2.to_s)
    else
      raise "#{log_line} is not a valid task"
    end
  end

  def to_s(date_pattern)
    date.strftime(date_pattern)+" "+type.to_s+" "+ task 
  end

  def parse_date_time(date_time_string)
    all = date_time_string.scan(/(\d{4})-(\d{2})-(\d{2})_(\d{2}):(\d{2}):(\d{2})/)
    DateTime.new($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i)    
  end

  def parse_task(task_string)
    type = nil
    if task_string =~ /(verified|verify)\s+cr/i
      type = LogType::VCR
    elsif task_string =~ /(open|file|opened|filed)\s+cr/i
      type = LogType::FCR
    else
      type = LogType::COMMON
    end
    return type, task_string
  end
end
