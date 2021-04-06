module PatientDisease = DiseaseHistoryForm.PatientDisease
type props = DiseaseHistoryAll.props
let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    diseases: field("diseases", array(PatientDisease.decode), json),
    list_of_diseases: field("list_of_diseases", array(array(optional(string))), json),
  }
}

let props = DomUtils.parseJSONTag(~id="patient-disease-form-data", ()) |> decode

switch ReactDOM.querySelector(`#patient-disease-form`) {
| Some(id) => ReactDOM.render(<DiseaseHistoryAll props />, id)
| None => ()
}
