let s = React.string

@react.component
let make = (~question, ~field, ~options, ~isRequired) => {
  let radioTags =
    options
    ->Belt.Array.map(op => {
      <div className="flex items-center it">
        <input
          name=field
          type_="radio"
          required=isRequired
          className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300"
        />
        <label className="ml-3 mr-4 block text-sm font-medium text-gray-700"> {s(op)} </label>
      </div>
    })
    ->React.array

  <div className="sm:col-span-3 field">
    <label className="block text-sm font-medium text-gray-700"> {s(question)} </label>
    <div className="sm:col-span-2"> <div className="mt-4 flex"> {radioTags} </div> </div>
  </div>
}

module YesNoRadioInput = {
  @react.component
  let make = (~question, ~field, ~options, ~isRequired, ~changeTextEnabled) => {
    let select = (op, _) =>
      op == "Yes" ? changeTextEnabled(_ => true) : changeTextEnabled(_ => false)

    let radioTags =
      options
      ->Belt.Array.map(op => {
        <div className="flex items-center it">
          <input
            name=field
            type_="radio"
            required=isRequired
            onClick={op->select}
            className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300"
          />
          <label className="ml-3 mr-4 block text-sm font-medium text-gray-700"> {s(op)} </label>
        </div>
      })
      ->React.array

    <div className="sm:col-span-3 field">
      <label className="block text-sm font-medium text-gray-700"> {s(question)} </label>
      <div className="sm:col-span-2"> <div className="mt-4 flex"> {radioTags} </div> </div>
    </div>
  }
}
