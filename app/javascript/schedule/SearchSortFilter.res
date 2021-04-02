let s = React.string

module FilterOption = {
  @react.component
  let make = (~name) => {
    <div className="p-2 bg-white flex items-center justify-center">
      <span className="relative inline-flex items-center px-2 py-2">
        <input
          type_="checkbox"
          name={name}
          className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
        />
        <p className="px-2"> {s(name)} </p>
      </span>
    </div>
  }
}

@react.component
let make = () => {
  <div>
    <div className="p-8 flex items-center justify-center bg-white">
      //search
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
            />
          </div>
        </div>
      </div>
      //sort style={ReactDOM.Style.make(~minHeight="360px", ())}
      <div className="mx-auto w-64 z-10">
        <div className="relative inline-block text-left">
          <div>
            <button
              type_="button"
              className="inline-flex justify-center w-full rounded-l-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-100 focus:outline-none"
              id="sort-menu">
              {s("Sort")} <div className="px-2" /> <i className="fas fa-sort-down" />
            </button>
          </div>
          <div
            className="origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none">
            <div className="py-1">
              <a
                href="#"
                className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
                role="menuitem">
                {s("next-visit")}
              </a>
              <a
                href="#"
                className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
                role="menuitem">
                {s("last-visit")}
              </a>
            </div>
          </div>
        </div>
        <button
          className="-ml-px relative inline-flex items-center border shadow-sm px-4 py-2 border-gray-300 text-sm font-medium rounded-r-md text-gray-700 bg-gray-50 hover:bg-gray-100 focus:outline-none">
          {s(".")} <i className="fas fa-sort-numeric-up" />
        </button>
      </div>
      //filter -- procedures
      <div className="relative inline-block text-left z-10">
        <div>
          <button
            type_="button"
            className="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-100 focus:outline-none"
            id="sort-menu">
            {s("Filter")} <div className="px-2" /> <i className="fas fa-sort-down" />
          </button>
        </div>
        <div
          className="origin-top-right absolute right-0 mt-2 min-w-max rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none">
          <div className="py-1 grid grid-cols-2">
            // options
            <FilterOption name={"Procedure 1"} />
            <FilterOption name={"Procedure 2"} />
            <FilterOption name={"Procedure 3"} />
            <FilterOption name={"Procedure 4"} />
            <FilterOption name={"Procedure 5"} />
          </div>
          <div className="py-1 grid grid-cols-2">
            <FilterOption name={"Ward 1"} />
            <FilterOption name={"Ward 2"} />
            <FilterOption name={"Ward 3"} />
            <FilterOption name={"Ward 4"} />
            <FilterOption name={"Ward 5"} />
            <FilterOption name={"Ward 6"} />
          </div>
        </div>
      </div>
    </div>
  </div>
}
