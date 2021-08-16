type t = {
  id: string,
  name: string,
  category: string,
  created_at: Js.Date.t,
  stopped_at: option<Js.Date.t>,
}

let make = (~id, ~name, ~category, ~created_at, ~stopped_at) => {
  id: id,
  name: name,
  category: category,
  created_at: created_at,
  stopped_at: stopped_at,
}

let id = t => t.id
let name = t => t.name
let category = t => t.category
let created_at = t => t.created_at
let stopped_at = t => t.stopped_at

let updateDeletedAt = (t, stopped_at) => {...t, stopped_at: stopped_at}

let decode = json => {
  open Json.Decode
  {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
    created_at: field("created_at", string, json)->Js.Date.fromString,
    stopped_at: optional(field("stopped_at", string), json)->Belt.Option.map(Js.Date.fromString),
  }
}
