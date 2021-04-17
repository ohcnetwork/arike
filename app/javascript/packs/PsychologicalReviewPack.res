let decode = PsychologicalReview__Form__Type.decode
let data = DomUtils.parseJSONTag(~id="psychological-review-form-data", ()) |> decode
switch ReactDOM.querySelector("#psychological-review-form") {
| Some(root) => ReactDOM.render(<PsychologicalReview__Form data />, root)
| None => ()
}
