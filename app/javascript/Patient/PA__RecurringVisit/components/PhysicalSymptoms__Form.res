type t = PhysicalSymptoms__Form__Type.t
let general_options = [
  "Not selected",
  "Not at all",
  "Slightly",
  "Moderately",
  "Severely",
  "Overwhelmingly",
  "Cannot assess",
]
let toString = optionString => Js.Option.getWithDefault("", optionString)
type state = {show_optional: bool, form_data: PhysicalSymptoms__Form__Type.t}
let s = React.string
let initialState = {show_optional: false, form_data: PhysicalSymptoms__Form__Type.make()}

@react.component
let make = (~data: t) => {
  let role = "nurse"
  let required = if role == "nurse" {
    ["vomiting", "poor_appetite", "lack_of_sleep", "micturition"]
  } else if role == "physio" {
    ["pain", "shortness_breath", "weakness", "poor_mobility"]
  } else {
    []
  }

  let questions = [
    ("Do you think patient feels at peace?", "patient_at_peace", data.patient_at_peace),
    ("Pain", "pain", data.pain),
    ("Shortness of breath", "shortness_breath", data.shortness_breath),
    ("Weakness/Lack of energy", "weakness", data.weakness),
    ("Poor mobility", "poor_mobility", data.poor_mobility),
    ("Nausea", "nausea", data.nausea),
    ("Constipation", "constipation", data.constipation),
    ("Sore/dry mouth", "sore", data.sore),
    ("Drowsiness", "drowsiness", data.drowsiness),
    ("Wound", "wound", data.wound),
    ("Vomiting", "vomiting", data.vomiting),
    ("Poor Appetite", "poor_appetite", data.poor_appetite),
    ("Lack of sleep", "lack_of_sleep", data.lack_of_sleep),
    ("Micturition", "micturition", data.micturition),
  ]

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
      {questions
      ->Js.Array2.filter(((_q, fieldName, _f)) => required->Js.Array2.includes(fieldName))
      ->Belt.Array.map(((ques, field, value)) =>
        <DropDownInput
          question=ques
          field
          value={toString(value)}
          options=general_options
          isRequired=true
          key=field
        />
      )
      ->React.array}
    </div>
    <br />
    <hr />
    <br />
    <div className={`font-bold text-lg ml-4 ${optional_section_class}`}> {s("Optional")} </div>
    <div className={`grid lg:grid-cols-2 mx-auto lg:pl-10 ${optional_section_class}`}>
      {questions
      ->Js.Array2.filter(((_q, fieldName, _f)) => !(required->Js.Array2.includes(fieldName)))
      ->Belt.Array.map(((ques, field, value)) =>
        <DropDownInput
          question=ques
          field
          value={toString(value)}
          options=general_options
          isRequired=false
          key=field
        />
      )
      ->React.array}
      <DropDownInput
        question="Wound"
        field="wound"
        value={toString(data.wound)}
        options=general_options
        isRequired=false
        key="wound"
      />
      <WoundPushScore />
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
