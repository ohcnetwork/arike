switch ReactDOM.querySelector("#DetailedExample") {
| Some(root) => ReactDOM.render(<Multiselect.DetailedExample />, root)
| None => () // do nothing
}
