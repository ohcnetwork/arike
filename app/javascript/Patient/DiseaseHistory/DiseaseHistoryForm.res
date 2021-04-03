module PatientDisease = {
  type t = {
    id: string,
    name: string,
    patient_id: string,
    date_of_diagnosis: string,
    investigation: string,
    treatments: string,
    status: string,
    remarks: string,
  }

  let make = (~id) => {
    id: id,
    name: "",
    patient_id: "",
    date_of_diagnosis: "",
    investigation: "",
    treatments: "",
    status: "",
    remarks: "",
  }
}

let s = React.string
type props = PatientDisease.t

@react.component
let make = (~props: props, ~onClick, ~list) => {
  let id = props.id
  <div
    className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6  rounded px-3 py-2 border-b pb-8">
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${id}][name]`} className="block text-sm font-medium text-gray-700">
        {s("Name of Disease")}
      </label>
      <div className="mt-1">
        <select
          name={`patientDiseases[${id}][name]`}
          defaultValue={props.name}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md">
          {list
          ->Belt.Array.map(e => <option key={e[1]} value={e[1]}> {s(e[0])} </option>)
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${id}][date_of_diagnosis]`}
        className="block text-sm font-medium text-gray-700">
        {s("Date of Diagnosis")}
      </label>
      <div className="mt-1">
        <input
          name={`patientDiseases[${id}][date_of_diagnosis]`}
          type_="date"
          defaultValue={props.date_of_diagnosis}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${id}][investigation]`}
        className="block text-sm font-medium text-gray-700">
        {s("Investigation")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.investigation}
          name={`patientDiseases[${id}][investigation]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${id}][treatments]`}
        className="block text-sm font-medium text-gray-700">
        {s("Treatments")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.treatments}
          name={`patientDiseases[${id}][treatments]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-6 field">
      <label
        name={`patientDiseases[${id}][remarks]`}
        className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.remarks}
          name={`patientDiseases[${id}][remarks]`}
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
