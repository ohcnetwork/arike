switch ReactDOM.querySelector("#physical-symptoms-form") {
| Some(root) =>
  ReactDOM.render(<PhysicalSymptoms__Form />, root)
| None => ()
}
