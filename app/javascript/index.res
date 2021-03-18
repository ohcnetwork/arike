let s = React.string

let runReact = root => {
  switch ReactDOM.querySelector("#" ++ root) {
  | Some(root) =>
    ReactDOM.render(
      <AutoComplete
        getFilteredArray={inputValue => {
          [
            "euma",
            "euvid",
            "euian",
            "eubert",
            "euwyoski",
            "euugo",
            "droka",
            "daran",
            "eugi",
          ]->Js.Array2.filter(el => el->Js.String2.includes(inputValue))
        }}
        placeholder="Diseases"
        value=""
      />,
      root,
    )
  | None => Js.log("hunu")
  }
}
