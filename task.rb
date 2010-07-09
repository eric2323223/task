require File.dirname(__FILE__)+"/task_logger.rb"

def usage
  puts open(File.dirname(__FILE__)+"/usage.txt").read
end

def add_handler(args)
  if args.length == 2
    TaskLogger.log(args[1])
    puts "Task [#{args[1]}] is added."
  else
    usage
  end
end

def list_handler(args)
  if(args.length == 2)
    for task in TaskLogger.all_tasks(args[1])
      puts task.task
    end
  else
    usage
  end
end

def remove_handler(args)

end

def report_handler(args)
  if(args.length==2)
    TaskLogger.generate_report(args[1]) 
  else
    usage
  end
end

case ARGV[0]
when /(add)|(^a$)/i
  add_handler(ARGV)
when /(list)|(^l$)/i
  list_handler(ARGV)
when /report/i
  report_handler(ARGV)
else
  usage
end
