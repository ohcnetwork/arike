type patient = {
  name: string,
  id: string,
  ward: int,
}

type date = Js.Date.t

type patients = array<patient>

type schedule = {
    date: date,
    patients: patients
}

type schedules = array<schedule>

type props = {schedules: schedules}



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