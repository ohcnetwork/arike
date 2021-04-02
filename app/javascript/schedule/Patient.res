let s = React.string

@react.component
let make = (~patient) => {
  <li
    id="radiogroup-option-1"
    className="group relative bg-white rounded-lg shadow-sm cursor-pointer focus:outline-none focus:ring-1 focus:ring-offset-2 focus:ring-indigo-500 list-none">
    <div
      className="rounded-lg border items-center border-gray-300 bg-white px-6 py-4 hover:border-gray-400 sm:flex sm:justify-between">
      <div>
        <div className="flex items-center">
          <p className="font-extrabold text-xl text-gray-900"> {s(patient["name"])} </p>
          <div className="grid grid-cols-2 min-w-max">
            {patient["diseases"]
            ->Belt.Array.map(disease =>
              <p className="text-gray-500 sm:inline sm:mx-1">
                {s(Js.String.slice(~from=0, ~to_=10, disease))}
              </p>
            )
            ->React.array}
          </div>
        </div>
        <div className="grid grid-cols-3 min-w-max">
          {patient["procedures"]
          ->Belt.Array.map(procedure =>
            <p className="text-gray-500 sm:inline sm:mx-1">
              {s(Js.String.slice(~from=0, ~to_=10, procedure))}
            </p>
          )
          ->React.array}
        </div>
      </div>
      <div className="text-gray-500 text-sm sm:ml-0"> {s(patient["notes"])} </div>
      <div className="mt-2 min-w-max text-sm sm:mt-0 sm:ml-4 sm:text-right">
        <div className="font-extrabold text-xl text-gray-900"> {s("2 days")} </div>
        <div className="ml-1 text-gray-500 sm:ml-0">
          {s(Js.Date.toDateString(patient["next_visit"]))}
        </div>
        <div className="ml-1 text-gray-500 sm:ml-0">
          {s(Js.Date.toDateString(patient["last_visit"]))}
        </div>
      </div>
    </div>
    <div className="border-transparent absolute inset-0 rounded-lg border-2 pointer-events-none" />
  </li>
}
