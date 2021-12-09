// type props = Patient__Types.props

// let decode: Js.Json.t => props = json => {
//   open Json.Decode
//   {
//     schedules: field("patients", array(Agenda__Types.decode), json),
//   }
// }
// let props = DomUtils.parseJSONTag(~id="patients-data", ()) |> decode

switch ReactDOM.querySelector(`#patients`) {
| Some(id) => ReactDOM.render(<Patients />, id)
| None => ()
}