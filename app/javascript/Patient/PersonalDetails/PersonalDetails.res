type patient = {
  full_name: string,
  dob: string,
  sex: string,
  phone: string,
  address: string,
  route: string,
  notes: string,
  emergency_phone_no: string,
  economic_status: string,
  reported_by: string,
  created_by: string,
  facility_id: string,
  disease: string,
  patient_view: string,
  family_view: string,
}
type data = {
  patient: patient,
  volunteers: array<array<string>>,
  volunteers_selected: array<array<string>>,
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
    let (state, _setState) = React.useState(() => getData())

    if state.volunteers->Belt.Array.length > 0 {
      Js.log(state.volunteers_selected)
      checkExistingVolunteers(state)
    }

    <div>
      <div className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
        <div className="sm:col-span-3 field">
          <label name="patient[full_name]" className="block text-sm font-medium text-gray-700">
            {s("Full Name")}
          </label>
          <div className="mt-1">
            <input
              type_="text"
              name="patient[full_name]"
              defaultValue=state.patient.full_name
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[dob]" className="block text-sm font-medium text-gray-700">
            {s("Date of Birth")}
          </label>
          <div className="mt-1">
            <input
              name="patient[dob]"
              type_="date"
              defaultValue=state.patient.dob
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[sex]" className="block text-sm font-medium text-gray-700">
            {s("Sex")}
          </label>
          <div className="mt-1">
            <select
              name="patient[sex]"
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
              defaultValue=state.patient.sex>
              <option> {s("Select")} </option>
              <option value="Male"> {s("Male")} </option>
              <option value="Female"> {s("Female")} </option>
              <option value="Others"> {s("Others")} </option>
            </select>
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[phone]" className="block text-sm font-medium text-gray-700">
            {s("Phone")}
          </label>
          <div className="mt-1">
            <input
              name="patient[phone]"
              type_="text"
              defaultValue=state.patient.phone
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label
            name="patient[emergency_phone_no]" className="block text-sm font-medium text-gray-700">
            {s("Emergency Phone No.")}
          </label>
          <div className="mt-1">
            <input
              name="patient[emergency_phone_no]"
              type_="text"
              defaultValue=state.patient.emergency_phone_no
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[address]" className="block text-sm font-medium text-gray-700">
            {s("Address")}
          </label>
          <div className="mt-1">
            <textarea
              name="patient[address]"
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
              defaultValue=state.patient.address
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[route]" className="block text-sm font-medium text-gray-700">
            {s("Route")}
          </label>
          <div className="mt-1">
            <textarea
              name="patient[route]"
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
              defaultValue=state.patient.route
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[facility_id]" className="block text-sm font-medium text-gray-700">
            {s("Facility")}
          </label>
          <div className="mt-1">
            <select
              name="patient[facility_id]"
              defaultValue=state.facility_selected
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
              {state.facility
              ->Belt.Array.map(e => <option key={e[1]} value={e[1]}> {s(e[0])} </option>)
              ->React.array}
            </select>
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[notes]" className="block text-sm font-medium text-gray-700">
            {s("Notes")}
          </label>
          <div className="mt-1">
            <textarea
              name="patient[notes]"
              defaultValue=state.patient.notes
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
            />
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[volunteer]" className="block text-sm font-medium text-gray-700">
            {s("Volunteer")}
          </label>
          <div className="mt-1 overflow-y-scroll h-24 py-3 px-2">
            {state.volunteers
            ->Belt.Array.map(e => {
              <div className="flex items-start" key={e[1]}>
                <div className="flex items-center h-5">
                  <input
                    type_="checkbox"
                    name={`patient[volunteer[${e[1]}]]`}
                    id={e[1]}
                    // checked=state.volunteers_selected->Belt.Array.map(x => Js.Array.includes(e[0], x))
                    defaultChecked={e[0]->Js.Array.includes(
                      state.volunteers_selected->Belt.Array.map(x => x[0]),
                    )}
                    className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
                  />
                </div>
                <div className="ml-3 text-sm">
                  <label name="patient[volunteer[${e[1]}]]" className="font-medium text-gray-700">
                    {s(e[0])}
                  </label>
                </div>
              </div>
            })
            ->React.array}
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label
            name="patient[economic_status]" className="block text-sm font-medium text-gray-700">
            {s("Economic Status")}
          </label>
          <div className="mt-1">
            <select
              name="patient[economic_status]"
              defaultValue=state.patient.economic_status
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
              <option> {s("Well Off")} </option>
              <option> {s("Middle Class")} </option>
              <option> {s("Poor")} </option>
              <option> {s("Very Poor")} </option>
            </select>
          </div>
        </div>
        <div className="sm:col-span-3 field">
          <label name="patient[reported_by]" className="block text-sm font-medium text-gray-700">
            {s("Reported By")}
          </label>
          <div className="mt-1">
            <select
              name="patient[reported_by]"
              defaultValue=state.reported_by_selected
              className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
              {state.reported_by
              ->Belt.Array.map(e => <option key={e[1]} value={e[1]}> {s(e[0])} </option>)
              ->React.array}
            </select>
          </div>
        </div>
      </div>
      <div className="actions">
        <input
          type_="submit"
          className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        />
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
