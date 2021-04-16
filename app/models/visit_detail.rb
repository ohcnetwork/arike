class VisitDetail < ApplicationRecord
  enum sections: {
      general_health_information: "General Health Information",
      psychological_review: "Psychological Review",
      physical_symptoms_required: "Physical Symptoms (Required)",
      physical_symptoms_optional: "Physical Symptoms (Optional)",
      physical_information: "Physical Information"
    }
end
