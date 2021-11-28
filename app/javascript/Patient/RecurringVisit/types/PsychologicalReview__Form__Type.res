type t = {
  patient_worried: option<string>,
  family_anxious: option<string>,
  patient_feels: option<string>,
  patient_depressed: option<string>,
  patient_informed: option<string>,
}
let make = () => {
  {
    patient_worried: Some(""),
    family_anxious: Some(""),
    patient_feels: Some(""),
    patient_depressed: Some(""),
    patient_informed: Some(""),
  }
}
let decode = json => {
  open Json.Decode
  {
    patient_worried: field("patient_worried", optional(string), json),
    family_anxious: field("family_anxious", optional(string), json),
    patient_feels: field("patient_feels", optional(string), json),
    patient_depressed: field("patient_depressed", optional(string), json),
    patient_informed: field("patient_informed", optional(string), json),
  }
}
