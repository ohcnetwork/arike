let s = React.string

@react.component
let make = (~question, ~field, ~minimum, ~maximum, ~divClass) => {
  let min_value = minimum->Belt.Option.map(limit => Belt.Int.toString(limit))
  let min_value = switch min_value {
  | Some(min_value) => min_value
  | None => ""
  }
  let max_value = maximum->Belt.Option.map(limit => Belt.Int.toString(limit))
  let max_value = switch max_value {
  | Some(max_value) => max_value
  | None => ""
  }

  <div className=divClass>
    <label className="block text-sm font-medium text-gray-700"> {s(question)} </label>
    <div className="mt-1">
      <input
        type_="number"
        min=min_value
        max=max_value
        name=field
        className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
      />
    </div>
  </div>
}
