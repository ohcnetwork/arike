type state = {
  diseases: array<DiseaseHistoryForm.PatientDisease.t>,
  list_of_diseases: array<array<option<string>>>,
}
type props = state

let s = React.string

let count = ref(1)

type action =
  | AddDisease
  | RemoveDisease(DiseaseHistoryForm.PatientDisease.t)

let reducer = (state, action) =>
  switch action {
  | AddDisease => {
      ...state,
      diseases: Belt.Array.concat(
        state.diseases,
        [DiseaseHistoryForm.PatientDisease.make(~id=Some(Belt.Int.toString(count.contents)))],
      ),
    }
  | RemoveDisease(disease) => {
      ...state,
      diseases: Js.Array.filter(m => m != disease, state.diseases),
    }
  }

@react.component
let make = (~props) => {
  let (state, dispatch) = React.useReducer(reducer, props)
  let len = Js.Array.length(state.diseases)
  if len === 0 {
    count := count.contents + 1
    AddDisease->dispatch
  }

  <div className="max-w-3xl mx-auto mt-8 relative">
    {state.diseases
    ->Belt.Array.map(props => {
      <DiseaseHistoryForm
        props
        list={state.list_of_diseases}
        key={Js.Option.getWithDefault("", props->DiseaseHistoryForm.PatientDisease.getId)}
        onClick={_mouseEvt => RemoveDisease(props)->dispatch}
      />
    })
    ->React.array}
    <div className="flex">
      <button
        className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        onClick={mouseEvt => {
          count := count.contents + 1
          mouseEvt->ReactEvent.Mouse.preventDefault
          AddDisease->dispatch
        }}>
        {s("Add Disease")}
      </button>
      {if count.contents > 0 {
        <button
          type_="submit"
          className="ml-4 mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
          {s("Save")}
        </button>
      } else {
        React.null
      }}
    </div>
  </div>
}
