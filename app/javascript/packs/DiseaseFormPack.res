switch ReactDOM.querySelector(`#patient-disease-form`) {
| Some(id) => ReactDOM.render(<DiseaseHistoryAll dataId="patient-disease-form-data" />, id)
| None => ()
}
