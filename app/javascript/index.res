let s = React.string

let runReact = () => {
  switch ReactDOM.querySelector("#root") {
  | Some(root) =>
    ReactDOM.render(
      <AutoComplete
        getFilteredArray={inputValue => {
          [
            "emma",
            "david",
            "brian",
            "robert",
            "kiwyoski",
            "heugo",
            "droka",
            "daran",
            "eugi",
          ]->Js.Array2.filter(el => el->Js.String2.includes(inputValue))
        }}
      />,
      root,
    )
  | None => ()
  }
}
