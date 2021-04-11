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
  let make = (~id, ~name, ~onClick) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex justify-between p-6 space-x-6">
        <div className="flex-1">
          <div className="text-sm align-top"> {s("April 7th, 2021")} </div>
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-lg font-semibold"> {s(name)} </h3>
          </div>
        </div>
      </div>
      <div>
        <div className="-mt-px flex divide-x divide-gray-200">
          <div className="w-0 flex-1 flex">
            <button
              onClick={_ => onClick(id)}
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

  let makeRequest = %raw(`
    async function(treatments, csrfToken) {
      const response = await fetch(
      "/treatment",
      {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify({
          id: "a7142391-bffd-4296-910d-7e362347fa36",
          treatment: treatments
        }),
      })

      const content = await response;
    }
  `)

  makeRequest(treatments, csrfToken)
}

let initialTreatments = []

@react.component
let make = () => {
  let (treatments, setTreatments) = React.useState(() => initialTreatments)

  let handleClick = (id, name) => {
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
  let removeItem = id => {
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
        optionClickHandler=handleClick
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
              <TreatmentCard
                key=treatment.id id=treatment.id name=treatment.name onClick=removeItem
              />
            )
            ->React.array
          }}
        </ul>
      </div>
    </div>
    <button onClick={e => saveChanges(treatments)}> {s("Save Changes")} </button>
  </div>
}

/*
Adding CSRF Tokens
document.getElementsByName('csrf-token')[0].content
*/
