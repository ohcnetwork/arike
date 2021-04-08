type t = {
  id: option<string>,
  patient_id: option<string>,
  full_name: option<string>,
  relation: option<string>,
  dob: option<string>,
  phone: option<string>,
  education: option<string>,
  occupation: option<string>,
  remarks: option<string>,
}
let make = (~id) => {
  id: Some(id),
  patient_id: Some(""),
  full_name: Some(""),
  relation: Some(""),
  dob: Some(""),
  phone: Some(""),
  education: Some(""),
  occupation: Some(""),
  remarks: Some(""),
}
let decode = json => {
  open Json.Decode
  {
    id: field("id", optional(string), json),
    patient_id: field("patient_id", optional(string), json),
    full_name: field("full_name", optional(string), json),
    relation: field("relation", optional(string), json),
    dob: field("dob", optional(string), json),
    phone: field("phone", optional(string), json),
    education: field("education", optional(string), json),
    occupation: field("occupation", optional(string), json),
    remarks: field("remarks", optional(string), json),
  }
}
let getId = member => {member.id}
