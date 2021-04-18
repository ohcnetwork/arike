@val external window: {..} = "window"

let s = React.string

module SelectedPatient = {
  @react.component
  let make = (~patient: Schedule__type.unscheduled_patient, ~unselectPatient) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex items-center justify-between p-6 space-x-6">
        <div className="flex-1 truncate">
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-sm font-medium truncate"> {s(patient.name)} </h3>
            <span
              className="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
              {s(`ward ${patient.ward->Belt.Int.toString}`)}
            </span>
          </div>
        </div>
        <button onClick={_ => unselectPatient(patient)}> <i className="fas fa-times" /> </button>
      </div>
    </li>
  }
}

@react.component
let make = (~selectedPatients: array<Schedule__type.unscheduled_patient>, ~unselectPatient) => {
  let (date, setDate) = React.useState(_ => "")

  let onDateChange = event => {
    let value = ReactEvent.Synthetic.currentTarget(event)["value"]
    setDate(_ => value)
  }

  let onSubmit = _ => {
    if date != "" {
      {
        let patients = selectedPatients->Belt.Array.map(patient => patient.id)
        let payload = Js.Dict.empty()
        Js.Dict.set(payload, "date", Js.Json.string(date))
        Js.Dict.set(payload, "patients", Js.Json.stringArray(patients))

        Fetch.fetchWithInit(
          "/schedule",
          Fetch.RequestInit.make(
            ~method_=Post,
            ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
            ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
            (),
          ),
        ) |> Js.Promise.then_(_ => window["location"]["reload"](true)->ignore |> Js.Promise.resolve)
      }->ignore
    }
  }

  let selectedPatientList =
    selectedPatients->Js.Array2.map(patient =>
      <SelectedPatient key={patient.id} patient unselectPatient />
    )

  <div className={selectedPatients->Js.Array2.length == 0 ? "hidden" : "bg-gray-100 py-8 my-4"}>
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {selectedPatientList->React.array}
      </ul>
      <div className="text-center">
        <input onChange={onDateChange} type_="date" className=" rounded-md my-6 mx-4" />
        <button
          onClick={onSubmit}
          className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none">
          {s("schedule")}
        </button>
      </div>
    </div>
  </div>
}
