type props = Schedule__type.unscheduled_patients
type patient = Schedule__type.unscheduled_patient
let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    patients: field("patients", array(Schedule__type.decode), json),
  }
}
let props = DomUtils.parseJSONTag(~id="schedule-data", ()) |> decode

switch ReactDOM.querySelector(`#schedule`) {
| Some(id) => ReactDOM.render(<Schedule props />, id)
| None => ()
}
