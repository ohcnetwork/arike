type patient = Schedule__Types.patient
type props = Schedule__Types.props

let s = React.string
let length = Js.Array2.length

@react.component
let make = (~props: props) => {
  let perPage = 9

  let (searchTerm, setSearchTerm) = React.useState(_ => "")
  let (sortOption, setSortOption) = React.useState(_ => "next_visit")
  let (sortAscending, setSortAscending) = React.useState(_ => true)
  let (pageNumber, setPageNumber) = React.useState(_ => 1)
  let (patients, updatePatients) = React.useReducer(
    Patients.reducer,
    {unselectedPatients: props.patients, selectedPatients: []},
  )
  let (filters, updateFilters) = React.useReducer(Filter.reducer, {procedures: [], wards: []})

  let upatients = patients.unselectedPatients

  Js.log(patients)

  React.useEffect4(() => {
    let procedure_filtered_patients = !(filters.procedures->length == 0)
      ? upatients->Js.Array2.filter(patient => {
          filters.procedures->Js.Array2.every(filter =>
            filter->Js.Array.includes(patient.procedures)
          )
        })
      : upatients

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

    Patients.SetUnSelectedPatients(sorted_patients)->updatePatients
    None
  }, (searchTerm, sortOption, sortAscending, filters))

  <div>
    <div className="p-8 sm:flex items-center justify-center self-center text-center bg-white">
      <Search setSearchTerm placeholder="Search Patients" />
      <Sort setSortOption sortAscending setSortAscending />
      <Filter
        procedures={props.patients->Schedule__Utils.jsunion("procedures")}
        selectedFilters={filters}
        updateFilters
      />
    </div>
    <Patients patients updatePatients pageNumber />
    <Pagination
      pageNumber
      setPageNumber
      maxPages={
        let max_pages = upatients->length / perPage
        mod(upatients->length, perPage) == 0 ? max_pages : max_pages + 1
      }
    />
  </div>
}
