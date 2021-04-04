type t = {
  title: string,
  link: string,
  icon: string,
  selected: bool,
}

let title = t => t.title
let link = t => t.link
let icon = t => t.icon
let selected = t => t.selected

let decode = json => {
  open Json.Decode
  {
    title: field("title", string, json),
    link: field("link", string, json),
    icon: field("icon", string, json),
    selected: field("selected", bool, json),
  }
}
