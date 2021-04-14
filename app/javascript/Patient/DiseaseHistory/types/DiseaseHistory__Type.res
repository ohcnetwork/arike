type t = {
  id: option<string>,
  name: option<string>,
  patient_id: option<string>,
  date_of_diagnosis: option<string>,
  investigation: option<string>,
  treatments: option<string>,
  remarks: option<string>,
}

let make = (~id) => {
  id: id,
  name: Some(""),
  patient_id: Some(""),
  date_of_diagnosis: Some(""),
  investigation: Some(""),
  treatments: Some(""),
  remarks: Some(""),
}
let decode = json => {
  open Json.Decode
  {
    id: field("id", optional(string), json),
    name: field("name", optional(string), json),
    patient_id: field("patient_id", optional(string), json),
    date_of_diagnosis: field("date_of_diagnosis", optional(string), json),
    investigation: field("investigation", optional(string), json),
    treatments: field("treatments", optional(string), json),
    remarks: field("remarks", optional(string), json),
  }
}
let getId = disease => disease.id
