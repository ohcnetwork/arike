@react.component
let make = (~setSearchTerm, ~placeholder="Search") => {
    let onSearchTermChange = event => {
        let value = ReactEvent.Form.currentTarget(event)["value"]

        setSearchTerm(_ => value)
    }

    <div className="relative mb-4">
        <input
            type_="text"
            className="block w-full bg-white border border-gray-300 rounded-md py-2 pl-3 text-sm placeholder-gray-500 focus:outline-none focus:text-gray-900 focus:placeholder-gray-400 focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
            placeholder={placeholder}
            onChange={onSearchTermChange}
        />
        
        <div className="absolute inset-y-0 right-0 pr-3 flex items-center">
            <div className="cursor-pointer focus:outline-none">
                <i className="fas fa-search" />
            </div>
        </div>
    </div>
}