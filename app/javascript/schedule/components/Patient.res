@val external window: {..} = "window"
type patient = Schedule__Types.patient

let s = React.string

@react.component
let make = (~patient: patient, ~selectPatient) => {
  <li
    onClick={_ => {
      selectPatient(patient)
    }}
    className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200 hover:bg-gray-100 flex items-center">
    <div className="w-full flex justify-between p-6 space-x-6">
      <div className="flex-1 truncate">
        <div className=" items-center space-x-3 justify-self-start">
          <h3
            className="text-gray-900 text-md font-bold"
            onClick={_ => {
              window["location"]["href"] = `patients/${patient.id}`
              Js.Global.setTimeout(() => (), 100000000)->ignore
            }}>
            {s(patient.name)} <i className="fas fa-info-circle ml-2" />
          </h3>
        </div>
        <div className="grid min-w-max">
          {patient.procedures
          ->Belt.Array.map(procedure =>
            <p key={procedure} className="text-gray-500 sm:inline sm:mx-1 text-sm">
              {s(procedure)}
            </p>
          )
          ->React.array}
        </div>
      </div>
      <div className="mt-2 min-w-max text-sm sm:mt-0 sm:ml-4 sm:text-right">
        <span
          className="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
          {s(`ward ` ++ patient.ward->Belt.Int.toString)}
        </span>
        <div className="font-bold text-sm text-red-400">
          {
            let diff = Schedule__Utils.jsdiffInDays(Js.Date.now(), patient.next_visit)
            diff >= 0
              ? s(` ${diff->Belt.Int.toString} days`)
              : s(` Overdue by ${-diff->Belt.Int.toString} days`)
          }
        </div>

        //   <div className="ml-1 text-gray-500 text-sm sm:ml-0">
        //     {s(Js.Date.toLocaleDateString(patient.next_visit))}
        //   </div>
        //   <div className="ml-1 text-gray-500 text-sm sm:ml-0">
        //     {s(Js.Date.toLocaleDateString(patient.last_visit))}
        //   </div>
      </div>
    </div>
  </li>
}
