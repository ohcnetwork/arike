let decode = PhysicalExamination__Form__Type.decode
let data = DomUtils.parseJSONTag(~id="physical-examination-form-data", ()) |> decode
switch ReactDOM.querySelector("#physical-examination-form") {
| Some(root) => ReactDOM.render(<PhysicalExamination__Form data />, root)
| None => ()
}
