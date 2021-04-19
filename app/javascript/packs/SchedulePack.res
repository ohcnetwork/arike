type props = Schedule__type.props

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
