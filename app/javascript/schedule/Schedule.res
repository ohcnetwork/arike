let s = React.string

let patients_original = [
  {
    "name": "Sam Parker",
    "id": "1",
    "ward": 1,
    "diseases": ["Alzheimer", "Dementias"],
    "procedures": ["Simple Check", "Pregnency Checkup", "Dialysis", "Kidney Test"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=08.0, ()),
  },
  {
    "name": "Richard Brookfield",
    "id": "2",
    "ward": 1,
    "diseases": ["Epilepsy", "Alzheimer"],
    "procedures": ["Simple Check", "Through Check"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=14.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=04.0, ()),
  },
  {
    "name": "Amy Lucivell",
    "id": "3",
    "ward": 3,
    "diseases": ["Parkinson", "Stroke"],
    "procedures": [
      "Simple Check",
      "Through Check",
      "Dialysis",
      "Kidney Test",
      "Liver Test",
      "Pregnency Checkup",
    ],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=15.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=10.0, ()),
  },
  {
    "name": "David Jackson",
    "id": "4",
    "ward": 2,
    "diseases": ["Parkinson", "Transient Ischemic Attack", "Epilepsy", "Dementias"],
    "procedures": ["Simple Check"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=13.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=09.0, ()),
  },
  {
    "name": "Sammy Norms",
    "id": "5",
    "ward": 3,
    "diseases": ["Dementias"],
    "procedures": ["Simple Check", "Through Check", "Dialysis", "Kidney Test"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=10.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
]

let jssort = %raw(`
  function(arr, sortOption, ascending) {
    return arr.sort((a, b) => ascending ? a[sortOption] - b[sortOption] : b[sortOption] - a[sortOption])
  }
`)

module Schedule = {
  @react.component
  let make = (~visits) => {
    let (searchTerm, setSearchTerm) = React.useState(_ => "")
    let (sortOption, setSortOption) = React.useState(_ => "next_visit")
    let (sortAscending, setSortAscending) = React.useState(_ => true)
    let (procedureFilters, setProcedureFilters) = React.useState(_ => [])
    let (andProcedures, setAndProcedures) = React.useState(_ => false)
    let (wardFilters, setWardFilters) = React.useState(_ => [])
    let (patients, setPatients) = React.useState(_ => patients_original)
    let (selectedPatients, setSelectedPatients) = React.useState(_ => [])

    Js.log3(visits, sortAscending, sortOption)

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

      if value == "and" {
        if basis == "procedure" {
          setAndProcedures(prev => !prev)
        }
      } else {
        switch basis {
        | "procedure" => setFilter(setProcedureFilters)
        | "ward" => setFilter(setWardFilters)
        | _ => ()
        }
      }
    }

    let selectPatient = patient => {
      setSelectedPatients(patients => patients->Belt.Array.concat([patient]))
    }

    let unselectPatient = patient => {
      setSelectedPatients(patients =>
        patients->Belt.Array.reduce([], (acc, pat) => {
          if pat["id"] != patient["id"] {
            acc->Belt.Array.concat([pat])
          } else {
            acc
          }
        })
      )
    }

    React.useEffect7(() => {
      let unselectedPatients =
        patients_original->Js.Array2.filter(patient =>
          !(selectedPatients->Js.Array2.some(spatient => spatient["id"] == patient["id"]))
        )

      let procedure_filtered_patients = !(procedureFilters->Js.Array2.length == 0)
        ? andProcedures
            ? unselectedPatients->Js.Array2.filter(patient => {
                procedureFilters->Js.Array2.every(filter =>
                  filter->Js.Array.includes(patient["procedures"])
                )
              })
            : unselectedPatients->Js.Array2.filter(patient => {
                procedureFilters->Js.Array2.some(filter =>
                  filter->Js.Array.includes(patient["procedures"])
                )
              })
        : unselectedPatients

      let ward_filtered_patients = !(wardFilters->Js.Array2.length == 0)
        ? procedure_filtered_patients->Js.Array2.filter(patient => {
            wardFilters->Js.Array2.includes(patient["ward"]->Belt.Int.toString)
          })
        : procedure_filtered_patients

      let search_term = searchTerm->Js.String.toLowerCase
      let filtered_patients =
        ward_filtered_patients->Js.Array2.filter(patient =>
          search_term->Js.String.includes(patient["name"]->Js.String.toLowerCase) ||
          patient["diseases"]->Js.Array2.some(disease =>
            search_term->Js.String.includes(disease->Js.String.toLowerCase)
          ) ||
          patient["procedures"]->Js.Array2.some(procedure =>
            search_term->Js.String.includes(procedure->Js.String.toLowerCase)
          ) ||
          search_term->Js.String.includes(patient["notes"]->Js.String.toLowerCase)
        )

      let sorted_patients = filtered_patients->jssort(sortOption, sortAscending)

      setPatients(_ => sorted_patients)
      None
    }, (
      selectedPatients,
      searchTerm,
      sortOption,
      sortAscending,
      procedureFilters,
      andProcedures,
      wardFilters,
    ))

    let patientList =
      patients->Js.Array2.map(patient => <Patient key={patient["id"]} patient selectPatient />)

    <div>
      <SearchSortFilter
        setSearchTerm setSortOption sortAscending setSortAscending setFilterOptions
      />
      <SelectedPatients selectedPatients unselectPatient />
      <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {patientList->React.array}
      </ul>
    </div>
  }
}

let run = visits => {
  switch ReactDOM.querySelector("#schedule") {
  | Some(root) => ReactDOM.render(<div> <Schedule visits /> </div>, root)
  | None => ()
  }
}
