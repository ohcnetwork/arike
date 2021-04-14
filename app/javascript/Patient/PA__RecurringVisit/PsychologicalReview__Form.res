let s = React.string
@react.component
let make = () => {
  <div className="grid grid-cols-1 sm:grid-cols-6">
    <div className="sm:col-span-3 field">
      <label className="block text-sm font-medium text-gray-700"> {s("Enter details.")} </label>
      <div className="mt-1">
        <textarea
          type_="text"
          name="disease_history_changed"
          cols=50
          rows=1
          id="patientvitals-form"
          required=true
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
  </div>
}
