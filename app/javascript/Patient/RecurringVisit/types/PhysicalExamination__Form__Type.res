type t = {
  bp: option<string>,
  grbs: option<string>,
  rr: option<string>,
  pulse: option<string>,
  personal_hygiene: option<string>,
  mouth_hygiene: option<string>,
  pubic_hygiene: option<string>,
  systemic_examination: option<string>,
  systemic_examination_details: option<string>,
  done_by: option<string>,
}
let decode = json => {
  open Json.Decode
  {
    bp: field("bp", optional(string), json),
    grbs: field("grbs", optional(string), json),
    rr: field("rr", optional(string), json),
    pulse: field("pulse", optional(string), json),
    personal_hygiene: field("personal_hygiene", optional(string), json),
    mouth_hygiene: field("mouth_hygiene", optional(string), json),
    pubic_hygiene: field("pubic_hygiene", optional(string), json),
    systemic_examination: field("systemic_examination", optional(string), json),
    systemic_examination_details: field("systemic_examination_details", optional(string), json),
    done_by: field("done_by", optional(string), json),
  }
}
