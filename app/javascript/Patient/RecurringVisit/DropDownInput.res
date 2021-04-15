let s = React.string

@react.component @react.component
let make = (~question, ~field, ~options, ~isRequired) => {
  let isDisabled = op => op == "Not selected" && isRequired ? true : false
  let optionsTags =
    options
    ->Belt.Array.map(op =>
      <option key=op value=op disabled={op->isDisabled} selected={op->isDisabled}> {s(op)} </option>
    )
    ->React.array
  <div className="sm:col-span-3 col-span-4 field my-8">
    <label
      className="block text-sm font-medium
        text-gray-700">
      {s(question)}
    </label>
    <div className="mt-1">
      <select
        name=field
        required=isRequired
        className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
        {optionsTags}
      </select>
    </div>
  </div>
}

module SelectedDropDown = {
  @react.component @react.component
  let make = (~question, ~field, ~options, ~isRequired, ~changeTextEnabled) => {
    let isDisabled = op => op == "Not selected" ? true : false

    let optionsTags =
      options
      ->Belt.Array.map(op =>
        <option key=op value=op disabled={op->isDisabled} selected={op->isDisabled}>
          {s(op)}
        </option>
      )
      ->React.array
    <div className="sm:col-span-3 field">
      <label
        className="block text-sm font-medium
        text-gray-700">
        {s(question)}
      </label>
      <div className="mt-1">
        <select
          name=field
          required=isRequired
          onChange={_ => changeTextEnabled(_ => true)}
          className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
          {optionsTags}
        </select>
      </div>
    </div>
  }
}
