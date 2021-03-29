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
end
