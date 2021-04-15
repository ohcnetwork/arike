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
]
@react.component
let make = () => {
    <div className="grid grid-cols-2 sm:grid-cols-6">
    {general_questions
    ->Belt.Array.map(((ques, field, required)) =>
      <DropDownInput question=ques field options=general_options isRequired=required key=field />
    )
    ->React.array}
  </div>
}
