type unscheduled_patient = {
  name: string,
  id: string,
  ward: int,
  procedures: array<string>,
  last_visit: Js.Date.t,
  next_visit: Js.Date.t,
}

type unscheduled_patients = {patients: array<unscheduled_patient>}

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
