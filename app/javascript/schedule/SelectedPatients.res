let s = React.string

module SelectedPatient = {
  @react.component
  let make = (~patient, ~unselectPatient) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex items-center justify-between p-6 space-x-6">
        <div className="flex-1 truncate">
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-sm font-medium truncate"> {s(patient["name"])} </h3>
            <span
              className="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
              {s(`ward ${patient["ward"]->Belt.Int.toString}`)}
            </span>
          </div>
        </div>
        <button onClick={_ => unselectPatient(patient)}> <i className="fas fa-times" /> </button>
      </div>
    </li>
  }
}

@react.component
let make = (~selectedPatients, ~unselectPatient) => {
  let selectedPatientList =
    selectedPatients->Js.Array2.map(patient =>
      <SelectedPatient key={patient["id"]} patient unselectPatient />
    )

  <div className={selectedPatients->Js.Array2.length == 0 ? "hidden" : "bg-gray-100 py-8 my-4"}>
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {selectedPatientList->React.array}
      </ul>
    </div>
  </div>
}
