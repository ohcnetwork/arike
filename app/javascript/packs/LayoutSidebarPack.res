switch ReactDOM.querySelector("#layout-sidebar") {
| Some(root) => ReactDOM.render(<LayoutSidebar__Root />, root)
| None => () // do nothing
}
