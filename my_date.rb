require 'date'

module Eric
  module EDate
    def weeks_from_now
      return DateTime.now.cweek - self.cweek
    end
    def months_from_now
      return DateTime.now.month - self.month
    end
    def days_from_now
      return DateTime.now.yday - self.yday
    end
    def fall_into(range)
      case range.unit
      when :week
        return weeks_from_now == range.amount
      when :month
        return months_from_now == range.amount
      else
        return days_from_now == range.amount
      end
    end
  end
end
class DateTime
  include Eric::EDate
end
