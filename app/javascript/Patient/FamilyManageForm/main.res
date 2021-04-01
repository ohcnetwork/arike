let start = (id, dataId) =>
  switch ReactDOM.querySelector(`#${id}`) {
  | Some(id) => ReactDOM.render(<FamilyFormManager dataId />, id)
  | None => Js.log("Cannot find id")
  }
