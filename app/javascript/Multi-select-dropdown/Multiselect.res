let str = React.string

module MinimalExample = {
  module Selectable = {
    type rec t = Volunteer(id, name)
    and id = string
    and name = string

    let label = _t => None

    let id = t =>
      switch t {
      | Volunteer(id, _) => id
      }

    let value = t =>
      switch t {
      | Volunteer(_, name) => name
      }

    let searchString = t => t->value
    let color = _t => "gray"

    let makeVolunteer = (~id, ~name) => Volunteer(id, name)
  }

  // create a Multiselect
  module Multiselect = MultiselectDropdown.Make(Selectable)

  type state = {
    selected: array<Selectable.t>,
    searchString: string,
  }

  let unselected = [
    Selectable.makeVolunteer(~id="1", ~name="Yash Raj Gupta"),
    Selectable.makeVolunteer(~id="2", ~name="jjjj"),
    Selectable.makeVolunteer(~id="3", ~name="kkkk"),
    Selectable.makeVolunteer(~id="4", ~name="llll"),
    Selectable.makeVolunteer(~id="5", ~name="Ypp"),
  ]

  let deselect = (selected, setState, selectable) => {
    let newSelected = selected |> Js.Array.filter(s => s != selectable)
    setState(_ => {searchString: "", selected: newSelected})
  }

  @react.component
  let make = () => {
    let (state, setState) = React.useState(() => {searchString: "", selected: []})
    let (us, setUS) = React.useState(() => unselected)

    React.useEffect1(() => {
      let na = us->Js.Array2.filter(tmp => {
        let got = state.selected->Js.Array2.find(elem => elem->Selectable.id == tmp->Selectable.id)
        !(got->Belt.Option.isSome)
      })

      Js.log(na)

      setUS(_ => na)

      None
    }, [state])

    <div className="mt-4">
      <div className="mt-4">
        <label
          className="block text-sm font-medium text-gray-700"
          htmlFor="MultiselectDropdown__search-input">
          {"Asha Member " |> str}
        </label>
      </div>
      <Multiselect
        unselected=us
        selected={state.selected}
        onSelect={selectable =>
          setState(s => {
            searchString: "",
            selected: [selectable] |> Array.append(s.selected),
          })}
        onDeselect={deselect(state.selected, setState)}
        value={state.searchString}
        onChange={searchString => setState(s => {...s, searchString: searchString})}
        hint="Enter Name"
        defaultOptions=us
      />
    </div>
  }
}
