let toString = str => {
  Js.Option.getWithDefault("", str)
}
let s = React.string
type props = DiseaseHistory__Type.t

@react.component
let make = (~props: props, ~onClick, ~list) => {
  let id = props.id
  <div
    className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6  rounded px-3 py-2 border-b pb-8">
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${toString(id)}][name]`}
        className="block text-sm font-medium text-gray-700">
        {s("Name of Disease")}
      </label>
      <div className="mt-1">
        <select
          name={`patientDiseases[${toString(id)}][name]`}
          defaultValue={toString(props.name)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          {list
          ->Js.Array2.map(e =>
            <option key={toString(e[1])} value={toString(e[1])}> {s(toString(e[0]))} </option>
          )
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${toString(id)}][date_of_diagnosis]`}
        className="block text-sm font-medium text-gray-700">
        {s("Date of Diagnosis")}
      </label>
      <div className="mt-1">
        <input
          name={`patientDiseases[${toString(id)}][date_of_diagnosis]`}
          type_="date"
          defaultValue={toString(props.date_of_diagnosis)}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${toString(id)}][investigation]`}
        className="block text-sm font-medium text-gray-700">
        {s("Investigation")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={toString(props.investigation)}
          name={`patientDiseases[${toString(id)}][investigation]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${toString(id)}][treatments]`}
        className="block text-sm font-medium text-gray-700">
        {s("Treatments")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={toString(props.treatments)}
          name={`patientDiseases[${toString(id)}][treatments]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-6 field">
      <label
        name={`patientDiseases[${toString(id)}][remarks]`}
        className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={toString(props.remarks)}
          name={`patientDiseases[${toString(id)}][remarks]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-32"
        />
      </div>
    </div>
    <button
      className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
      onClick={mouseEvt => {
        mouseEvt->ReactEvent.Mouse.preventDefault
        onClick()
      }}>
      {s("Delete")}
    </button>
  </div>
}
