class FamilyDetail < ApplicationRecord
  belongs_to :patient
  enum relations: {
    mother: "Mother",
    father: "Father",
    sister: "Sister",
    brother: "Brother",
    spouse: "Spouse",
    son: "Son",
    daughter: "Daughter",
    son_in_law: "Son-in-law",
    daughter_in_law: "Daughter-in-law",
    grandson: "Grandson",
    granddaughter: "Granddaughter",
    uncle: "Uncle",
    aunt: "Aunt",
    niece: "Niece",
    nephew: "Nephew",
  }
  enum educations: {
    uneducated: "Uneducated",
    less_than_ten: "Less than 10th standard",
    ten_standard: "10th Standard",
    twelve_standard: "12th Standard",
    graduate: "Graduate",
    post_graduate: "Post Graduate"
  }
  enum occupations: {
    jobless: "Jobless",
    homemaker: "Homemaker",
    public_servant: "Public Servant",
    private_job: "Private Job",
    business: "Business"
  }
  validates :relation, inclusion: {
    in: relations.values,
    message: "%{value} is not a valid relation",
  }
  validates :full_name, presence: true, length: { minimum: 1 }
end
