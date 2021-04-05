type state = {
  diseases: array<DiseaseHistoryForm.PatientDisease.t>,
  list_of_diseases: array<array<string>>,
}
open Belt
open Webapi.Dom

@scope("JSON") @val
external parseJson: string => state = "parse"

let getData = dataId => {
  let newElem = Document.createElement("div", document)
  let elem =
    Document.getElementById(dataId, document)->Belt.Option.getWithDefault(newElem)

  elem->Element.innerText->DomUtils.replaceAll("&quot;", "\"")->parseJson
}
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
        [DiseaseHistoryForm.PatientDisease.make(~id=Belt.Int.toString(count.contents))],
      ),
    }
  | RemoveDisease(disease) => {
      ...state,
      diseases: Js.Array.filter(m => m != disease, state.diseases),
    }
  }

@react.component
let make = (~dataId) => {
  let initialState = getData(dataId)
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let len = Js.Array.length(initialState.diseases)

  if len > 0 {
    count := count.contents + len - 1
  } else {
    count := count.contents
  }

  let new_props = DiseaseHistoryForm.PatientDisease.make(~id="0")

  <div className="max-w-3xl mx-auto mt-8 relative">
    {Js.Array.length(state.diseases) > 0
      ? state.diseases
        ->Belt.Array.mapWithIndex((i, props) => {
          <DiseaseHistoryForm
            props
            list={state.list_of_diseases}
            key={i->Belt.Int.toString}
            onClick={_mouseEvt => RemoveDisease(props)->dispatch}
          />
        })
        ->React.array
      : <DiseaseHistoryForm
          props=new_props
          list={state.list_of_diseases}
          key={"0"}
          onClick={_mouseEvt => RemoveDisease(new_props)->dispatch}
        />}
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
