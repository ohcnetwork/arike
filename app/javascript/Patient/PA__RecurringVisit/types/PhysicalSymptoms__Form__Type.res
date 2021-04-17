type t = {
  patient_at_peace: option<string>,
  pain: option<string>,
  shortness_breath: option<string>,
  weakness: option<string>,
  poor_mobility: option<string>,
  nausea: option<string>,
  vomiting: option<string>,
  poor_appetite: option<string>,
  constipation: option<string>,
  sore: option<string>,
  drowsiness: option<string>,
  wound: option<string>,
  lack_of_sleep: option<string>,
  micturition: option<string>,
}
let make = () => {
  patient_at_peace: Some(""),
  pain: Some(""),
  shortness_breath: Some(""),
  weakness: Some(""),
  poor_mobility: Some(""),
  nausea: Some(""),
  vomiting: Some(""),
  poor_appetite: Some(""),
  constipation: Some(""),
  sore: Some(""),
  drowsiness: Some(""),
  wound: Some(""),
  lack_of_sleep: Some(""),
  micturition: Some(""),
}

let decode = json => {
  open Json.Decode
  {
    patient_at_peace: field("patient_at_peace", optional(string), json),
    pain: field("pain", optional(string), json),
    shortness_breath: field("shortness_breath", optional(string), json),
    weakness: field("weakness", optional(string), json),
    poor_mobility: field("poor_mobility", optional(string), json),
    nausea: field("nausea", optional(string), json),
    vomiting: field("vomiting", optional(string), json),
    poor_appetite: field("poor_appetite", optional(string), json),
    constipation: field("constipation", optional(string), json),
    sore: field("sore", optional(string), json),
    drowsiness: field("drowsiness", optional(string), json),
    wound: field("wound", optional(string), json),
    lack_of_sleep: field("lack_of_sleep", optional(string), json),
    micturition: field("micturition", optional(string), json),
  }
}
