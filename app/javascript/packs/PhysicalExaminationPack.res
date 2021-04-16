switch ReactDOM.querySelector("#physical-examination-form") {
| Some(root) =>
  ReactDOM.render(<PhysicalExamination__Form />, root)
| None => ()
}
