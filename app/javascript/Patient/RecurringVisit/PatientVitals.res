let s = React.string

let general_options = [
  "Not selected",
  "Not at all",
  "Slightly",
  "Moderately",
  "Severely",
  "Overwhelmingly",
  "Cannot assess",
]

let general_questions = [
  ("Is the patient feeling worried about illness/treatment?", "patient_worried", true),
  ("Does family/friends feel anxious about patient's illness/treatment", "family_anxious", true),
  (
    "Has the patient been able to share how he is feeling with his family/friends as much as he wanted?",
    "patient_feels",
    true,
  ),
  ("Is patient depressed", "patient_depressed", true),
  ("Has the patient had as much information as he wanted?", "patient_informed", true),
  ("Do you think patient feels at peace?", "patient_at_peace", true),
  ("Pain", "pain", false),
  ("Shortness of breath", "shortness_breath", false),
  ("Weakness/Lack of energy", "weakness", false),
  ("Poor mobility", "poor_mobility", false),
  ("Nausea", "nausea", false),
  ("Vomiting", "vomiting", false),
  ("Poor Appetite", "poor_Appetite", false),
  ("Constipation", "constipation", false),
  ("Sore/dry mouth", "sore", false),
  ("Drowsiness", "drowsiness", false),
  ("Wound", "wound", false),
  ("Lack of sleep", "lack_of_sleep", false),
  ("Micturition", "micturition", false),
]

/* Add State for capturing data */
@react.component
let make = (~name, ~role) => {
  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-3xl mx-auto">
      <form className="space-y-8 " id="patientvitals-form">
        <div className="space-y-8 sm:space-y-5">
          <div>
            <div>
              <h3 className="text-lg leading-6 font-medium text-gray-900">
                {s("Current disease status and Patient vitals")}
              </h3>
              <p className="mt-1 mb-5 max-w-2xl text-sm text-gray-500">
                {s("Captured during every visit")}
              </p>
            </div>
            <div
              className="mt-6 sm:mt-5 space-y-6 sm:space-y-5 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
              <NumberInput
                question="Patient's general health status(AKPS)"
                field="AKPS"
                minimum=Some(0)
                maximum=Some(100)
                divClass="sm:col-span-6 field sm:grid sm:grid-cols-2 sm:gap-4 sm:items-start  sm:pt-5"
                isRequired=true
              />
              <RadioInput
                question="Any changes in disease history?"
                field="disease_history_radio"
                options=["Yes", "No"]
                isRequired=true
              />
              <TextInput
                question="Enter details."
                field="disease_history_changed"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=true
                defaultValue=""
              />
              <DropDownInput
                question="Palliative phase of illness"
                field="palliative_phase"
                options=["Not selected", "Stable", "Unstable", "Deteriorating", "Dying"]
                isRequired=true
              />
              {general_questions
              ->Belt.Array.map(((ques, field, required)) =>
                <DropDownInput
                  question=ques field options=general_options isRequired=required key=field
                />
              )
              ->React.array}
              <NumberInput
                question="BP"
                field="bp"
                minimum=None
                maximum=None
                divClass="sm:col-span-3 field"
                isRequired=false
              />
              <NumberInput
                question="GRBS"
                field="grbs"
                minimum=None
                maximum=None
                divClass="sm:col-span-3 field"
                isRequired=false
              />
              <NumberInput
                question="RR"
                field="rr"
                minimum=None
                maximum=None
                divClass="sm:col-span-3 field"
                isRequired=false
              />
              <NumberInput
                question="Pulse"
                field="pulse"
                minimum=None
                maximum=None
                divClass="sm:col-span-3 field"
                isRequired=false
              />
              <TextInput
                question="Personal hygiene"
                field="personal_hygiene"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=false
                defaultValue=""
              />
              <TextInput
                question="Mouth hygiene"
                field="mouth_hygiene"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=false
                defaultValue=""
              />
              <TextInput
                question="Pubic hygiene"
                field="pubic_hygiene"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=false
                defaultValue=""
              />
              <DropDownInput
                question="Systematic examination"
                field="systemic_examination"
                options=[
                  "Cardiovascular",
                  "Gastrointestinal",
                  "Central nervous system",
                  "Respiratory",
                  "Genital-urinary",
                ]
                isRequired=false
              />
              <TextInput
                question="Systematic examination details"
                field="systemic_examination_details"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=false
                defaultValue=""
              />
              <TextInput
                question="Visit done by(Doctor/Nurse/Volunteer/ASHA/Driver):"
                field="done_by"
                form_id="patientvitals-form"
                divClass="sm:col-span-3 field"
                isRequired=true
                defaultValue={`${name}(${role})`}
              />
            </div>
          </div>
        </div>
        <div className="pt-5">
          <div className="flex justify-end">
            <button
              type_="button"
              className="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {s("Cancel")}
            </button>
            <button
              type_="submit"
              className="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {s("Submit")}
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
}
