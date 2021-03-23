class Facility < ApplicationRecord
  has_many :patients
  has_many :primary_facilities, class_name: "Facility", foreign_key: "parent_id"
  belongs_to :secondary_facility, class_name: "Facility", optional: true, foreign_key: "parent_id"

  def index
  end
end
