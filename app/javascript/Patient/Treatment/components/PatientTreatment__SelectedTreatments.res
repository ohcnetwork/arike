let s = React.string

open PatientTreatment__Types

@react.component
let make = (~selectedTreatments, ~removeClickHandler) => {
  <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-2">
    {if selectedTreatments->Belt.Array.length == 0 {
      <h4> {s("No treatments selected")} </h4>
    } else {
      selectedTreatments
      ->Belt.Array.map(treatment =>
        <li
          key={`selected_${treatment->SelectedTreatment.id}`}
          className="flex flex-col justify-between col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
          <div className="px-6 py-4">
            <div className="w-full flex flex-grow justify-between">
              <div className="flex flex-col items-left">
                <h3
                  className="text-gray-700 text-base font-medium"
                  name={`treatments[${treatment->SelectedTreatment.id}][category]`}>
                  {s(treatment->SelectedTreatment.category)}
                </h3>
                <input
                  type_="hidden"
                  name={`treatments[${treatment->SelectedTreatment.id}][category]`}
                  value={treatment->SelectedTreatment.category}
                />
                <h3
                  className="text-gray-900 text-lg font-semibold"
                  name={`treatmnents[${treatment->SelectedTreatment.id}][name]`}>
                  {s(treatment->SelectedTreatment.name)}
                </h3>
                <input
                  type_="hidden"
                  name={`treatments[${treatment->SelectedTreatment.id}][name]`}
                  value={treatment->SelectedTreatment.name}
                />
              </div>
            </div>
            <div className="w-full p-1">
              <textarea
                name={`treatments[${treatment->SelectedTreatment.id}][description]`}
                placeholder="Description"
                className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md max-h-32 h-32"
              />
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
  </div>
}
