switch ReactDOM.querySelector(`#patient-disease-form`) {
| Some(id) => ReactDOM.render(<DiseaseHistoryAll dataId="patient-disease-form-data" />, id)
| None => Js.log("Cannot Render Patient's Disease form")
}
