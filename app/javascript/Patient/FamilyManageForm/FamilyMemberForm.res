module FamilyMember = {
  type t = {
    id: option<string>,
    patient_id: option<string>,
    full_name: option<string>,
    relation: option<string>,
    dob: option<string>,
    phone: option<string>,
    education: option<string>,
    occupation: option<string>,
    remarks: option<string>,
  }
  let make = (~id) => {
    id: Some(id),
    patient_id: Some(""),
    full_name: Some(""),
    relation: Some(""),
    dob: Some(""),
    phone: Some(""),
    education: Some(""),
    occupation: Some(""),
    remarks: Some(""),
  }
  let decode = json => {
    open Json.Decode
    {
      id: field("id", optional(string), json),
      patient_id: field("patient_id", optional(string), json),
      full_name: field("full_name", optional(string), json),
      relation: field("relation", optional(string), json),
      dob: field("dob", optional(string), json),
      phone: field("phone", optional(string), json),
      education: field("education", optional(string), json),
      occupation: field("occupation", optional(string), json),
      remarks: field("remarks", optional(string), json),
    }
  }
}
let toString = str => {
  Js.Option.getWithDefault("", str)
}
let s = React.string
type props = FamilyMember.t

@react.component
let make = (~props: props, ~count, ~onClick, ~relations, ~educations, ~occupations) => {
  let id = props.id
  let isGray = "bg-gray-100"
  <div
    className={`grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6 rounded px-3 border-b py-8 my-8 ${isGray}`}>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][full_name]`}
        className="block text-sm font-medium text-gray-700">
        {s("Full Name")}
      </label>
      <div className="mt-1">
        <input
          type_="text"
          name={`familyDetails[${toString(id)}][full_name]`}
          defaultValue={toString(props.full_name)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
          required={true}
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][relation]`}
        className="block text-sm font-medium text-gray-700">
        {s("Relationship")}
      </label>
      <div className="mt-1">
        <select
          required={true}
          name={`familyDetails[${toString(id)}][relation]`}
          defaultValue={toString(props.relation)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option value=""> {s("Select")} </option>
          {relations
          ->Js.Array2.map(relation =>
            <option
              key={""->Js.Option.getWithDefault(relation)}
              value={""->Js.Option.getWithDefault(relation)}>
              {s(""->Js.Option.getWithDefault(relation))}
            </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][dob]`}
        className="block text-sm font-medium text-gray-700">
        {s("Date of Birth")}
      </label>
      <div className="mt-1">
        <input
          name={`familyDetails[${toString(id)}][dob]`}
          type_="date"
          defaultValue={toString(props.dob)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][education]`}
        className="block text-sm font-medium text-gray-700">
        {s("Education")}
      </label>
      <div className="mt-1">
        <select
          defaultValue={toString(props.education)}
          name={`familyDetails[${toString(id)}][education]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option value=""> {s("Select")} </option>
          {educations
          ->Js.Array2.map(education =>
            <option
              key={""->Js.Option.getWithDefault(education)}
              value={""->Js.Option.getWithDefault(education)}>
              {s(""->Js.Option.getWithDefault(education))}
            </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][phone]`}
        className="block text-sm font-medium text-gray-700">
        {s("Phone No.")}
      </label>
      <div className="mt-1">
        <input
          defaultValue={toString(props.phone)}
          name={`familyDetails[${toString(id)}][phone]`}
          type_="text"
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${toString(id)}][occupation]`}
        className="block text-sm font-medium text-gray-700">
        {s("Occupation")}
      </label>
      <div className="mt-1">
        <select
          name={`familyDetails[${toString(id)}][occupation]`}
          defaultValue={toString(props.occupation)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option value=""> {s("Select")} </option>
          {occupations
          ->Js.Array2.map(occupation =>
            <option
              key={""->Js.Option.getWithDefault(occupation)}
              value={""->Js.Option.getWithDefault(occupation)}>
              {s(""->Js.Option.getWithDefault(occupation))}
            </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-6 field">
      <label
        name={`familyDetails[${toString(id)}][remarks]`}
        className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={toString(props.remarks)}
          name={`familyDetails[${toString(id)}][remarks]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <div className="mt-1">
        <button
          className="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
          onClick={mouseEvt => {
            mouseEvt->ReactEvent.Mouse.preventDefault
            onClick()
          }}>
          {s("Delete")}
        </button>
      </div>
    </div>
    <hr />
  </div>
}
