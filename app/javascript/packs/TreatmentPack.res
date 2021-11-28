type props = PatientTreatment__Manager.props
let s = React.string

open PatientTreatment__Types

let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    patientId: field("patient_id", string, json),
    allTreatments: field("all_treatments", array(DropdownOption.decode), json),
    activeTreatments: field("active_treatments", array(Treatment.decode), json),
    selectedTreatments: [],
  }
}

let props = DomUtils.parseJSONTag(~id="treatment-data", ()) |> decode

switch ReactDOM.querySelector(`#treatment`) {
| Some(id) => ReactDOM.render(<PatientTreatment__Manager props />, id)
| None => () // Do nothing
}
