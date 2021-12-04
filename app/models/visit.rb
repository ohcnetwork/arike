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

  def self.unscheduled_patients
    unscheduled_visits = all.where(next_visit: nil)
    unscheduled_visits.map do |visit|
      {
        name: visit.patient.full_name,
        id: visit.patient_id,
        ward: visit.patient.facility.ward.number,
        procedures: ["Wound Care",
          "Nail Cut",
          "Simple Check",
          "Through Check",
          "Foley’s catheterisation",
          "Urostomy care",
          "PEG care",
          "Colostomy care","Perennial care",
          "Condom catheterisation & training",
          "Nelcath catheterisation & training",
          "Foley’s catheterisation",
         "Foley’s catheter care",
          "Suprapubic catheterisation",
          "Suprapubic catheter care",
          "Bladder wash with normal saline",
          "Bladder wash with soda bicarbonate",
          "Urostomy care"].sample(rand(5)+1),
        last_visit: Date.parse(visit.last_visit.to_s),
        next_visit: Date.parse(visit.expected_visit.to_s),
      }
    end
  end

  def self.scheduled_patients
    scheduled_visits = all.where.not(next_visit: nil)
    
    scheduled_patients = {}
    scheduled_visits.each do |visit|
      patient = {
        name: visit.patient.full_name,
        id: visit.patient_id,
        ward: visit.patient.facility.ward.number,
      }
      if scheduled_patients[visit.next_visit]
        scheduled_patients[visit.next_visit].append(patient)
      else
        scheduled_patients[visit.next_visit] = [patient]
      end
    end

    
    scheduled_patients.keys.map do |next_visit|
      {
        next_visit: next_visit.to_s,
        patients: scheduled_patients[next_visit]
      }
    end
  end

  def self.schedule(patient_id, date)
    visit = all.where(patient_id: patient_id)[0]
    visit.next_visit = date
    visit.save
  end

  def self.unschedule(patient_id)
    visit = all.where(patient_id: patient_id)[0]
    visit.next_visit = nil
    visit.save
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
