type props = PatientTreatment__Manager.props
let s = React.string

let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    patient_id: field("patient_id", string, json),
  }
}

let props = DomUtils.parseJSONTag(~id="treatment-data", ()) |> decode
Js.log(DomUtils.parseJSONTag(~id="treatment-data", ()) |> decode)

switch ReactDOM.querySelector(`#treatment`) {
| Some(id) => ReactDOM.render(<PatientTreatment__Manager props />, id)
| None => () // Do nothing
}
