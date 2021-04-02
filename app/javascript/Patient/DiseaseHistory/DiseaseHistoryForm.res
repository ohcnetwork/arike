module PatientDisease = {
  type t = {
    id: string,
    name: string,
    patient_id: string,
    date_of_diagnosis: string,
    investigation: string,
    treatements: string,
    status: string,
    remarks: string,
  }

  let make = (~id) => {
    id: id,
    name: "",
    patient_id: "",
    date_of_diagnosis: "",
    investigation: "",
    treatements: "",
    status: "",
    remarks: "",
  }
}

let s = React.string
type props = PatientDisease.t

@react.component
let make = (~props: props, ~onClick) => {
  let id = props.id
  <div
    className="mt-6 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6  rounded px-3 py-2">
    <div className="sm:col-span-3 field px-2">
      <label name={`patientDiseases[${id}][name]`}
      className="block text-sm font-medium text-gray-700">
        {s("Name of Disease")}
      </label>
      <div className="mt-1">
        <input
          type_="text"
          name={`patientDiseases[${id}][name]`}
          defaultValue={props.name}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
          required={true}
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label name={`patientDiseases[${id}][date_of_diagnosis]`} className="block text-sm font-medium text-gray-700">
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
        name={`patientDiseases[${id}][investigation]`} className="block text-sm font-medium text-gray-700">
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
        name={`patientDiseases[${id}][treatments]`} className="block text-sm font-medium text-gray-700">
        {s("Treatments")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.remarks}
          name={`patientDiseases[${id}][treatments]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>

    <div className="sm:col-span-3 field">
      <label
        name={`patientDiseases[${id}][remarks]`} className="block text-sm font-medium text-gray-700">
        {s("Remark")}
      </label>
      <div className="mt-1">
        <textarea
          defaultValue={props.remarks}
          name={`patientDiseases[${id}][remarks]`}
          className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="mt-1">
      <button
        onClick={mouseEvt => {
          mouseEvt->ReactEvent.Mouse.preventDefault
          onClick()
        }}>
        {s("Delete")}
      </button>
    </div>
  </div>
}
