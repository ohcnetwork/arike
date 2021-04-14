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
  ("Poor Appetite", "poor_appetite", false),
  ("Constipation", "constipation", false),
  ("Sore/dry mouth", "sore", false),
  ("Drowsiness", "drowsiness", false),
  ("Wound", "wound", false),
  ("Lack of sleep", "lack_of_sleep", false),
  ("Micturition", "micturition", false),
]
let s = React.string
@react.component
let make = () => {
  let (isEnabled_diseaseHistory, _changeEnabled_diseaseHistory) = React.useState(_ => false)
  let (_isEnabled_systemic, _changeEnabled_systemic) = React.useState(_ => false)
  <div>
    <div className="sm:col-span-3 field">
      <label className="block text-sm font-medium text-gray-700"> {s("Enter details.")} </label>
      <div className="mt-1">
        <textarea
          type_="text"
          name="disease_history_changed"
          cols=50
          rows=1
          id="patientvitals-form"
          required=true
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    {general_questions
    ->Belt.Array.map(((ques, field, required)) =>
      <DropDownInput question=ques field options=general_options isRequired=required key=field />
    )
    ->React.array}
  </div>
}
