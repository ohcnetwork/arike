let s = React.string

@react.component
let make = () => {
  <div>
    <li
      id="radiogroup-option-1"
      className="group relative bg-white rounded-lg shadow-sm cursor-pointer focus:outline-none focus:ring-1 focus:ring-offset-2 focus:ring-indigo-500 list-none">
      <div
        className="rounded-lg border border-gray-300 bg-white px-6 py-4 hover:border-gray-400 sm:flex sm:justify-between">
        <div className="flex items-center">
          <div className="text-sm">
            <p className="font-medium text-gray-900"> {s("Startup")} </p>
            <div className="text-gray-500">
              <p className="sm:inline"> {s("12GB / 6 CPUs")} </p>
              <span className="hidden sm:inline sm:mx-1"> {s("·")} </span>
              <p className="sm:inline"> {s("256 GB SSD disk")} </p>
            </div>
          </div>
        </div>
        <div className="mt-2 flex text-sm sm:mt-0 sm:block sm:ml-4 sm:text-right">
          <div className="font-medium text-gray-900"> {s("$80")} </div>
          <div className="ml-1 text-gray-500 sm:ml-0"> {s("/mo")} </div>
        </div>
      </div>
      <div
        className="border-transparent absolute inset-0 rounded-lg border-2 pointer-events-none"
      />
    </li>
  </div>
}
