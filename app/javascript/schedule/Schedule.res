let s = React.string

let patients = [
  {
    "name": "Patient 1",
    "diseases": ["disease1", "disease2"],
    "procedures": ["procedure1", "procedure2", "procedure3", "procedure4"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
  {
    "name": "Patient 2",
    "diseases": ["disease1", "disease2"],
    "procedures": ["procedure1", "procedure2"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
  {
    "name": "Patient 3",
    "diseases": ["disease1", "disease2"],
    "procedures": [
      "procedure1",
      "procedure2",
      "procedure3",
      "procedure4",
      "procedure5",
      "procedure6",
    ],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
  {
    "name": "Patient 4",
    "diseases": ["diseaseeeeeeeeeeeee1", "disease2", "disease3", "disease4"],
    "procedures": ["procedure1"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
  {
    "name": "Patient 5",
    "diseases": ["disease1"],
    "procedures": ["procedure1", "procedure2", "procedure3", "procedure4"],
    "notes": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et
    Nulla consequat ",
    "last_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=01.0, ()),
    "next_visit": Js.Date.makeWithYMD(~year=2021.0, ~month=04.0, ~date=07.0, ()),
  },
]

let patientList = patients->Belt.Array.map(patient => <Patient patient />)

module Schedule = {
  @react.component
  let make = (~visits) => {
    Js.log(visits)

    <div>
      <SearchSortFilter />
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
