type t = {
  id: string,
  name: string,
  category: string,
  description: option<string>,
}

let id = t => t.id
let name = t => t.name
let category = t => t.category
let description = t => t.description

let make = (~id, ~name, ~category, ~description) => {
  id: id,
  name: name,
  category: category,
  description: description,
}

let decode = json => {
  open Json.Decode
  {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
    description: field("description", optional(string), json),
  }
}

let makeFromDropDown = treatment => {
  id: treatment->PatientTreatment__DropdownOption.id,
  name: treatment->PatientTreatment__DropdownOption.name,
  category: treatment->PatientTreatment__DropdownOption.category,
  description: None,
}
