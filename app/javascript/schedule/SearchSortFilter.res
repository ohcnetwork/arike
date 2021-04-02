let s = React.string

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
              className="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-100 focus:ring-indigo-500"
              id="sort-menu">
              {s("Sort")} <i className="fas fa-sort-down" />
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
      </div>
    </div>
  </div>
}
