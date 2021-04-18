type patient = Schedule__type.unscheduled_patient
type props = {patients: array<patient>}
let s = React.string

let jssort = %raw(`
  function(arr, sortOption, ascending) {
    return arr.sort((a, b) => {
      let c = a[sortOption];
      let d = b[sortOption];
      if(sortOption.includes("visit")) {
        c = Date.parse(c);
        d = Date.parse(d);
      }
      return ascending ? c - d : d - c;
    })
  }
`)

@react.component
let make = (~props: Schedule__type.unscheduled_patients) => {
  let perPage = 1

  let (searchTerm, setSearchTerm) = React.useState(_ => "")
  let (sortOption, setSortOption) = React.useState(_ => "next_visit")
  let (sortAscending, setSortAscending) = React.useState(_ => true)
  let (procedureFilters, setProcedureFilters) = React.useState(_ => [])
  let (wardFilters, setWardFilters) = React.useState(_ => [])
  let (patients, setPatients) = React.useState(_ => props.patients)
  let (selectedPatients, setSelectedPatients) = React.useState(_ => [])
  let (pageNumber, setPageNumber) = React.useState(_ => 1)

  let procedures = props.patients->Belt.Array.reduce([], (acc, patient) => {
    let s0 = Belt.Set.String.fromArray(acc)
    let s1 = Belt.Set.String.fromArray(patient.procedures)
    let acc = Belt.Set.String.union(s0, s1)
    acc->Belt.Set.String.toArray
  })

  Js.log(pageNumber)

  let setFilterOptions = (basis, value, active) => {
    let setFilter = setBasisFilter => {
      if active {
        setBasisFilter(filters => filters->Belt.Array.concat([value]))
      } else {
        setBasisFilter(filters =>
          filters->Belt.Array.reduce([], (acc, filter) => {
            if filter != value {
              acc->Belt.Array.concat([filter])
            } else {
              acc
            }
          })
        )
      }
    }

    switch basis {
    | "procedure" => setFilter(setProcedureFilters)
    | "ward" => setFilter(setWardFilters)
    | _ => ()
    }
  }

  let selectPatient = (patient: Schedule__type.unscheduled_patient) => {
    setSelectedPatients(patients => patients->Belt.Array.concat([patient]))
  }

  let unselectPatient = (patient: Schedule__type.unscheduled_patient) => {
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

  React.useEffect6(() => {
    let unselectedPatients =
      props.patients->Js.Array2.filter((patient: Schedule__type.unscheduled_patient) =>
        !(selectedPatients->Js.Array2.some(spatient => spatient.id == patient.id))
      )

    let procedure_filtered_patients = !(procedureFilters->Js.Array2.length == 0)
      ? unselectedPatients->Js.Array2.filter(patient => {
          procedureFilters->Js.Array2.every(filter => filter->Js.Array.includes(patient.procedures))
        })
      : unselectedPatients

    let ward_filtered_patients = !(wardFilters->Js.Array2.length == 0)
      ? procedure_filtered_patients->Js.Array2.filter(patient => {
          wardFilters->Js.Array2.includes(patient.ward->Belt.Int.toString)
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

    let sorted_patients = filtered_patients->jssort(sortOption, sortAscending)

    setPatients(_ => sorted_patients)
    None
  }, (selectedPatients, searchTerm, sortOption, sortAscending, procedureFilters, wardFilters))

  let patientList =
    patients
    ->Js.Array2.slice(~start=(pageNumber - 1) * perPage, ~end_=pageNumber * perPage)
    ->Js.Array2.map(patient => <Patient key={patient.id} patient selectPatient />)

  <div>
    <SearchSortFilter
      setSearchTerm setSortOption sortAscending setSortAscending setFilterOptions procedures
    />
    <SelectedPatients selectedPatients unselectPatient />
    <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
      {patientList->React.array}
    </ul>
    <Pagination
      pageNumber
      setPageNumber
      maxPages={
        let max_pages = patients->Js.Array2.length / perPage
        mod(patients->Js.Array2.length, perPage) == 0 ? max_pages : max_pages + 1
      }
    />
  </div>
}
