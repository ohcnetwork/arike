switch ReactDOM.querySelector("#DetailedExample") {
| Some(root) => ReactDOM.render(<Multiselect.MinimalExample />, root)
| None => () // do nothing
}
