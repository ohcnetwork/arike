let general_options = [
  "Not selected",
  "Not at all",
  "Slightly",
  "Moderately",
  "Severely",
  "Overwhelmingly",
  "Cannot assess",
]

let optional_questions = [
  ("Do you think patient feels at peace?", "patient_at_peace", true),
  ("Pain", "pain", false),
  ("Shortness of breath", "shortness_breath", false),
  ("Weakness/Lack of energy", "weakness", false),
  ("Poor mobility", "poor_mobility", false),
  ("Nausea", "nausea", false),

  ("Constipation", "constipation", false),
  ("Sore/dry mouth", "sore", false),
  ("Drowsiness", "drowsiness", false),
  ("Wound", "wound", false),
]
let required_questions = [
  ("Vomiting", "vomiting", false),
  ("Poor Appetite", "poor_appetite", false),
  ("Lack of sleep", "lack_of_sleep", false),
  ("Micturition", "micturition", false),
]
let s = React.string

@react.component
let make = () => {
  <div className="lg:w-10/12">
    <div className="font-bold text-xl mb-5"> {s("Physical Symptoms")} </div>
    <div className="grid lg:grid-cols-2 mx-auto lg:pl-10">
        {required_questions
        ->Belt.Array.map(((ques, field, required)) =>
          <DropDownInput question=ques field options=general_options isRequired=required key=field />
        )
        ->React.array}
    </div>
     <br />
     <hr />
     <br />
     <div className="font-bold text-lg ml-4">{s("Optional")}</div>
     <div className="grid lg:grid-cols-2 mx-auto lg:pl-10">
        {optional_questions
        ->Belt.Array.map(((ques, field, required)) =>
          <DropDownInput question=ques field options=general_options isRequired=required key=field />
        )
        ->React.array}
     </div>
    <div className="actions flex justify-center">
      <input
        type_="submit"
        value="Save & Next"
        className="mt-8 px-6 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
    </div>
  </div>
}
