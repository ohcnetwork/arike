class Visit < ApplicationRecord
  belongs_to :patient

  def self.working_day(inc, initial_date=Date.today)
    cwday = initial_date.cwday
    if cwday == 7
      inc = inc + 1
    elsif cwday == 6
      inc = inc + 2
    else
      cwday = cwday + inc
      if cwday == 7 || cwday == 6
        inc = inc + 2
      end
    end

    initial_date+inc
  end

  def self.unscheduled_visits
    all.where(next_visit: nil)
  end

  def self.scheduled_visits_on(date)
    all.where(next_visit: date)
  end

  def record_on(date)
    records[date]
  end

  def latest_record
    records[last_visit.to_date.to_s]
  end

  def first_record
    records[first_visit.to_date.to_s]
  end
end
