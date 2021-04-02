let start = (id, dataId) =>
  switch ReactDOM.querySelector(`#${id}`) {
  | Some(id) => ReactDOM.render(<DiseaseHistoryAll dataId />, id)
  | None => Js.log("Cannot find id")
  }
