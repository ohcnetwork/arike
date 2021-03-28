let s = React.string

/* Add State for capturing data */
module PatientVitals = {
  @react.component
  let make = () => {
    <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-3xl mx-auto">
        <form action="/patients" method="post">
          <div className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700">
                {s("Patient's general health status(AKPS)")}
              </label>
              <div className="mt-1">
                <input
                  type_="number"
                  min="0"
                  max="100"
                  name="AKPS"
                  className="shadow-sm
              focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm
              border-gray-300 rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700">
                {s("Any change in disease history? If yes,enter details.")}
              </label>
              <div className="mt-1">
                <input
                  type_="text"
                  name="disease_history_changed"
                  className="shadow-sm focus:ring-indigo-500
              focus:border-indigo-500 block w-full sm:text-sm border-gray-300
              rounded-md"
                />
              </div>
            </div>
            <div className="sm:col-span-3 field">
              <label className="block text-sm font-medium text-gray-700">
                {s("Palliative phase of illness")}
              </label>
              <div className="mt-1">
                <select
                  name="palliative_phase"
                  className="shadow-sm focus:ring-indigo-500
            focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
                  <option value="Stable"> {s("Stable")} </option>
                  <option value="Unstable"> {s("Unstable")} </option>
                  <option value="Deteriorating"> {s("Deteriorating")} </option>
                  <option value="Dying"> {s("Dying")} </option>
                </select>
              </div>
            </div>
            <div className="sm:col-span-3 field ">
              <p className="block text-sm font-medium text-gray-700"> {s("Change text size")} </p>
              <div className="flex items-center text-sm mt-1">
                <div id="radio-text-size" className="flex">
                  <label className="flex items-center pr-8">
                    <input
                      className="mr-2 focus:ring-indigo-500
            focus:border-indigo-500"
                      type_="radio"
                      name="textSize"
                      id="selectSmall"
                    />
                    <span> {s("Small")} </span>
                  </label>
                  <label className="flex items-center pr-8">
                    <input
                      className="mr-2 focus:ring-indigo-500
            focus:border-indigo-500"
                      type_="radio"
                      name="textSize"
                      id="selectRegular"
                    />
                    <span> {s("Regular")} </span>
                  </label>
                  <label className="flex items-center pr-8">
                    <input
                      className="mr-2 focus:ring-indigo-500
            focus:border-indigo-500"
                      type_="radio"
                      name="textSize"
                      id="selectLarge"
                    />
                    <span> {s("Large")} </span>
                  </label>
                </div>
              </div>
            </div>
          </div>
          <div className="actions">
            <input
              type_="submit"
              className="mt-4 inline-flex justify-center py-2 px-4 border
          border-transparent shadow-sm text-sm font-medium rounded-md text-white
          bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2
          focus:ring-offset-2 focus:ring-indigo-500"
            />
          </div>
        </form>
      </div>
    </div>
  }
}

let run = () => {
  switch ReactDOM.querySelector("#patient-vitals-form") {
  | Some(root) => ReactDOM.render(<div> <PatientVitals /> </div>, root)
  | None => () // do nothing
  }
}
