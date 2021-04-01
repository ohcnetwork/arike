type props = {
  currentUserName: string,
  currentUserRole: string,
}

let decode = json => {
  open Json.Decode
  {
    currentUserName: field("current_user_name", string, json),
    currentUserRole: field("current_user_role", string, json),
  }
}

let props = DomUtils.parseJSONTag(~id="patient-vitals-data", ()) |> decode


switch ReactDOM.querySelector("#patient-vitals-form") {
| Some(root) =>
  ReactDOM.render(<PatientVitals name=props.currentUserName role=props.currentUserRole />, root)
| None => ()
}
