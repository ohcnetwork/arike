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
  ("Is patient depressed", "patient_depressed", true),
  ("Does family/friends feel anxious about patient's illness/treatment", "family_anxious", true),
  (
    "Has the patient been able to share how he is feeling with his family/friends as much as he wanted?",
    "patient_feels",
    true,
  ),
  ("Has the patient had as much information as he wanted?", "patient_informed", true),
]
@react.component
let make = () => {
    <div>
    <div className="font-bold text-xl mb-5">{s("Psychological Review")}</div>
      <div className="grid grid-cols-6 ">
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
        className="mt-4 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
      </div>
  </div>
}
