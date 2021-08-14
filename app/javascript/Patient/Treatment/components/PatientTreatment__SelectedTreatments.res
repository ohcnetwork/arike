let s = React.string

open PatientTreatment__Types

@react.component
let make = (~selectedTreatments, ~removeClickHandler) => {
  <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
    {if selectedTreatments->Belt.Array.length == 0 {
      <h4> {s("No treatments selected")} </h4>
    } else {
      selectedTreatments
      ->Belt.Array.map(treatment =>
        <li
          key={treatment->DropdownOption.id}
          className="flex flex-col justify-between col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
          <div className="w-full flex flex-grow justify-between p-6 space-x-6">
            <div className="flex flex-col items-left">
              <h3 className="text-gray-700 text-base font-medium">
                {s(treatment->DropdownOption.category)}
              </h3>
              <h3 className="text-gray-900 text-lg font-semibold">
                {s(treatment->DropdownOption.name)}
              </h3>
            </div>
          </div>
          <div className="-mt-px flex flex-grow-0 divide-x divide-gray-200">
            <div className="w-0 flex-1 flex">
              <button
                onClick={_ => removeClickHandler(treatment)}
                className="relative mb-0 -mr-px w-0 flex-1 inline-flex items-center justify-center py-2 text-sm text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500">
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
