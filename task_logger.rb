require "date"
require File.dirname(__FILE__)+"/log_item.rb"
require File.dirname(__FILE__)+"/time_range.rb"
require File.dirname(__FILE__)+"/my_date.rb"

class TaskLogger
  @@log_file = File.dirname(__FILE__)+"/tasks.log"

  def self.log(msg)
    open(@@log_file,"a") do |f|
      f.write(DateTime.now.strftime("%Y-%m-%d_%H:%M:%S")+" "+msg+ "\n")
    end
  end

  def self.read
    #    all_tasks = open(@@log_file).read
    #   return all_tasks.scan(/\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2} [^\n]+\n/)
    lines = open(@@log_file).readlines
  end

  def self.all_tasks(range)
    lines = self.read
    tasks = [] 
    for line in lines 
      task = LogItem.new(line)
      if task.date.fall_into(TimeRange.new(range))
        tasks << task 
      end
    end
    return tasks
  end

  def self.generate_report(range)
    puts generate_summary(range)
    puts generate_opened_cr_part(range)
    puts generate_verified_cr_part(range)
  end

  def self.generate_summary(range)
    output = "Summary\n"
    line_counter = 1
    ocr = get_common_tasks range
    for task in ocr 
      output =output + line_counter.to_s + ". " + task.task + "\n"
      line_counter = line_counter +1
    end
    if(get_opened_cr(range).length>0)
      output = output+line_counter.to_s+ ". "+ "Opened #{get_opened_cr(range).length} CRs\n"
      line_counter = line_counter + 1
    end
    if(get_verified_cr(range).length>0)
      output = output+line_counter.to_s+ ". "+ "Verified #{get_verified_cr(range).length} CRs\n"
      line_counter = line_counter + 1
    end
    return output
  end

  def self.generate_opened_cr_part(range)
    ocr = get_opened_cr(range)
    if(ocr.length>0) 
      output = "Opened CRs\n"
      line_counter = 1
      for task in ocr 
        output =output + line_counter.to_s + ". " + task.task + "\n"
        line_counter = line_counter +1
      end
      return output
    else
      ""
    end
  end

  def self.generate_verified_cr_part(range)
    ocr = get_verified_cr(range)
    if(ocr.length>0)
      output = "Verified CRs\n"
      line_counter = 1
      for task in ocr 
        output =output + line_counter.to_s + ". " + task.task + "\n"
        line_counter = line_counter +1
      end
      return output
    else
      ""
    end
  end

  def self.get_verified_cr(range)
    verified_crs = [] 
    for task in all_tasks(range)
      if task.type == LogType::VCR
        verified_crs << task
      end
    end
    return verified_crs
  end

  def self.get_opened_cr(range)
    opened_crs =[] 
    for task in all_tasks(range)
      if task.type == LogType::FCR
        opened_crs << task
      end
    end
    return opened_crs
  end

  def self.get_common_tasks(range)
    common_tasks =[] 
    for task in all_tasks(range)
      if task.type == LogType::COMMON
        common_tasks << task
      end
    end
    return common_tasks
  end

end
#puts TaskLogger.generate_opened_cr_part
#puts TaskLogger.generate_verified_cr_part
#puts TaskLogger.generate_summary( "0w")
