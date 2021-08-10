let s = React.string

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

  <div className="mx-auto z-10 inline-flex p-2">
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
          : "origin-top-right absolute md:right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none z-10"}>
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
