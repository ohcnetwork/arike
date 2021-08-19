let s = React.string

open PatientTreatment__Types

type state = {
  patientId: string,
  allTreatments: array<DropdownOption.t>,
  activeTreatments: array<Treatment.t>,
  selectedTreatments: array<DropdownOption.t>,
}

type props = state

type treatment =
  | All
  | Active
  | Selected

type action =
  | SetAllTreatments(array<DropdownOption.t>)
  | SetActiveTreatments(array<Treatment.t>)
  | AddTreatment(DropdownOption.t)
  | RemoveSelectedTreatment(DropdownOption.t)

let reducer = (state, action) =>
  switch action {
  | SetAllTreatments(treatments) => {
      ...state,
      allTreatments: Js.Array2.concat(state.allTreatments, treatments),
    }
  | SetActiveTreatments(treatments) => {
      ...state,
      activeTreatments: Js.Array2.concat(state.activeTreatments, treatments),
    }
  | AddTreatment(treatment) => {
      ...state,
      allTreatments: state.allTreatments->Js.Array2.filter(x => x.id !== treatment.id),
      selectedTreatments: Js.Array2.concat(state.selectedTreatments, [treatment]),
    }
  | RemoveSelectedTreatment(treatment) => {
      ...state,
      allTreatments: Js.Array2.concat(state.allTreatments, [treatment]),
      selectedTreatments: state.selectedTreatments->Js.Array2.filter(x => x.id !== treatment.id),
    }
  }

let updateTreatmentsCB = json => {
  Notification.success("Saved Changes", "The treatments for the current patient has been updated.")
}

let getTreatmentsCB = (dispatch, treatment, json) => {
  let treatments = json->Js.Json.decodeArray->Belt.Option.getWithDefault([Js.Json.null])
  Js.log2(treatment, json)

  switch treatment {
  | All =>
    dispatch(SetAllTreatments(treatments->Belt.Array.map(item => item->DropdownOption.decode)))
  | Active =>
    dispatch(SetActiveTreatments(treatments->Belt.Array.map(item => item->Treatment.decode)))
  }
}

let errorCB = () => Js.log("Something went wrong")

let saveChanges = (selectedTreatments: array<DropdownOption.t>, patient_id) => {
  let authenticityToken = AuthenticityToken.fromHead()
  // let patient_id = "a7142391-bffd-4296-910d-7e362347fa36"
  let url = "/patients/" ++ patient_id ++ "/treatment/update"

  let treatments = selectedTreatments->Js.Json.stringifyAny->Belt.Option.getWithDefault("")

  let payload = Js.Dict.empty()
  payload->Js.Dict.set("authenticity_token", authenticityToken->Js.Json.string)
  payload->Js.Dict.set("patient_id", patient_id->Js.Json.string)
  payload->Js.Dict.set("treatments", "treatments"->Js.Json.string)
  Js.log(payload)

  Api.create(url, payload, updateTreatmentsCB, errorCB)
}

@react.component
let make = (~props) => {
  let (state, dispatch) = React.useReducer(reducer, props)

  let optionClickHandler = (option: DropdownOption.t) => {
    Js.log(option)
    let isSelected = state.selectedTreatments->Js.Array2.find(i => i.id === option.id)
    if isSelected->Belt.Option.isNone {
      dispatch(AddTreatment(option))
    }
  }
  Js.log(state)
  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <form action={`/patients/${state.patientId}/treatment/update`} method="POST">
      <input type_="hidden" name="authenticity_token" value={AuthenticityToken.fromHead()} />
      <div className="max-w-3xl mx-auto mb-10">
        <PatientTreatment__MultiSelectDropdown
          id="treatment-dropdown"
          className="p-4"
          label="Add new treatment"
          placeholder="Search"
          options={state.allTreatments}
          optionClickHandler
        />
      </div>
      <div className="m-2">
        <h3 className="text-2xl leading-6 font-medium text-gray-900 mb-2">
          {s("Selected Treatments")}
        </h3>
        <div className="bg-gray-100 py-8">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <PatientTreatment__SelectedTreatments
              selectedTreatments={state.selectedTreatments}
              removeClickHandler={x => dispatch(RemoveSelectedTreatment(x))}
            />
          </div>
        </div>
      </div>
      <div className="my-8 flex justify-end">
        <button
          type_="submit"
          className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          {s("Add Treatments")}
        </button>
      </div>
    </form>
    <div className="m-2">
      <h3 className="text-2xl leading-6 font-medium text-gray-900 mb-2">
        {s("Active Treatments")}
      </h3>
      <div className="my-2">
        <PatientTreatment__ActiveTreatments
          patientId={state.patientId} treatments={state.activeTreatments}
        />
      </div>
    </div>
  </div>
}
