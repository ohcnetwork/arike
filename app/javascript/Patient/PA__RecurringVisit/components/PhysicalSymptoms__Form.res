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
type state = {show_optional: bool, form_data: PhysicalSymptoms__Form__Type.t}
let s = React.string
let initialState = {show_optional: false, form_data: PhysicalSymptoms__Form__Type.make()}

@react.component
let make = () => {
  let (state, setState) = React.useState(_ => initialState)
  let optional_section_class = if state.show_optional {
    "visible"
  } else {
    "hidden"
  }
  let bgColor = if state.show_optional {
    "bg-indigo-600"
  } else {
    "bg-gray-200"
  }
  let translate = if state.show_optional {
    "translate-x-5"
  } else {
    "translate-x-0"
  }

  <div className="lg:w-10/12">
    <div className="font-bold text-xl mb-5 flex justify-between">
      <div> {s("Physical Symptoms")} </div>
      <div className="px-8 flex items-center bg-white">
        <h1 className="text-sm font-medium mx-1 my-2"> {s("Show Optional")} </h1>
        <button
          onClick={mouseEvt => {
            mouseEvt->ReactEvent.Mouse.preventDefault
            setState(state => {...state, show_optional: !state.show_optional})
          }}
          type_="button"
          className={`${bgColor} relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500`}>
          // { 'bg-indigo-600': on, 'bg-gray-200': !(on) }
          <span className="sr-only"> {s("Show Optional")} </span>
          // { 'translate-x-5': on, 'translate-x-0': !(on) }
          <span
            className={`${translate} pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow transform ring-0 transition ease-in-out duration-200`}
          />
        </button>
      </div>
    </div>
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
    <div className={`font-bold text-lg ml-4 ${optional_section_class}`}> {s("Optional")} </div>
    <div className={`grid lg:grid-cols-2 mx-auto lg:pl-10 ${optional_section_class}`}>
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
