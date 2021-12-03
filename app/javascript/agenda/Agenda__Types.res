type patient = {
  name: string,
  id: string,
  ward: int,
}

type patients = array<patient>

type scheduled_patients = {
    date: Js.Date.t,
    patients: patients
}

type props = {scheduled_patients: array<scheduled_patients>}



let decodePatient = patient => {
    open Json.Decode
    {
        name: field("name", string, patient),
        id: field("id", string, patient),
        ward: field("ward", int, patient),
    }
}

let decode = json => {
    open Json.Decode
    {
        date: field("next_visit", date, json),
        patients: field("patients", array(decodePatient), json),
    }
}