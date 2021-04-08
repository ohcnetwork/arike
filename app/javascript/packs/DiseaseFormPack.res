type props = DiseaseHistoryForm__Manager.props
let decode: Js.Json.t => props = json => {
  open Json.Decode
  {
    diseases: field("diseases", array(DiseaseHistory__Type.decode), json),
    list_of_diseases: field("list_of_diseases", array(array(optional(string))), json),
  }
}

let props = DomUtils.parseJSONTag(~id="patient-disease-form-data", ()) |> decode

switch ReactDOM.querySelector(`#patient-disease-form`) {
| Some(id) => ReactDOM.render(<DiseaseHistoryForm__Manager props />, id)
| None => ()
}
