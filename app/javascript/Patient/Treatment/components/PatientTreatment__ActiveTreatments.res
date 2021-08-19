let s = React.string

open PatientTreatment__Types

@react.component
let make = (~patientId, ~treatments) => {
  let treatmentList =
    treatments->Js.Array2.map(treatment =>
      <li key={treatment->Treatment.id} className="block hover:bg-gray-50">
        <div className="px-4 py-4 sm:px-6">
          <div className="flex justify-between">
            <div className="flex flex-col justify-evenly">
              <p className="text-sm font-medium text-indigo-600 truncate">
                {s(treatment->Treatment.category)}
              </p>
              <p className="flex items-center text-lg text-gray-500">
                {s(treatment->Treatment.name)}
              </p>
            </div>
            <div>
              <button
                type_="submit"
                name={`treatment`}
                value={treatment->Treatment.id}
                className="px-2 py-2 border min-w-max border-red-500 text-center text-sm leading-4 font-medium rounded-md text-red-700 bg-white hover:text-red-500 focus:outline-none focus:border-red-300 focus:shadow-outline-blue active:text-red-800 active:bg-gray-50 transition ease-in-out duration-150 hover:shadow">
                {s("Stop Treatment")}
              </button>
            </div>
          </div>
        </div>
      </li>
    )

  {
    if treatmentList->Js.Array2.length > 0 {
      <div className="bg-white shadow overflow-hidden sm:rounded-md">
        <ul className="divide-y divide-gray-200">
          <form
            action={`/patients/${patientId}/treatment/stop_treatment`}
            method="POST"
            className="block hover:bg-gray-50">
            <input type_="hidden" name="_method" value="put" />
            <input type_="hidden" name="authenticity_token" value={AuthenticityToken.fromHead()} />
            {treatmentList->React.array}
          </form>
        </ul>
      </div>
    } else {
      <p className="bg-gray-100 p-8"> {s("No current treatments")} </p>
    }
  }
}
