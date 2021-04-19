let s = React.string

open PatientTreatment__Types

let updateTreatmentsCB = json => {
  Notification.success("Saved Changes", "The treatments for the current patient has been updated.")
}

let getTreatmentsCB = (setTreatments, json) => {
  let treatments =
    json
    ->Js.Json.decodeArray
    ->Belt.Option.getWithDefault([Js.Json.null])
    ->Belt.Array.map(item => item->Treatment.decode)

  setTreatments(_ => treatments)
}

let errorCB = () => Js.log("Something went wrong")

let saveChanges = state => {
  let authenticityToken = AuthenticityToken.fromHead()
  let patient_id = "a7142391-bffd-4296-910d-7e362347fa36"
  let url = "/treatment"

  let treatments = state->Js.Json.stringifyAny->Belt.Option.getWithDefault("")

  let payload = Js.Dict.empty()
  payload->Js.Dict.set("authenticity_token", authenticityToken |> Js.Json.string)
  payload->Js.Dict.set("patient_id", Js.Json.string(patient_id))
  payload->Js.Dict.set("treatment", treatments->Js.Json.string)

  Api.create(url, payload, updateTreatmentsCB, errorCB)
}

@react.component
let make = () => {
  let (treatments, setTreatments) = React.useState(() => [])

  React.useEffect0(() => {
    let patient_id = "a7142391-bffd-4296-910d-7e362347fa36"
    let url = "/patients/" ++ patient_id ++ "/treatment/details"
    Api.get(~url, ~responseCB=getTreatmentsCB(setTreatments), ~notify=true, ~errorCB)

    None
  })

  let optionClickHandler = (~id, ~name, ~category) => {
    setTreatments(state => {
      let item = Treatment.make(
        ~id,
        ~name,
        ~category,
        ~created_at=Js.Date.now()->Js.Date.fromFloat->Js.Date.toDateString->Js.Date.fromString,
        ~deleted_at=None,
      )

      let treatmentElement = state->Js.Array2.find(i => i.id == item.id)
      if treatmentElement->Belt.Option.isNone {
        Belt.Array.concat([item], state)
      } else {
        state
      }
    })
  }

  let removeClickHandler = id => {
    setTreatments(treatments =>
      treatments->Belt.Array.map(treatment => {
        if treatment.id == id {
          treatment->Treatment.updateDeletedAt(
            Some(Js.Date.now()->Js.Date.fromFloat->Js.Date.toDateString->Js.Date.fromString),
          )
        } else {
          treatment
        }
      })
    )
  }

  let activeTreatments =
    treatments->Js.Array2.filter(treatment => treatment->Treatment.deleted_at == None)

  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-3xl mx-auto mb-20">
      <PatientTreatment__MultiSelectDropdown
        id="treatment-dropdown"
        className="p-4"
        label="Add new treatment"
        placeholder="Search"
        api="/treatment"
        optionClickHandler
      />
    </div>
    <h3 className="text-2xl leading-6 font-medium text-gray-900 p-4 mb-8">
      {s("All Treatments")}
    </h3>
    <div className="bg-gray-100 py-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <PatientTreatment__AllTreatments activeTreatments removeClickHandler />
      </div>
    </div>
    <div className="my-8 flex justify-end">
      <button
        type_="button"
        className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        onClick={_ => saveChanges(treatments)}>
        {s("Save Changes")}
      </button>
    </div>
    <h3 className="text-2xl leading-6 font-medium text-gray-900 p-4 mb-8">
      {s("Treatment History")}
    </h3>
    <div className="bg-gray-100 py-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <PatientTreatment__AllTreatmentHistories treatments />
      </div>
    </div>
  </div>
}
