let s = React.string

module Search = {
  @react.component
  let make = (~setSearchTerm, ~placeholder="Search") => {
    let onSearchTermChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]

      setSearchTerm(_ => value)
    }

    <div className="w-full max-w-xs mx-auto">
      <div>
        <div className="relative rounded-md shadow-sm">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <i className="fas fa-search" />
          </div>
          <input
            type_="text"
            className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
            placeholder={placeholder}
            onChange={onSearchTermChange}
          />
        </div>
      </div>
    </div>
  }
}

module Sort = {
  @react.component
  let make = (~setSortOption, ~sortAscending, ~setSortAscending) => {
    let (showDropdown, setShowDropdown) = React.useState(_ => false)

    let toggleDropDown = _evt => {
      setShowDropdown(isVisible => !isVisible)
    }

    let toggleSortOrder = _evt => {
      setSortAscending(prev => !prev)
    }

    let onSortOptionChange = event => {
      let value = ReactEvent.Synthetic.currentTarget(event)["value"]

      setSortOption(_ => value)
      setShowDropdown(_ => false)
    }

    <div className="mx-auto w-64 z-10 flex">
      <div className="relative inline-block text-left">
        <div>
          <button
            type_="button"
            className="inline-flex justify-center w-full rounded-l-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-100 focus:outline-none"
            id="sort-menu"
            onClick={toggleDropDown}>
            {s("Sort")} <div className="px-2" /> <i className="fas fa-sort-down" />
          </button>
        </div>
        <div
          className={!showDropdown
            ? "hidden"
            : "origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none"}>
          <div className="py-1">
            <option
              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
              value="next_visit"
              onClick={onSortOptionChange}>
              {s("next visit")}
            </option>
            <option
              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
              value="last_visit"
              onClick={onSortOptionChange}>
              {s("last visit")}
            </option>
          </div>
        </div>
      </div>
      <button
        className="-ml-px relative inline-flex items-center min-w-max space-x-2 px-4 py-2 border border-gray-300 text-sm font-medium rounded-r-md text-gray-700 bg-gray-50 hover:bg-gray-100 focus:outline-none"
        onClick={toggleSortOrder}>
        {sortAscending
          ? <div key="sort-alpha-down"> <i className="fas fa-sort-alpha-down" /> </div>
          : <div key="sort-alpha-up"> <i className="fas fa-sort-alpha-up" /> </div>}
      </button>
    </div>
  }
}

module FilterOption = {
  @react.component
  let make = (~name, ~basis, ~setFilterOptions) => {
    let onFilterOptionsChange = event => {
      let checked = ReactEvent.Synthetic.currentTarget(event)["checked"]
      let value = ReactEvent.Synthetic.currentTarget(event)["name"]

      setFilterOptions(basis, value, checked)
    }

    <div className="p-2 bg-white flex items-center justify-center">
      <span className="relative inline-flex items-center px-2 py-2">
        <input
          type_="checkbox"
          className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
          name={name}
          onChange={onFilterOptionsChange}
        />
        <p className="px-2"> {s(name)} </p>
      </span>
    </div>
  }
}

module Filter = {
  @react.component
  let make = (~setFilterOptions, ~procedures) => {
    let (showDropdown, setShowDropdown) = React.useState(_ => false)
    let (searchTerm, setSearchTerm) = React.useState(_ => "")
    let (options, setOptions) = React.useState(_ => procedures)

    let toggleDropDown = _evt => {
      setShowDropdown(isVisible => !isVisible)
    }

    React.useEffect1(() => {
      let search_term = searchTerm->Js.String.toLowerCase
      let filtered_procedures =
        procedures->Js.Array2.filter(procedure =>
          search_term->Js.String.includes(procedure->Js.String.toLowerCase)
        )

      setOptions(_ => filtered_procedures)
      None
    }, [searchTerm])

    <div className="relative inline-block text-left z-10">
      <div>
        <button
          type_="button"
          className="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-100 focus:outline-none"
          id="sort-menu"
          onClick={toggleDropDown}>
          {s("Filter")} <div className="px-2" /> <i className="fas fa-sort-down" />
        </button>
      </div>
      <div
        className={!showDropdown
          ? "hidden"
          : "origin-top-right absolute right-0 mt-2 min-w-max rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none"}>
        <div className="py-1">
          <div className="text-center p-2 font-bold"> {s("Procedures")} </div>
          <Search setSearchTerm placeholder="Search Procedures" />
          <div className=" grid grid-cols-2 justify-items-start">
            {options
            ->Belt.Array.map(procedure =>
              <FilterOption setFilterOptions name={procedure} basis="procedure" key={procedure} />
            )
            ->React.array}
          </div>
        </div>
        <div className="py-1">
          <div className="text-center p-2 font-bold"> {s("Ward")} </div>
          <div className=" grid grid-cols-2 justify-items-start">
            <FilterOption setFilterOptions name={"1"} basis="ward" />
            <FilterOption setFilterOptions name={"2"} basis="ward" />
            <FilterOption setFilterOptions name={"3"} basis="ward" />
            <FilterOption setFilterOptions name={"4"} basis="ward" />
            <FilterOption setFilterOptions name={"5"} basis="ward" />
            <FilterOption setFilterOptions name={"6"} basis="ward" />
          </div>
        </div>
      </div>
    </div>
  }
}

@react.component
let make = (
  ~setSearchTerm,
  ~setSortOption,
  ~sortAscending,
  ~setSortAscending,
  ~setFilterOptions,
  ~procedures,
) => {
  <div>
    <div className="p-8 sm:flex items-center justify-center bg-white">
      <Search setSearchTerm placeholder="Search Patients" />
      <Sort setSortOption sortAscending setSortAscending />
      <Filter setFilterOptions procedures />
    </div>
  </div>
}
