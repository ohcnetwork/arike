module FamilyMember = {
  type t = {
    id: string,
    patient_id: string,
    full_name: string,
    relation: string,
    dob: string,
    phone: string,
    education: string,
    occupation: string,
    remarks: string,
  }
  let make = (~id) => {
    id: id,
    patient_id: "",
    full_name: "",
    relation: "",
    dob: "",
    phone: "",
    education: "",
    occupation: "",
    remarks: "",
  }
}

let s = React.string
type props = FamilyMember.t

@react.component
let make = (~props: props, ~onClick, ~relations, ~educations, ~occupations) => {
  let id = props.id
  <div
    className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6 bg-gray-200 rounded px-3 py-2">
    <div className="sm:col-span-3 field px-2">
      <label
        name={`familyDetails[${id}][full_name]`}
        className="block text-sm font-medium text-gray-700">
        {s("Full Name")}
      </label>
      <div className="mt-1">
        <input
          type_="text"
          name={`familyDetails[${id}][full_name]`}
          defaultValue={props.full_name}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
          required={true}
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][relation]`} className="block text-sm font-medium text-gray-700">
        {s("Relationship")}
      </label>
      <div className="mt-1">
        <select
          required={true}
          name={`familyDetails[${id}][relation]`}
          defaultValue={props.relation}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {relations
          ->Belt.Array.map(relation =>
            <option key={relation} value={relation}> {s(relation)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label name={`familyDetails[${id}][dob]`} className="block text-sm font-medium text-gray-700">
        {s("Date of Birth")}
      </label>
      <div className="mt-1">
        <input
          name={`familyDetails[${id}][dob]`}
          type_="date"
          defaultValue={props.dob}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][education]`}
        className="block text-sm font-medium text-gray-700">
        {s("Education")}
      </label>
      <div className="mt-1">
        <select
          defaultValue={props.education}
          name={`familyDetails[${id}][education]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {educations
          ->Belt.Array.map(education =>
            <option key={education} value={education}> {s(education)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][phone]`} className="block text-sm font-medium text-gray-700">
        {s("Phone No.")}
      </label>
      <div className="mt-1">
        <input
          defaultValue={props.phone}
          name={`familyDetails[${id}][phone]`}
          type_="text"
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][occupation]`}
        className="block text-sm font-medium text-gray-700">
        {s("Occupation")}
      </label>
      <div className="mt-1">
        <select
          name={`familyDetails[${id}][occupation]`}
          defaultValue={props.occupation}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {occupations
          ->Belt.Array.map(occupation =>
            <option key={occupation} value={occupation}> {s(occupation)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][remarks]`} className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.remarks}
          name={`familyDetails[${id}][remarks]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][remarks]`} className="block text-sm font-medium text-gray-700">
        {s("Action")}
      </label>
      <div className="mt-1">
        <button
          onClick={mouseEvt => {
            mouseEvt->ReactEvent.Mouse.preventDefault
            onClick()
          }}>
          {s("Delete")}
        </button>
      </div>
    </div>
  </div>
}
