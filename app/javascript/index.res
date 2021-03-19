let s = React.string

let runReact = (root, api, name, id, label, placeholder) => {
  switch ReactDOM.querySelector("#" ++ root) {
  | Some(root) => ReactDOM.render(<AutoComplete api name id label placeholder value="" />, root)
  | None => Js.log("hunu")
  }
}
