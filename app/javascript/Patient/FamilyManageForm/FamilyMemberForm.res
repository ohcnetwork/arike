type data = {
  relations: array<string>,
  educations: array<string>,
  occupations: array<string>,
}
module FamilyMember = {
  type t = {
    id: int,
    name: string,
    relationship: string,
    dob: string,
    education: string,
    occupation: string,
    remark: string,
  }
  let make = (~id) => {
    {id: id, name: "", relationship: "", dob: "", education: "", occupation: "", remark: ""}
  }
}

@scope("JSON") @val
external parseJson: string => data = "parse"

let getData = () => {
  let elem =
    Domutils.doc->Domutils.getElementById("data")->Belt.Option.getWithDefault(Js.Obj.empty())

  elem["innerText"]->Domutils.replaceAll("&quot;", "\"")->parseJson
}

let s = React.string
type props = FamilyMember.t

@react.component
let make = (~props: props, ~onClick) => {
  let (state, _setState) = React.useState(() => getData())

  let id = Belt.Int.toString(props.id)
  <div className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][name]`} className="block text-sm font-medium text-gray-700">
        {s("Full Name")}
      </label>
      <div className="mt-1">
        <input
          type_="text"
          name={`familyDetails[${id}][name]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][relationship]`}
        className="block text-sm font-medium text-gray-700">
        {s("Relationship")}
      </label>
      <div className="mt-1">
        <select
          name={`familyDetails[${id}][relationship]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {state.relations
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
          name={`familyDetails[${id}][education]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {state.educations
          ->Belt.Array.map(education =>
            <option key={education} value={education}> {s(education)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][phone_no]`} className="block text-sm font-medium text-gray-700">
        {s("Phone No.")}
      </label>
      <div className="mt-1">
        <input
          name={`familyDetails[${id}][phone_no]`}
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
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          <option> {s("Select")} </option>
          {state.occupations
          ->Belt.Array.map(occupation =>
            <option key={occupation} value={occupation}> {s(occupation)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`familyDetails[${id}][remark]`} className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          name={`familyDetails[${id}][remark]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
  </div>
}
