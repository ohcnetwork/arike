let s = React.string

@react.component
let make = (~patient, ~selectPatient) => {
  let getDifferenceInDays = %raw(`
    function getDifferenceInDays(date1, date2) {
      const diffInMs = date2 - date1;
      return Math.floor(diffInMs / (1000 * 60 * 60 * 24));
    }
  `)

  <li
    onClick={_ => selectPatient(patient)}
    className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200 hover:bg-gray-100 flex items-center">
    <div className="w-full flex items-center justify-between p-6 space-x-6">
      <div className="flex-1 truncate">
        <div className=" items-center space-x-3 justify-self-start">
          <h3 className="text-gray-900 text-md font-bold"> {s(patient["name"])} </h3>
        </div>
        <div className="grid min-w-max">
          {patient["procedures"]
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
          {s(`ward ` ++ patient["ward"]->Belt.Int.toString)}
        </span>
        <div className="font-bold text-sm text-red-400">
          {s(
            `${getDifferenceInDays(
                Js.Date.now(),
                Js.Date.fromString(patient["next_visit"]),
              )->Belt.Int.toString} days`,
          )}
        </div>
        <div className="ml-1 text-gray-500 text-sm sm:ml-0"> {s(patient["next_visit"])} </div>
        <div className="ml-1 text-gray-500 text-sm sm:ml-0"> {s(patient["last_visit"])} </div>
      </div>
    </div>
  </li>
}
