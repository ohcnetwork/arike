let s = React.string

let patient = {
  "name": "Patient 1",
  "diseases": ["disease1", "disease2"],
  "procedures": ["procedure1", "procedure2", "procedure3", "procedure4"],
  "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    magnis dis parturient montes, nascetur ridiculus mus.
    Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.
    Nulla consequat ",
  "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
  "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
}

@react.component
let make = () => {
  <div>
    <li
      id="radiogroup-option-1"
      className="group relative bg-white rounded-lg shadow-sm cursor-pointer focus:outline-none focus:ring-1 focus:ring-offset-2 focus:ring-indigo-500 list-none">
      <div
        className="flex items-center rounded-lg border border-gray-300 bg-white px-6 py-4 hover:border-gray-400 sm:flex sm:justify-between">
        <div className="text-sm">
          <div className="flex items-center">
            <p className="font-extrabold text-xl text-gray-900"> {s(patient["name"])} </p>
            <span className="hidden sm:inline sm:mx-1" />
            <div className="text-gray-500 flex">
              {patient["diseases"]
              ->Belt.Array.map(disease =>
                <div>
                  <p className="sm:inline"> {s(disease)} </p>
                  <span className="hidden sm:inline sm:mx-1"> {s(" ")} </span>
                </div>
              )
              ->React.array}
            </div>
          </div>
          <div className="text-gray-500 flex">
            {patient["procedures"]
            ->Belt.Array.map(procedure =>
              <div>
                <p className="sm:inline"> {s(procedure)} </p>
                <span className="hidden sm:inline sm:mx-1"> {s(" ")} </span>
              </div>
            )
            ->React.array}
          </div>
        </div>
        <div className="text-gray-500 sm:ml-0"> {s(patient["notes"])} </div>
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
      <div
        className="border-transparent absolute inset-0 rounded-lg border-2 pointer-events-none"
      />
    </li>
  </div>
}
