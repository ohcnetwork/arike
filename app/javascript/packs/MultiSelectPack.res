@val external window: {..} = "window"

let runReact = (rootId, name, id, label, placeholder, dataElem) => {
  switch ReactDOM.querySelector("#" ++ rootId) {
  | Some(root) => ReactDOM.render(<Multiselect name id label placeholder dataElem />, root)
  | None => () // do nothing
  }
}

window["runReact"] = runReact
