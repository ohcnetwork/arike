type t = {
  akps: option<string>,
  palliative_phase: option<string>,
  disease_history_radio: option<string>,
}

let make = () => {
  akps: Some(""),
  palliative_phase: Some(""),
  disease_history_radio: Some(""),
}

let decode = json => {
  open Json.Decode
  {
    akps: field("akps", optional(string), json),
    palliative_phase: field("palliative_phase", optional(string), json),
    disease_history_radio: Some(""), //field("disease_history_radio", optional(string), json),
  }
}
