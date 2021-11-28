type t = {
  full_name: option<string>,
  dob: option<string>,
  gender: option<string>,
  phone: option<string>,
  address: option<string>,
  route: option<string>,
  notes: option<string>,
  emergency_phone_no: option<string>,
  economic_status: option<string>,
  created_by: option<string>,
  facility_id: option<string>,
  disease: option<string>,
  patient_views: option<string>,
  family_views: option<string>,
}
let decode = json => {
  open Json.Decode
  {
    full_name: field("full_name", optional(string), json),
    dob: field("dob", optional(string), json),
    gender: field("gender", optional(string), json),
    phone: field("phone", optional(string), json),
    address: field("address", optional(string), json),
    route: field("route", optional(string), json),
    notes: field("notes", optional(string), json),
    emergency_phone_no: field("emergency_phone_no", optional(string), json),
    economic_status: field("economic_status", optional(string), json),
    created_by: field("created_by", optional(string), json),
    facility_id: field("facility_id", optional(string), json),
    disease: field("disease", optional(string), json),
    patient_views: field("patient_views", optional(string), json),
    family_views: field("family_views", optional(string), json),
  }
}
