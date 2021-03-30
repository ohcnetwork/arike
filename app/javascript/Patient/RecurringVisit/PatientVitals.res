let s = React.string

let general_options = [
  "Not at all",
  "Slightly",
  "Moderately",
  "Severely",
  "Overwhelmingly",
  "Cannot assess",
]

let general_questions = [
  ("Is the patient feeling worried about illness/treatment?", "patient_worried"),
  ("Does family/friends feel anxious about patient's illness/treatment", "family_anxious"),
  (
    "Has the patient been able to share how he is feeling with his family/friends as much as he wanted?",
    "patient_feels",
  ),
  ("Is patient depressed", "patient_depressed"),
  ("Has the patient had as much information as he wanted?", "patient_informed"),
  ("Do you think patient feels at peace?", "patient_at_peace"),
  ("Pain", "pain"),
  ("Shortness of breath", "shortness_breath"),
  ("Weakness/Lack of energy", "weakness"),
  ("Poor mobility", "poor_mobility"),
  ("Nausea", "nausea"),
  ("Vomiting", "vomiting"),
  ("Poor Appetite", "poor_Appetite"),
  ("Constipation", "constipation"),
  ("Sore/dry mouth", "sore"),
  ("Drowsiness", "drowsiness"),
  ("Wound", "wound"),
  ("Lack of sleep", "lack_of_sleep"),
  ("Micturition", "micturition"),
]

/* Add State for capturing data */
module PatientVitals = {
  @react.component
  let make = () => {
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
                />
                <TextInput
                  question="Any change in disease history? If yes, enter details."
                  field="disease_history_changed"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-6 field sm:grid sm:grid-cols-2 sm:gap-4 sm:items-start sm:pt-5"
                />
                <DropDownInput
                  question="Palliative phase of illness"
                  field="palliative_phase"
                  options=["Stable", "Unstable", "Deteriorating", "Dying"]
                />
                {general_questions
                ->Belt.Array.map(((ques, field)) =>
                  <DropDownInput question=ques field options=general_options />
                )
                ->React.array}
                <NumberInput
                  question="BP" field="bp" minimum=None maximum=None divClass="sm:col-span-3 field"
                />
                <NumberInput
                  question="GRBS"
                  field="grbs"
                  minimum=None
                  maximum=None
                  divClass="sm:col-span-3 field"
                />
                <NumberInput
                  question="RR" field="rr" minimum=None maximum=None divClass="sm:col-span-3 field"
                />
                <NumberInput
                  question="Pulse"
                  field="pulse"
                  minimum=None
                  maximum=None
                  divClass="sm:col-span-3 field"
                />
                <TextInput
                  question="Personal hygiene"
                  field="personal_hygiene"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-3 field"
                />
                <TextInput
                  question="Mouth hygiene"
                  field="mouth_hygiene"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-3 field"
                />
                <TextInput
                  question="Pubic hygiene"
                  field="pubic_hygiene"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-3 field"
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
                />
                <TextInput
                  question="Systematic examination details"
                  field="systemic_examination_details"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-3 field"
                />
                <TextInput
                  question="Visit done by: Dr./Volunteer/ASHA/Driver"
                  field="done_bydone_by"
                  form_id="patientvitals-form"
                  divClass="sm:col-span-3 field"
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
}

let run = () => {
  switch ReactDOM.querySelector("#patient-vitals-form") {
  | Some(root) => ReactDOM.render(<div> <PatientVitals /> </div>, root)
  | None => () // do nothing
  }
}
