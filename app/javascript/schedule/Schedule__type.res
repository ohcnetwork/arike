type patient = {
  name: string,
  id: string,
  ward: int,
  procedures: array<string>,
  last_visit: Js.Date.t,
  next_visit: Js.Date.t,
}

type patients = array<patient>

type props = {patients: patients}

let decode = json => {
  open Json.Decode
  {
    name: field("name", string, json),
    id: field("id", string, json),
    ward: field("ward", int, json),
    procedures: field("procedures", array(string), json),
    last_visit: field("last_visit", date, json),
    next_visit: field("next_visit", date, json),
  }
}
