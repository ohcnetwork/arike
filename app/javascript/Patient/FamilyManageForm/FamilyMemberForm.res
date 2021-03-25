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

let s = React.string
type props = FamilyMember.t

@react.component
let make = (~props: props, ~onClick) => {
  let id = Belt.Int.toString(props.id)
  <div className="m-2 px-3 py-1 bg-gray-200 rounded flex">
    <div>
      <label className="block text-sm font-medium text-gray-700"> {s("Full Name")} </label>
      <input type_="text" placeholder="Family Member Name" name={`patient[family][${id}][name]`} />
      <input type_="text" placeholder="Relationship" name={`patient[family][${id}][relation]`} />
      <input type_="text" placeholder="Date of birth" name={`patient[family][${id}][dob]`} />
      <input type_="text" placeholder="Education" name={`patient[family][${id}][education]`} />
      <input type_="text" placeholder="Occupation" name={`patient[family][${id}][occupation]`} />
      <input type_="text" placeholder="Remark" name={`patient[family][${id}][remark]`} />
    </div>
    <button className="bg-red-600 text-white rounded" onClick> {s("Delete Family Member")} </button>
  </div>
}
