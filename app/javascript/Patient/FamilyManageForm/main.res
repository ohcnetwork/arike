let start = id =>
  switch ReactDOM.querySelector(`#${id}`) {
  | Some(id) => ReactDOM.render(<FamilyFormManager />, id)
  | None => Js.log("Cannot find id")
  }
