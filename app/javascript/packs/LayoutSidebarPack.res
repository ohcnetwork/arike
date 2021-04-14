type props = {
  links: array<LayoutSidebar__Link.t>,
  currentUserName: string,
}

let decode = json => {
  open Json.Decode
  {
    links: field("links", array(LayoutSidebar__Link.decode), json),
    currentUserName: field("current_user_name", string, json),
  }
}

let props = DomUtils.parseJSONTag(~id="layout-sidebar-data", ()) |> decode

switch ReactDOM.querySelector("#layout-sidebar") {
| Some(root) =>
  ReactDOM.render(
    <LayoutSidebar__Root links={props.links} currentUserName={props.currentUserName} />,
    root,
  )
| None => ()
}
