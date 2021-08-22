let s = React.string

open PatientTreatment__Types

@react.component
let make = (~patientId, ~treatments) => {
  let treatmentList =
    treatments->Js.Array2.map(treatment =>
      <div
        key={`active_${treatment->Treatment.id}`}
        className="bg-white shadow col-span-1 rounded-md px-6 py-4">
        <div className="space-y-4">
          <div className="flex flex-col justify-evenly">
            <p className="text-base font-medium text-indigo-600 truncate">
              {s(treatment->Treatment.category)}
            </p>
            <p className="flex items-center text-xl text-gray-600">
              {s(treatment->Treatment.name)}
            </p>
          </div>
          <div>
            <p className="text-gray-500 pb-1 text-xs">
              {s(`Started on: ${treatment->Treatment.created_at->Js.Date.toDateString}`)}
            </p>
            <div className="text-base text-gray-600"> {s("Description:")} </div>
            <div className="text-sm">
              {s(treatment->Treatment.description |> Js.Option.getWithDefault("-"))}
            </div>
          </div>
        </div>
        <div className="mt-2 flex justify-end">
          <button
            type_="submit"
            name={`treatment`}
            value={treatment->Treatment.id}
            className="px-2 py-2 border min-w-max border-red-500 text-center text-sm leading-4 font-medium rounded-md text-red-700 bg-white hover:text-red-500 focus:outline-none focus:border-red-300 focus:shadow-outline-blue active:text-red-800 active:bg-gray-50 transition ease-in-out duration-150 hover:shadow">
            {s("Stop Treatment")}
          </button>
        </div>
      </div>
    )

  {
    if treatmentList->Js.Array2.length > 0 {
      <div>
        <form
          action={`/patients/${patientId}/treatment/stop_treatment`}
          method="POST"
          className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input type_="hidden" name="_method" value="put" className="divide-y divide-gray-200" />
          <input type_="hidden" name="authenticity_token" value={AuthenticityToken.fromHead()} />
          {treatmentList->React.array}
        </form>
      </div>
    } else {
      <p className="bg-gray-100 p-8"> {s("No current treatments")} </p>
    }
  }
}
