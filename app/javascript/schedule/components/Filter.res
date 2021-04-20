let s = React.string

type filters = {
  procedures: array<string>,
  wards: array<string>,
}

type action =
  | AddFilter(string, string)
  | RemoveFilter(string, string)

let reducer = (filters, action) => {
  switch action {
  | AddFilter(type_, value) =>
    switch type_ {
    | "procedure" => {
        let procedures = Js.Array2.concat(filters.procedures, [value])
        {...filters, procedures: procedures}
      }
    | "ward" => {
        let wards = Js.Array2.concat(filters.wards, [value])
        {...filters, wards: wards}
      }
    | _ => filters
    }

  | RemoveFilter(type_, value) =>
    switch type_ {
    | "procedure" => {
        let procedures = filters.procedures->Js.Array2.filter(procedure => procedure !== value)
        {...filters, procedures: procedures}
      }
    | "ward" => {
        let wards = filters.wards->Js.Array2.filter(ward => ward !== value)
        {...filters, wards: wards}
      }
    | _ => filters
    }
  }
}

module FilterOption = {
  @react.component
  let make = (~name, ~basis, ~selected, ~dispatchx) => {
    let onFilterOptionsChange = event => {
      let checked = ReactEvent.Synthetic.currentTarget(event)["checked"]
      let value = ReactEvent.Synthetic.currentTarget(event)["name"]
      checked ? dispatchx(AddFilter(basis, value)) : dispatchx(RemoveFilter(basis, value))
    }

    <div className="p-2 bg-white flex items-center justify-center">
      <span className="relative inline-flex items-center px-2 py-2">
        <input
          type_="checkbox"
          className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
          name={name}
          checked={selected}
          onChange={onFilterOptionsChange}
        />
        <p className="px-2"> {s(name)} </p>
      </span>
    </div>
  }
}

module FilterSection = {
  @react.component
  let make = (~name, ~filters, ~selectedFilters, ~searchbar=false, ~dispatch) => {
    let (searchTerm, setSearchTerm) = React.useState(_ => "")
    let (options, setOptions) = React.useState(_ => filters)

    React.useEffect1(() => {
      let search_term = searchTerm->Js.String.toLowerCase
      let filtered_options =
        filters->Js.Array2.filter(filter =>
          search_term->Js.String.includes(filter->Js.String.toLowerCase)
        )

      setOptions(_ => filtered_options)
      None
    }, [searchTerm])

    <div className="py-1">
      <div className="text-center p-2 font-bold"> {s(name ++ "(s)")} </div>
      {searchbar ? <Search setSearchTerm placeholder={"Search " ++ name ++ "(s)"} /> : <div />}
      <div className="grid grid-cols-1 justify-items-start md:grid-cols-2">
        {options
        ->Belt.Array.map(option =>
          <FilterOption
            name={option}
            basis={name->Js.String.toLowerCase}
            selected={selectedFilters->Js.Array2.includes(option)}
            key={option}
            dispatchx={dispatch}
          />
        )
        ->React.array}
      </div>
    </div>
  }
}

@react.component
let make = (~procedures, ~selectedFilters, ~dispatch) => {
  let (showDropdown, setShowDropdown) = React.useState(_ => false)

  let toggleDropDown = _evt => {
    setShowDropdown(isVisible => !isVisible)
  }

  <div className="vs:relative inline-block text-left p-2">
    <div>
      <button
        type_="button"
        className="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-100 focus:outline-none"
        onClick={toggleDropDown}>
        {s("Filter")} <div className="px-2" /> <i className="fas fa-sort-down" />
      </button>
    </div>
    <div
      className={!showDropdown
        ? "hidden"
        : "m-2 origin-top-right absolute right-0 mt-2 min-w-max rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none z-10"}>
      <FilterSection
        name="Procedure"
        filters={procedures}
        selectedFilters={selectedFilters.procedures}
        searchbar={true}
        dispatch
      />
      <FilterSection
        name="Ward"
        selectedFilters={selectedFilters.wards}
        filters={["1", "2", "3", "4", "5"]}
        dispatch
      />
    </div>
  </div>
}
