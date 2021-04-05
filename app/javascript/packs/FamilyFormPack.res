switch ReactDOM.querySelector(`#family-form`) {
| Some(id) => ReactDOM.render(<FamilyFormManager dataId="family-form-data" />, id)
| None => Js.log("Cannot render Family Details Form")
}
