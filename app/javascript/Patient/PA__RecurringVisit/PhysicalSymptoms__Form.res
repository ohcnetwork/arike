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
  <div>
    <div className="font-bold text-xl mb-5">{s("Physical Symptoms")}</div>
    <div className="grid grid-cols-1 sm:grid-cols-6">
      {general_questions
      ->Belt.Array.map(((ques, field, required)) =>
        <DropDownInput question=ques field options=general_options isRequired=required key=field />
      )
      ->React.array}
    </div>
    <div className="actions">
      <input
        type_="submit"
        value="Next"
        className="mt-8 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
      </div>
  </div>
}
