type props = Agenda__Types.props

let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    schedules: field("patients", array(Agenda__Types.decode), json),
  }
}
let props = DomUtils.parseJSONTag(~id="agenda-data", ()) |> decode

switch ReactDOM.querySelector(`#agenda`) {
| Some(id) => ReactDOM.render(<Agenda props />, id)
| None => ()
}