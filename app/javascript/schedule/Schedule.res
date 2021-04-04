let s = React.string

let patients_original = [
  {
    "name": "Sam Parker",
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
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=09.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=10.0, ()),
  },
  {
    "name": "David Jackson",
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

let sort = %raw(`
  function(arr, sortOption) {
    return arr.sort((a, b) => a[sortOption] - b[sortOption])
  }
`)

module Schedule = {
  @react.component
  let make = (~visits) => {
    let (searchTerm, setSearchTerm) = React.useState(_ => "")
    let (sortOption, setSortOption) = React.useState(_ => "")
    let (procedureFilters, setProcedureFilters) = React.useState(_ => [])
    let (andProcedures, setAndProcedures) = React.useState(_ => false)
    let (wardFilters, setWardFilters) = React.useState(_ => [])
    let (patients, setPatients) = React.useState(_ => patients_original)

    Js.log3(visits, procedureFilters, wardFilters)

    let setFilter = (setBasisFilter, value, active) => {
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

    let setFilterOptions = (basis, value, active) => {
      if value == "and" {
        if basis == "procedure" {
          setAndProcedures(prev => !prev)
        }
      } else {
        switch basis {
        | "procedure" => setFilter(setProcedureFilters, value, active)
        | "ward" => setFilter(setWardFilters, value, active)
        | _ => ()
        }
      }
    }

    React.useEffect3(() => {
      let procedure_filtered_patients = !(procedureFilters->Js.Array2.length == 0)
        ? andProcedures
            ? patients_original->Js.Array2.filter(patient => {
                procedureFilters->Js.Array2.every(filter =>
                  filter->Js.Array.includes(patient["procedures"])
                )
              })
            : patients_original->Js.Array2.filter(patient => {
                procedureFilters->Js.Array2.some(filter =>
                  filter->Js.Array.includes(patient["procedures"])
                )
              })
        : patients_original

      let ward_filtered_patients = !(wardFilters->Js.Array2.length == 0)
        ? procedure_filtered_patients->Js.Array2.filter(patient => {
            wardFilters->Js.Array2.includes(patient["ward"]->Belt.Int.toString)
          })
        : procedure_filtered_patients

      setPatients(_ => ward_filtered_patients)
      None
    }, (procedureFilters, andProcedures, wardFilters))

    React.useEffect1(() => {
      let search_term = searchTerm->Js.String.toLowerCase
      let filtered_patients =
        patients->Js.Array2.filter(patient =>
          search_term->Js.String.includes(patient["name"]->Js.String.toLowerCase) ||
          patient["diseases"]->Js.Array2.some(disease =>
            search_term->Js.String.includes(disease->Js.String.toLowerCase)
          ) ||
          patient["procedures"]->Js.Array2.some(procedure =>
            search_term->Js.String.includes(procedure->Js.String.toLowerCase)
          ) ||
          search_term->Js.String.includes(patient["notes"]->Js.String.toLowerCase)
        )

      setPatients(_ => filtered_patients)
      None
    }, [searchTerm])

    React.useEffect1(() => {
      let sorted_patients = sort(patients, sortOption)
      setPatients(_ => sorted_patients)
      None
    }, [sortOption])

    let patientList = patients->Belt.Array.map(patient => <Patient patient />)

    <div>
      <SearchSortFilter setSearchTerm setSortOption setFilterOptions />
      <SelectedPatients />
      <div className="space-y-4"> {patientList->React.array} </div>
    </div>
  }
}

let run = visits => {
  switch ReactDOM.querySelector("#schedule") {
  | Some(root) => ReactDOM.render(<div> <Schedule visits /> </div>, root)
  | None => ()
  }
}
