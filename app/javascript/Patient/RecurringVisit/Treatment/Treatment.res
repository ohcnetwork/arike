let s = React.string

module MultiSelectDropdown = Treatment__MultiSelectDropdown

type option = MultiSelectDropdown.option

type treatment = {
  id: string,
  name: string,
}

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

let parseTreatment = (treatment, removeTreatmentHandler) => {
  <TreatmentDiv
    key=treatment.id id=treatment.id name=treatment.name onClick=removeTreatmentHandler
  />
}

@react.component
let make = () => {
  let options: array<MultiSelectDropdown.option> = [
    {id: "1", name: "bed sore"},
    {id: "2", name: "wound"},
    {id: "3", name: "catheterisation"},
    {id: "4", name: "Enema"},
    {id: "5", name: "Lymphedema "},
    {
      id: "6",
      name: "IV fluid infusion",
    },
  ]

  let initialTreatments = []

  let (treatments, setTreatments) = React.useState(() => initialTreatments)

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
            ->Belt.Array.map(treatment => parseTreatment(treatment, removeItem))
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
