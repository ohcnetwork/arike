switch ReactDOM.querySelector("#patient-form") {
| Some(root) => ReactDOM.render(<div> <PersonalDetails dataId="patient-form-data" /> </div>, root)
| None => () // do nothing
}
