type t = {
  date: Js.Date.t,
  treatments: array<PatientTreatment__Treatment.t>,
}

let date = t => t.date
let treatments = t => t.treatments

let make = (~date, ~treatments) => {
  date: date,
  treatments: treatments,
}
