class FamilyDetail < ApplicationRecord
  belongs_to :patient
  enum relations: {
    mother: "Mother",
    father: "Father",
    sister: "Sister",
    brother: "Brother",
    spouse: "Spouse",
    other: "Other",
  }
end
