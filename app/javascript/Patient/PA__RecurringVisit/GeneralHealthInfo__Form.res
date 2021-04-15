let s = React.string
let health_statuses = ["0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
let phases_of_illness = ["Not selected", "Stable", "Unstable", "Deteriorating", "Dying"]

@react.component
let make = () => {
  <div className="w-full">
    <div className="font-bold text-xl mb-5">{s("General Health Information")}</div>
    <div className="sm:col-span-3 field py-2 my-4">
      <label
        className="block text-sm font-medium
          text-gray-700">
        {s("Patient's general health status(AKPS)")}
      </label>
      <div className="mt-1">
        <select
          name="akps"
          required=true
          className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
          {health_statuses
          ->Js.Array2.map(op =>
            <option key=op value=op > {s(op)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field py-2 my-4">
      <label
        className="block text-sm font-medium
          text-gray-700">
        {s("Palliative phase of illness")}
      </label>
      <div className="mt-1">
        <select
          name="palliative_phase"
          required=true
          className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
          {phases_of_illness
          ->Js.Array2.map(op =>
            <option key=op value=op > {s(op)} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field mt-4">
      <label className="block text-sm font-medium text-gray-700">
        {s("Any changes in disease history?")}
      </label>
      <div className="sm:col-span-2">
        <div className="mt-2 flex">
          {["Yes", "No"]
          ->Belt.Array.map(op => {
            <div className="flex items-center it">
              <input
                name="disease_history_radio"
                type_="radio"
                required=true
                className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300"
              />
              <label className="ml-3 mr-4 block text-sm font-medium text-gray-700"> {s(op)} </label>
            </div>
          })
          ->React.array}
        </div>
      </div>
    </div>
  </div>
}
