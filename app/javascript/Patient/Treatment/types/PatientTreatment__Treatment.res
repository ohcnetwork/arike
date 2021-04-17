type t = {
  id: string,
  name: string,
  category: string,
  created_at: Js.Date.t,
  deleted_at: option<Js.Date.t>,
}

let make = (~id, ~name, ~category, ~created_at, ~deleted_at) => {
  id: id,
  name: name,
  category: category,
  created_at: created_at,
  deleted_at: deleted_at,
}

let id = t => t.id
let name = t => t.name
let category = t => t.category
let created_at = t => t.created_at
let deleted_at = t => t.deleted_at

let updateDeletedAt = (t, deleted_at) => {...t, deleted_at: deleted_at}

let decode = json => {
  open Json.Decode
  {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
    created_at: field("created_at", string, json)->Js.Date.fromString,
    deleted_at: optional(field("deleted_at", string), json)->Belt.Option.map(Js.Date.fromString),
  }
}
