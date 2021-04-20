type patient = Schedule__Types.patient
type patients = Schedule__Types.patients
type props = Schedule__Types.props

let s = React.string
let length = Js.Array2.length

@react.component
let make = (~props: props) => {
  let perPage = 9

  let (searchTerm, setSearchTerm) = React.useState(_ => "")
  let (sortOption, setSortOption) = React.useState(_ => "next_visit")
  let (sortAscending, setSortAscending) = React.useState(_ => true)
  let (patients, setPatients) = React.useState(_ => props.patients)
  let (selectedPatients, setSelectedPatients) = React.useState(_ => [])
  let (pageNumber, setPageNumber) = React.useState(_ => 1)
  let (filters, dispatch) = React.useReducer(Filter.reducer, {procedures: [], wards: []})

  let selectPatient = (patient: patient) => {
    setSelectedPatients(patients => patients->Belt.Array.concat([patient]))
  }

  let unselectPatient = (patient: patient) => {
    setSelectedPatients(patients =>
      patients->Belt.Array.reduce([], (acc, pat) => {
        if pat.id != patient.id {
          acc->Belt.Array.concat([pat])
        } else {
          acc
        }
      })
    )
  }

  React.useEffect5(() => {
    let unselectedPatients =
      props.patients->Js.Array2.filter(patient =>
        !(selectedPatients->Js.Array2.some(spatient => spatient.id == patient.id))
      )

    let procedure_filtered_patients = !(filters.procedures->length == 0)
      ? unselectedPatients->Js.Array2.filter(patient => {
          filters.procedures->Js.Array2.every(filter =>
            filter->Js.Array.includes(patient.procedures)
          )
        })
      : unselectedPatients

    let ward_filtered_patients = !(filters.wards->length == 0)
      ? procedure_filtered_patients->Js.Array2.filter(patient => {
          filters.wards->Js.Array2.includes(patient.ward->Belt.Int.toString)
        })
      : procedure_filtered_patients

    let search_term = searchTerm->Js.String.toLowerCase
    let filtered_patients =
      ward_filtered_patients->Js.Array2.filter(patient =>
        search_term->Js.String.includes(patient.name->Js.String.toLowerCase) ||
          patient.procedures->Js.Array2.some(procedure =>
            search_term->Js.String.includes(procedure->Js.String.toLowerCase)
          )
      )

    let sorted_patients = filtered_patients->Schedule__Utils.jssort(sortOption, sortAscending)

    setPatients(_ => sorted_patients)
    None
  }, (selectedPatients, searchTerm, sortOption, sortAscending, filters))

  let patientList =
    patients
    ->Js.Array2.slice(~start=(pageNumber - 1) * perPage, ~end_=pageNumber * perPage)
    ->Js.Array2.map(patient => <Patient key={patient.id} patient selectPatient />)

  <div>
    <div className="p-8 sm:flex items-center justify-center self-center text-center bg-white">
      <Search setSearchTerm placeholder="Search Patients" />
      <Sort setSortOption sortAscending setSortAscending />
      <Filter
        procedures={props.patients->Schedule__Utils.jsunion("procedures")}
        selectedFilters={filters}
        dispatch
      />
    </div>
    <SelectedPatients selectedPatients unselectPatient />
    <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
      {patientList->React.array}
    </ul>
    <Pagination
      pageNumber
      setPageNumber
      maxPages={
        let max_pages = patients->length / perPage
        mod(patients->length, perPage) == 0 ? max_pages : max_pages + 1
      }
    />
  </div>
}
