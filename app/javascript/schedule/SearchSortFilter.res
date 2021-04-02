let s = React.string

@react.component
let make = () => {
  <div>
    //search
    <div className="p-8 flex items-center justify-center bg-white">
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
    </div>
  </div>
}
