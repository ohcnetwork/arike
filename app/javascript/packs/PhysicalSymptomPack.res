let decode = PhysicalSymptoms__Form__Type.decode
let data = DomUtils.parseJSONTag(~id="physical-symptoms-form-data", ()) |> decode

switch ReactDOM.querySelector("#physical-symptoms-form") {
| Some(root) => ReactDOM.render(<PhysicalSymptoms__Form data />, root)
| None => ()
}
