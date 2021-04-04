type data = {
  lsg: array<array<string>>,
  lsg_selected: string,
  volunteers: array<array<string>>,
  volunteers_selected: array<array<string>>,
  ashas: array<array<string>>,
  asha_selected: string,
  facility: array<array<string>>,
  facility_selected: string,
  reported_by: array<array<string>>,
  reported_by_selected: string,
}

@scope("JSON") @val
external parseJson: string => data = "parse"

let getData = () => {
  let elem =
    Domutils.doc->Domutils.getElementById("data")->Belt.Option.getWithDefault(Js.Obj.empty())

  elem["innerText"]->Domutils.replaceAll("&quot;", "\"")->parseJson
}

let checkExistingVolunteers = state => {
  state.volunteers->Belt.Array.forEach(e => {
    Js.log(state.volunteers_selected->Belt.Array.map(x => Js.Array.includes(e[0], x)))
  })
}

let s = React.string

/* Add State for capturing data */
module PatientRegister = {
  @react.component
  let make = () => {
    <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-3xl mx-auto">
        <form action="/patients" method="post">
          <div className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Full Name")} </label>
              <div className="mt-1">
                <input
                  type_="text"
                  className="shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm
              border-gray-300 rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700">
                {s("Date of Birth")}
              </label>
              <div className="mt-1">
                <input
                  type_="date"
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Sex")} </label>
              <div className="mt-1">
                <select
                  className="shadow-sm focus:ring-indigo-500
            focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
                  <option value="Male"> {s("Male")} </option>
                  <option value="Female"> {s("Female")} </option>
                  <option value="Others"> {s("Others")} </option>
                </select>
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Phone")} </label>
              <div className="mt-1">
                <input
                  type_="text"
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700">
                {s("Emergency Phone No.")}
              </label>
              <div className="mt-1">
                <input
                  type_="text"
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("LSG Body")} </label>
              <div className="mt-1">
                <select
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md">
                  <option />
                </select>
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Address")} </label>
              <div className="mt-1">
                <textarea
                  className="shadow-sm focus:ring-indigo-500
            focus:border-indigo-500 block w-full sm:text-sm border-gray-300
            rounded-md h-24"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Route")} </label>
              <div className="mt-1">
                <textarea
                  className="shadow-sm focus:ring-indigo-500
            focus:border-indigo-500 block w-full sm:text-sm border-gray-300
            rounded-md h-24"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700"> {s("Notes")} </label>
              <div className="mt-1">
                <textarea
                  className="shadow-sm focus:ring-indigo-500
            focus:border-indigo-500 block w-full sm:text-sm border-gray-300
            rounded-md h-24"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label
                className="block text-sm font-medium
          text-gray-700">
                {s("Volunteer")}
              </label>
              //
              <div className="mt-1 overflow-y-scroll h-24 py-3 px-2" />
            </div>
            <div className="sm:col-span-3 field">
              <label
                className="block text-sm font-medium
          text-gray-700">
                {s("Economic Status")}
              </label>
              <div className="mt-1">
                <select
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md">
                  <option> {s("Well Off")} </option>
                  <option> {s("Middle Class")} </option>
                  <option> {s("Poor")} </option>
                  <option> {s("Very Poor")} </option>
                </select>
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label
                className="block text-sm font-medium
          text-gray-700">
                {s("ASHA Member")}
              </label>
              <div className="mt-1">
                <select
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md">
                  <option> {s("ASHA")} </option>
                </select>
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label
                className="block text-sm font-medium
          text-gray-700">
                {s("Reported By")}
              </label>
              <div className="mt-1">
                <select
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md">
                  <option> {s("Reported By")} </option>
                </select>
              </div>
            </div>
          </div>
          <div className="actions">
            <input
              type_="submit"
              className="mt-4 inline-flex justify-center py-2 px-4 border
          border-transparent shadow-sm text-sm font-medium rounded-md text-white
          bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2
          focus:ring-offset-2 focus:ring-indigo-500"
            />
          </div>
        </form>
      </div>
    </div>
  }
}

let run = () => {
  switch ReactDOM.querySelector("#patient-form") {
  | Some(root) => ReactDOM.render(<div> <PatientRegister /> </div>, root)
  | None => () // do nothing
  }
}
