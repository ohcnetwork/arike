let s = React.string

open PatientTreatment__Types

let saveChanges = state => {
  let treatments = state->Js.Json.stringifyAny->Belt.Option.getWithDefault("")

  let csrfMetaTag = ReactDOM.querySelector("meta[name=csrf-token]")->Belt.Option.getUnsafe
  let csrfToken = Webapi.Dom.Element.getAttribute("content", csrfMetaTag)->Belt.Option.getUnsafe

  let requestBody = Js.Dict.empty()
  requestBody->Js.Dict.set("patient_id", Js.Json.string("a7142391-bffd-4296-910d-7e362347fa36"))
  requestBody->Js.Dict.set("treatment", treatments->Js.Json.string)

  open Js.Promise
  Fetch.fetchWithInit(
    "/treatment",
    Fetch.RequestInit.make(
      ~method_=Post,
      ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(requestBody))),
      ~headers=Fetch.HeadersInit.make({
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      }),
      (),
    ),
  )
  |> then_(Fetch.Response.text)
  |> then_(text => text->Js.log |> resolve)
  |> ignore
}

@react.component
let make = () => {
  let (treatments, setTreatments) = React.useState(() => [])

  React.useEffect0(() => {
    // Fetch the data([{id: string, name: string}])
    open Js.Promise
    Fetch.fetch("/patients/a7142391-bffd-4296-910d-7e362347fa36/treatment/details")
    |> then_(Fetch.Response.json)
    |> then_(json => Js.Json.decodeArray(json) |> resolve)
    |> then_(opt => opt->Belt.Option.getWithDefault([Js.Json.null]) |> resolve)
    |> then_(items => {
      let items = items->Belt.Array.map(item => item->Treatment.decode)
      setTreatments(_ => items)
      items |> resolve
    })
    |> ignore

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
