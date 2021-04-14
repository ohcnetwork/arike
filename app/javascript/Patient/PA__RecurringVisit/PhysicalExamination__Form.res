let s = React.string
let systematic_examination_options = [
  "Not selected",
  "Cardiovascular",
  "Gastrointestinal",
  "Central nervous system",
  "Respiratory",
  "Genital-urinary",
]
@react.component
let make = (~name, ~role) => {
  <div className="grid grid-cols-1 sm:grid-cols-6">
    <NumberInput
      question="BP"
      field="bp"
      minimum=None
      maximum=None
      divClass="sm:col-span-3 field"
      isRequired=false
    />
    <NumberInput
      question="GRBS"
      field="grbs"
      minimum=None
      maximum=None
      divClass="sm:col-span-3 field"
      isRequired=false
    />
    <NumberInput
      question="RR"
      field="rr"
      minimum=None
      maximum=None
      divClass="sm:col-span-3 field"
      isRequired=false
    />
    <NumberInput
      question="Pulse"
      field="pulse"
      minimum=None
      maximum=None
      divClass="sm:col-span-3 field"
      isRequired=false
    />
    <TextInput
      question="Personal hygiene"
      field="personal_hygiene"
      form_id="patientvitals-form"
      divClass="sm:col-span-3 field"
      isRequired=false
      defaultValue=""
    />
    <TextInput
      question="Mouth hygiene"
      field="mouth_hygiene"
      form_id="patientvitals-form"
      divClass="sm:col-span-3 field"
      isRequired=false
      defaultValue=""
    />
    <TextInput
      question="Pubic hygiene"
      field="pubic_hygiene"
      form_id="patientvitals-form"
      divClass="sm:col-span-3 field"
      isRequired=false
      defaultValue=""
    />
    <div className="sm:col-span-3 field">
      <label
        className="block text-sm font-medium
        text-gray-700">
        {s("Systematic examination")}
      </label>
      <div className="mt-1">
        <select
          name="systemic_examination"
          required=true
          className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
          {systematic_examination_options
          ->Js.Array2.map(op => <option key=op value=op selected={true}> {s(op)} </option>)
          ->React.array}
        </select>
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label className="block text-sm font-medium text-gray-700">
        {s("Systematic examination details")}
      </label>
      <div className="mt-1">
        <textarea
          type_="text"
          name="systemic_examination_details"
          cols=50
          rows=1
          id="patientvitals-form"
          required=true
          className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24"
        />
      </div>
    </div>
    <div className="sm:col-span-3 field">
      <label className="block text-sm font-medium text-gray-700">
        {s("Visit done by(Doctor/Nurse/Volunteer/ASHA/Driver):")}
      </label>
      <div className="mt-1">
        <textarea
          type_="text"
          name="done_by"
          cols=50
          rows=1
          id="patientvitals-form"
          required=true
          className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-24">
          {s(`${name}(${role})`)}
        </textarea>
      </div>
    </div>
  </div>
}
