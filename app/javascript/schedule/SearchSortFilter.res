let s = React.string

module Search = {
  @react.component
  let make = (~setSearchTerm) => {
    let onSearchTermChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]

      setSearchTerm(_ => value)
    }

    <div className="w-full max-w-xs mx-auto">
      <div>
        <div className="mt-1 relative rounded-md shadow-sm">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <i className="fas fa-search" />
          </div>
          <input
            type_="text"
            className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
            placeholder="Search Patients"
            onChange={onSearchTermChange}
          />
        </div>
      </div>
    </div>
  }
}

module Sort = {
  @react.component
  let make = (~setSortOption) => {
    let (showDropdown, setShowDropdown) = React.useState(_ => false)

    let toggleDropDown = _evt => {
      setShowDropdown(isVisible => !isVisible)
    }

    let onSortOptionChange = event => {
      let value = ReactEvent.Synthetic.currentTarget(event)["value"]

      setSortOption(_ => value)
      setShowDropdown(_ => false)
    }

    <div className="mx-auto w-64 z-10">
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
              value="next-visit"
              onClick={onSortOptionChange}>
              {s("next-visit")}
            </option>
            <option
              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
              value="last-visit"
              onClick={onSortOptionChange}>
              {s("last-visit")}
            </option>
          </div>
        </div>
      </div>
      <button
        className="-ml-px relative inline-flex items-center border shadow-sm px-4 py-2 border-gray-300 text-sm font-medium rounded-r-md text-gray-700 bg-gray-50 hover:bg-gray-100 focus:outline-none">
        {s(".")} <i className="fas fa-sort-numeric-up" />
      </button>
    </div>
  }
}

module FilterOption = {
  @react.component
  let make = (~name, ~onFilterOptionsChange) => {
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
  let make = (~setFilterOptions) => {
    let (showDropdown, setShowDropdown) = React.useState(_ => false)

    let toggleDropDown = _evt => {
      setShowDropdown(isVisible => !isVisible)
    }

    let onFilterOptionsChange = event => {
      let checked = ReactEvent.Synthetic.currentTarget(event)["checked"]
      let value = ReactEvent.Synthetic.currentTarget(event)["name"]

      if checked {
        setFilterOptions(filters => filters->Belt.Array.concat([value]))
      } else {
        setFilterOptions(filters =>
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
        <div className="py-1 grid grid-cols-2">
          <FilterOption onFilterOptionsChange name={"Procedure 1"} />
          <FilterOption onFilterOptionsChange name={"Procedure 2"} />
          <FilterOption onFilterOptionsChange name={"Procedure 3"} />
          <FilterOption onFilterOptionsChange name={"Procedure 4"} />
          <FilterOption onFilterOptionsChange name={"Procedure 5"} />
        </div>
        <div className="py-1 grid grid-cols-2">
          <FilterOption onFilterOptionsChange name={"Ward 1"} />
          <FilterOption onFilterOptionsChange name={"Ward 2"} />
          <FilterOption onFilterOptionsChange name={"Ward 3"} />
          <FilterOption onFilterOptionsChange name={"Ward 4"} />
          <FilterOption onFilterOptionsChange name={"Ward 5"} />
          <FilterOption onFilterOptionsChange name={"Ward 6"} />
        </div>
      </div>
    </div>
  }
}

@react.component
let make = (~setSearchTerm, ~setSortOption, ~setFilterOptions) => {
  <div>
    <div className="p-8 flex items-center justify-center bg-white">
      <Search setSearchTerm /> <Sort setSortOption /> <Filter setFilterOptions />
    </div>
  </div>
}
