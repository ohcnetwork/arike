let s = React.string

open PatientTreatment__Types

type state = {
  patientId: string,
  allTreatments: array<DropdownOption.t>,
  activeTreatments: array<Treatment.t>,
  selectedTreatments: array<SelectedTreatment.t>,
}

type props = state

type action =
  | SetAllTreatments(array<DropdownOption.t>)
  | SetActiveTreatments(array<Treatment.t>)
  | AddTreatment(DropdownOption.t)
  | RemoveSelectedTreatment(SelectedTreatment.t)

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
      selectedTreatments: Js.Array2.concat(
        state.selectedTreatments,
        [
          SelectedTreatment.make(
            ~id=treatment->DropdownOption.id,
            ~name=treatment->DropdownOption.name,
            ~category=treatment->DropdownOption.category,
            ~description=None,
          ),
        ],
      ),
    }
  | RemoveSelectedTreatment(treatment) => {
      ...state,
      allTreatments: Js.Array2.concat(
        state.allTreatments,
        [
          DropdownOption.make(
            ~id=treatment->SelectedTreatment.id,
            ~name=treatment->SelectedTreatment.name,
            ~category=treatment->SelectedTreatment.category,
          ),
        ],
      ),
      selectedTreatments: state.selectedTreatments->Js.Array2.filter(x => x.id !== treatment.id),
    }
  }

@react.component
let make = (~props) => {
  let (state, dispatch) = React.useReducer(reducer, props)

  let optionClickHandler = (option: DropdownOption.t) => {
    let isSelected = state.selectedTreatments->Js.Array2.find(i => i.id === option.id)
    if isSelected->Belt.Option.isNone {
      dispatch(AddTreatment(option))
    }
  }
  let disableButton = state.selectedTreatments->Js.Array2.length === 0

  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <form action={`/patients/${state.patientId}/treatment/`} method="POST">
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
          disabled={disableButton}
          className={`inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600  disabled:opacity-40 ${disableButton
              ? "cursor-default"
              : "hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"}`}>
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
