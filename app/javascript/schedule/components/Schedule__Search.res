@react.component
let make = (~setSearchTerm, ~placeholder="Search") => {
  let onSearchTermChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]

    setSearchTerm(_ => value)
  }

  <div className="w-full max-w-xs mx-auto p-2">
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
