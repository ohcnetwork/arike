let s = React.string

let runReact = () => {
  switch ReactDOM.querySelector("#root") {
  | Some(root) =>
    ReactDOM.render(
      <AutoComplete
        options=["emma", "david", "brian", "robert", "kiwyoski", "heugo", "droka", "daran", "eugi"]
      />,
      root,
    )
  | None => ()
  }
}
