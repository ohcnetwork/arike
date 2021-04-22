type patient = Schedule__Types.patient
type patients = {
  unselectedPatients: array<patient>,
  selectedPatients: array<patient>,
}

let perPage = 3

type action =
  | SetUnSelectedPatients(array<patient>)
  | SelectPatient(patient)
  | UnselectPatient(patient)

let reducer = (patients, action) => {
  switch action {
  | SetUnSelectedPatients(upatients) => {...patients, unselectedPatients: upatients}
  | SelectPatient(patient) => {
      let selectedPatients = Js.Array2.concat(patients.selectedPatients, [patient])
      let unselectedPatients =
        patients.unselectedPatients->Js.Array2.filter(spatient => spatient !== patient)
      {selectedPatients: selectedPatients, unselectedPatients: unselectedPatients}
    }

  | UnselectPatient(patient) => {
      let selectedPatients =
        patients.selectedPatients->Js.Array2.filter(spatient => spatient !== patient)
      let unselectedPatients = Js.Array2.concat(patients.unselectedPatients, [patient])
      {selectedPatients: selectedPatients, unselectedPatients: unselectedPatients}
    }
  }
}

@react.component
let make = (~patients, ~updatePatients, ~pageNumber) => {
  let spatients = patients.selectedPatients
  let upatients = patients.unselectedPatients
  let patientList =
    upatients
    ->Js.Array2.slice(~start=(pageNumber - 1) * perPage, ~end_=pageNumber * perPage)
    ->Js.Array2.map(patient =>
      <Patient
        key={patient.id} patient selectPatient={patient => patient->SelectPatient->updatePatients}
      />
    )

  <div>
    <SelectedPatients
      selectedPatients={spatients}
      unselectPatient={patient => patient->UnselectPatient->updatePatients}
    />
    <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
      {patientList->React.array}
    </ul>
  </div>
}
