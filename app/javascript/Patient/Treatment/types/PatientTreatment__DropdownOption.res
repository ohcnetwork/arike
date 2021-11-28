type t = {
  id: string,
  name: string,
  category: string,
}

let id = t => t.id
let name = t => t.name
let category = t => t.category

let make = (~id, ~name, ~category) => {
  id: id,
  name: name,
  category: category,
}

let decode = json => {
  open Json.Decode
  {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
  }
}
