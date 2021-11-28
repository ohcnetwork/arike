let decode = GeneralHealthInfo__Form__Type.decode

let data = DomUtils.parseJSONTag(~id="general-health-information-form-data", ()) |> decode
switch ReactDOM.querySelector("#general-health-information-form") {
| Some(root) => ReactDOM.render(<GeneralHealthInfo__Form data />, root)
| None => ()
}
