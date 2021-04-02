type state = {
  diseases: array<DiseaseHistoryForm.PatientDisease.t>,
}
open Belt

@scope("JSON") @val
external parseJson: string => state = "parse"

let getData = dataId => {
  let elem = Domutils.doc->Domutils.getElementById(dataId)->Belt.Option.getWithDefault(Js.Obj.empty())

  elem["innerText"]->Domutils.replaceAll("&quot;", "\"")->parseJson
}
let s = React.string

let count = ref(0)

type action =
  | AddDisease
  | RemoveDisease(DiseaseHistoryForm.PatientDisease.t)

let reducer = (state, action) =>
  switch action {
    | AddDisease => {
      diseases: Belt.Array.concat(
        state.diseases,
        [DiseaseHistoryForm.PatientDisease.make(~id=Belt.Int.toString(count.contents))],
      )
    }
    | RemoveDisease(disease) => {
      diseases: Js.Array.filter(m => m != disease, state.diseases),
    }
  }

@react.component
let make = (~dataId) => {
  let initialState = getData(dataId)
  let (state, dispatch) = React.useReducer(reducer, initialState)

  <div className="max-w-3xl mx-auto mt-8 relative">
    {state.diseases
    ->Belt.Array.mapWithIndex((i, props) => {
      <DiseaseHistoryForm
        props
        key={i->Belt.Int.toString}
        onClick={_mouseEvt => RemoveDisease(props)->dispatch}

      />
    })->React.array}
    <button
      className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      onClick={mouseEvt => {
        count := count.contents + 1
        mouseEvt->ReactEvent.Mouse.preventDefault
        AddDisease->dispatch
      }}>
      {s("Add Disease")}
    </button>
    <div />
    {if count.contents > 0 {
      <button
        type_="submit"
        className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
        {s("Save")}
      </button>
    } else {
      React.null
    }
    }
  </div>
}
