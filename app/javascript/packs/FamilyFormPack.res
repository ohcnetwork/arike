type props = FamilyMemberForm__Manager.props
let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    relations: field("relations", array(optional(string)), json),
    educations: field("educations", array(optional(string)), json),
    occupations: field("occupations", array(optional(string)), json),
    members: field("members", array(FamilyDetails__Type.decode), json),
  }
}

let props = DomUtils.parseJSONTag(~id="family-form-data", ()) |> decode
switch ReactDOM.querySelector(`#family-form`) {
| Some(id) => ReactDOM.render(<FamilyMemberForm__Manager props />, id)
| None => ()
}
