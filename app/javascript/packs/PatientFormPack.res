module Patient = Patient__Type
type props = PersonalDetailsForm.props

let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    patient: field("patient", Patient.decode, json),
    volunteers: field("volunteers", array(array(optional(string))), json),
    volunteers_selected: field("volunteers_selected", array(array(optional(string))), json),
    facility: field("facility", array(array(optional(string))), json),
    facility_selected: field("facility_selected", optional(string), json),
  }
}

let props = DomUtils.parseJSONTag(~id="patient-form-data", ()) |> decode

switch ReactDOM.querySelector("#patient-form") {
| Some(root) => ReactDOM.render(<div> <PersonalDetailsForm props /> </div>, root)
| None => ()
}
