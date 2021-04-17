let s = React.string

open PatientTreatment__Types

@react.component
let make = (~activeTreatments, ~removeClickHandler) => {
  <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
    {if activeTreatments->Belt.Array.length == 0 {
      <h4> {s("No treatments added")} </h4>
    } else {
      activeTreatments
      ->Belt.Array.map(treatment =>
        <li
          key={treatment->Treatment.id}
          className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
          <div className="w-full flex justify-between p-6 space-x-6">
            <div className="flex-1">
              <div className="text-sm align-top">
                {s(treatment->Treatment.created_at->Js.Date.toDateString)}
              </div>
              <div className="flex items-center space-x-3">
                <h3 className="text-gray-900 text-lg font-semibold">
                  {s(treatment->Treatment.name)}
                </h3>
              </div>
            </div>
          </div>
          <div className="-mt-px flex divide-x divide-gray-200">
            <div className="w-0 flex-1 flex">
              <button
                onClick={_ => removeClickHandler(treatment->Treatment.id)}
                className="relative -mr-px w-0 flex-1 inline-flex items-center justify-center py-4 text-sm text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500">
                <span className="ml-3"> {s("Remove")} </span>
              </button>
            </div>
          </div>
        </li>
      )
      ->React.array
    }}
  </ul>
}
