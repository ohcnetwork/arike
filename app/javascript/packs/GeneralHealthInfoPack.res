switch ReactDOM.querySelector("#general-health-information-form") {
| Some(root) =>
  ReactDOM.render(<GeneralHealthInfo__Form />, root)
| None => ()
}
