let s = React.string

module MultiSelectDropdown = Treatment__MultiSelectDropdown

type treatment = {
  id: string,
  name: string,
  created_at: Js.Date.t,
  deleted_at: option<Js.Date.t>,
}

module TreatmentCard = {
  @react.component
  let make = (~treatment, ~removeClickHandler) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex justify-between p-6 space-x-6">
        <div className="flex-1">
          <div className="text-sm align-top"> {s(treatment.created_at->Js.Date.toDateString)} </div>
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-lg font-semibold"> {s(treatment.name)} </h3>
          </div>
        </div>
      </div>
      <div>
        <div className="-mt-px flex divide-x divide-gray-200">
          <div className="w-0 flex-1 flex">
            <button
              onClick={_ => removeClickHandler(treatment.id)}
              className="relative -mr-px w-0 flex-1 inline-flex items-center justify-center py-4 text-sm text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500">
              <span className="ml-3"> {s("Remove")} </span>
            </button>
          </div>
        </div>
      </div>
    </li>
  }
}

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

let getValue = (item, index) => {
  switch item->Belt.Array.get(index) {
  | Some(value) => {
      let (_, value) = value
      value->Js.Json.decodeString->Belt.Option.getWithDefault("")
    }
  | None => ""
  }
}

let decode = json => {
  let item =
    json->Js.Json.decodeObject->Belt.Option.getWithDefault(Js.Dict.empty())->Js.Dict.entries

  let idValue = item->getValue(0)
  let nameValue = item->getValue(1)
  let createdAtValue = item->getValue(2)
  let deletedAtValue = item->getValue(3)

  {
    id: idValue,
    name: nameValue,
    created_at: Js.Date.fromString(createdAtValue),
    deleted_at: switch deletedAtValue {
    | "" => None
    | _ => Some(Js.Date.fromString(deletedAtValue))
    },
  }
}

let initialTreatments = []

@react.component
let make = () => {
  let (treatments, setTreatments) = React.useState(() => initialTreatments)

  React.useEffect0(() => {
    // Fetch the data([{id: string, name: string}]) from the provided api
    open Js.Promise
    Fetch.fetch("/patients/a7142391-bffd-4296-910d-7e362347fa36/treatment/details")
    |> then_(Fetch.Response.json)
    |> then_(json => Js.Json.decodeArray(json) |> resolve)
    |> then_(opt => opt->Belt.Option.getWithDefault([Js.Json.null]) |> resolve)
    |> then_(items => {
      let items = items->Belt.Array.map(item => item->decode)
      setTreatments(_ => items)
      items |> resolve
    })
    |> ignore

    None
  })

  let optionClickHandler = (id, name) => {
    setTreatments(state => {
      let item = {
        id: id,
        name: name,
        created_at: Js.Date.fromFloat(Js.Date.now()),
        deleted_at: None,
      }

      let treatmentElement = state->Js.Array2.find(i => i.id == item.id)
      if treatmentElement->Belt.Option.isNone {
        Belt.Array.concat([item], state)
      } else {
        state
      }
    })
  }
  let removeClickHandler = id => {
    setTreatments(state =>
      state->Js.Array2.filter(treatment => {
        treatment.id != id
      })
    )
  }

  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-3xl mx-auto mb-20">
      <MultiSelectDropdown
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
        <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {if treatments->Belt.Array.length == 0 {
            <h4> {s("No treatments added")} </h4>
          } else {
            treatments
            ->Belt.Array.map(treatment =>
              <TreatmentCard key=treatment.id treatment removeClickHandler />
            )
            ->React.array
          }}
        </ul>
      </div>
    </div>
    <div className="my-8 flex justify-end">
      <button
        type_="button"
        className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        onClick={e => saveChanges(treatments)}>
        {s("Save Changes")}
      </button>
    </div>
  </div>
}
