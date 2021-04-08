let s = React.string

module MultiSelectDropdown = Treatment__MultiSelectDropdown

type treatment = {
  id: string,
  name: string,
}

let treatmentOptions: array<MultiSelectDropdown.option> = [
  {id: "1", name: "Mouth care"},
  {id: "2", name: "Bath"},
  {id: "3", name: "Nail cutting"},
  {id: "4", name: "Shaving"},
  {id: "5", name: "Condom catheterization & training"},
  {id: "6", name: "Nelcath catheterization & training"},
  {id: "7", name: "Foley's catheterization"},
  {id: "8", name: "Foley's catheter care"},
  {id: "9", name: "Suprapubic catheterization"},
  {id: "10", name: "Suprapubic catheter care"},
  {id: "11", name: "Perennial care"},
  {id: "12", name: "Bladder wash with normal saline"},
  {id: "13", name: "Bladder wash with soda bicarbonate"},
  {id: "14", name: "Enema"},
  {id: "15", name: "High enema"},
  {id: "16", name: "Suppository"},
  {id: "17", name: "Digital evacuation"},
  {id: "18", name: "Ryles tube insertion"},
  {id: "19", name: "Ryles tube care"},
  {id: "20", name: "Ryles tube feeding & training"},
  {id: "21", name: "PEG care"},
  {id: "22", name: "Wound care"},
  {id: "23", name: "Wound care training to family"},
  {id: "24", name: "Suture removal"},
  {id: "25", name: "Vacuum dressing"},
  {id: "26", name: "Tracheostomy care"},
  {id: "27", name: "Colostomy care"},
  {id: "28", name: "Colostomy irrigation care"},
  {id: "29", name: "ileostomy care"},
  {id: "30", name: "Urostomy care"},
  {id: "31", name: "Upper limb lymphedema bandaging"},
  {id: "32", name: "Lower limb lymphedema bandaging"},
  {id: "33", name: "Upper limb lymphedema hosiery"},
  {id: "34", name: "IV fluid infusion"},
  {id: "35", name: "IV medicine bolus administration"},
  {id: "36", name: "IV cannula care"},
  {id: "37", name: "S/C fluid infusion (subcutaneous)"},
  {id: "38", name: "S/C medicine bolus administration"},
  {id: "39", name: "S/C cannula care"},
  {id: "40", name: "Ascites tapping"},
  {id: "41", name: "Ascitic catheter care"},
]

let initialTreatments = []

module TreatmentDiv = {
  @react.component
  let make = (~id, ~name, ~onClick) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex justify-between p-6 space-x-6">
        <div className="flex-1 truncate">
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-lg font-semibold truncate"> {s(name)} </h3>
          </div>
          <p className="mt-1 text-gray-500 text-sm truncate"> {s("Some description")} </p>
        </div>
        <div className="text-sm align-top"> {s("April 7th, 2021")} </div>
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

let decode = json => {
  open Json.Decode
  let item = {
    id: field("id", string, json),
    name: field("name", string, json),
  }
  item
}

@react.component
let make = () => {
  let initialOptions: array<MultiSelectDropdown.option> = [{id: "sdd", name: "asslkfj"}]

  let (treatments, setTreatments) = React.useState(() => initialTreatments)
  let (options, setOptions) = React.useState(() => initialOptions)

  React.useEffect0(() => {
    open Js.Promise
    Fetch.fetch("/treatment")
    |> then_(Fetch.Response.json)
    |> then_(json => Js.Json.decodeArray(json) |> resolve)
    |> then_(opt => opt->Belt.Option.getWithDefault([Js.Json.null]) |> resolve)
    |> then_(items => {
      let items = items->Belt.Array.map(item => item->decode)
      setTreatments(_ => items)
      items->resolve
    })
    |> ignore
    None
  })

  let handleClick = (id, name) => {
    setTreatments(state => {
      let item = {
        id: id,
        name: name,
      }

      let treatmentElement = state->Js.Array2.find(i => i.id == item.id)
      if treatmentElement->Belt.Option.isNone {
        Belt.Array.concat(state, [item])
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
        id="care-catheterisation"
        className="p-4"
        name="care-given"
        label="Add new treatment"
        options
        onClick=handleClick
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
              <TreatmentDiv
                key=treatment.id id=treatment.id name=treatment.name onClick=removeItem
              />
            )
            ->React.array
          }}
        </ul>
      </div>
    </div>
  </div>
}

/*
Adding CSRF Tokens
document.getElementsByName('csrf-token')[0].content
*/
