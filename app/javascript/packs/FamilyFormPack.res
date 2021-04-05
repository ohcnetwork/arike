switch ReactDOM.querySelector(`#family-form`) {
| Some(id) => ReactDOM.render(<FamilyFormManager dataId="family-form-data" />, id)
| None => ()
}
