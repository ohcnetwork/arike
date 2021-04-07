module Patient = {
  type t = {
    full_name: option<string>,
    dob: option<string>,
    gender: option<string>,
    phone: option<string>,
    address: option<string>,
    route: option<string>,
    notes: option<string>,
    emergency_phone_no: option<string>,
    economic_status: option<string>,
    created_by: option<string>,
    facility_id: option<string>,
    disease: option<string>,
    patient_views: option<string>,
    family_views: option<string>,
  }
  let decode = json => {
    open Json.Decode
    {
      full_name: field("full_name", optional(string), json),
      dob: field("dob", optional(string), json),
      gender: field("gender", optional(string), json),
      phone: field("phone", optional(string), json),
      address: field("address", optional(string), json),
      route: field("route", optional(string), json),
      notes: field("notes", optional(string), json),
      emergency_phone_no: field("emergency_phone_no", optional(string), json),
      economic_status: field("economic_status", optional(string), json),
      created_by: field("created_by", optional(string), json),
      facility_id: field("facility_id", optional(string), json),
      disease: field("disease", optional(string), json),
      patient_views: field("patient_views", optional(string), json),
      family_views: field("family_views", optional(string), json),
    }
  }
}
type props = {
  patient: Patient.t,
  volunteers: array<array<option<string>>>,
  volunteers_selected: array<array<option<string>>>,
  facility: array<array<option<string>>>,
  facility_selected: option<string>,
}
let toString = optionStr => ""->Js.Option.getWithDefault(optionStr)
let s = React.string

/* Add State for capturing data */
@react.component
let make = (~props) => {
  let (state, _setState) = React.useState(() => props)

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
            defaultValue={toString(state.patient.full_name)}
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
            defaultValue={toString(state.patient.dob)}
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
          />
        </div>
      </div>
      <div className="sm:col-span-3 field">
        <label name="patient[gender]" className="block text-sm font-medium text-gray-700">
          {s("Gender")}
        </label>
        <div className="mt-1">
          <select
            name="patient[gender]"
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            defaultValue={toString(state.patient.gender)}>
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
            defaultValue={toString(state.patient.phone)}
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
            defaultValue={toString(state.patient.emergency_phone_no)}
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
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
            defaultValue={toString(state.facility_selected)}
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
            {state.facility
            ->Js.Array2.map(e =>
              <option key={toString(e[1])} value={toString(e[1])}> {s(toString(e[0]))} </option>
            )
            ->React.array}
          </select>
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
            defaultValue={toString(state.patient.route)}
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
            defaultValue={toString(state.patient.address)}
          />
        </div>
      </div>
      <div className="sm:col-span-3 field">
        <label name="patient[notes]" className="block text-sm font-medium text-gray-700">
          {s("Notes")}
        </label>
        <div className="mt-1">
          <textarea
            name="patient[notes]"
            defaultValue={toString(state.patient.notes)}
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
          ->Js.Array2.map(e => {
            <div className="flex items-start" key={toString(e[1])}>
              <div className="flex items-center h-5">
                <input
                  type_="checkbox"
                  name={`patient[volunteer[${toString(e[1])}]]`}
                  id={toString(e[1])}
                  defaultChecked={e[0]->Js.Array.includes(
                    state.volunteers_selected->Js.Array2.map(x => x[0]),
                  )}
                  className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
                />
              </div>
              <div className="ml-3 text-sm">
                <label name="patient[volunteer[${e[1]}]]" className="font-medium text-gray-700">
                  {s(toString(e[0]))}
                </label>
              </div>
            </div>
          })
          ->React.array}
        </div>
      </div>
      <div className="sm:col-span-3 field">
        <label name="patient[economic_status]" className="block text-sm font-medium text-gray-700">
          {s("Economic Status")}
        </label>
        <div className="mt-1">
          <select
            name="patient[economic_status]"
            defaultValue={toString(state.patient.economic_status)}
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
            <option> {s("Well Off")} </option>
            <option> {s("Middle Class")} </option>
            <option> {s("Poor")} </option>
            <option> {s("Very Poor")} </option>
          </select>
        </div>
      </div>
    </div>
    <div className="actions">
      <input
        type_="submit"
        className="mt-8 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
    </div>
  </div>
}
