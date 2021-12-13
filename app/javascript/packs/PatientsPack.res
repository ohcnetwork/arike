type props = Patients__Types.props

let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    patients: field("patients", array(Patients__Types.decode), json),
  }
}
let props = DomUtils.parseJSONTag(~id="patients-data", ()) |> decode


switch ReactDOM.querySelector(`#patients`) {
| Some(id) => ReactDOM.render(<Patients props />, id)
| None => ()
}