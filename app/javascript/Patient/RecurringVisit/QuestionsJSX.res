let s = React.string

let numberInput = (question, field, minimum, maximum) => {
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

  <div className="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start  sm:pt-5">
    <label className="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">
      {s(question)}
    </label>
    <div className="mt-1 sm:mt-0 sm:col-span-2">
      <input
        type_="number"
        min=min_value
        max=max_value
        name=field
        className="max-w-lg block w-full shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
      />
    </div>
  </div>
}

let textInput = (question, field, form_id) => {
  <div className="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start  sm:pt-5">
    <label className="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">
      {s(question)}
    </label>
    <div className="mt-1 sm:mt-0 sm:col-span-2">
      <textarea
        type_="text"
        name=field
        cols=50
        rows=4
        id=form_id
        className="max-w-lg block w-full shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
      />
    </div>
  </div>
}

let dropdownInput = (question, field, options) => {
  let optionsTags = options->Belt.Array.map(op => <option value=op> {s(op)} </option>)->React.array

  <div className="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start  sm:pt-5">
    <label className="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">
      {s(question)}
    </label>
    <div className="mt-1 sm:mt-0 sm:col-span-2">
      <select
        name=field
        className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
        {optionsTags}
      </select>
    </div>
  </div>
}

let radioInput = (question, field, options) => {
  let radioTags =
    options
    ->Belt.Array.map(op => {
      <div className="flex items-center">
        <input
          name=field
          type_="radio"
          className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300"
        />
        <label className="ml-3 block text-sm font-medium text-gray-700"> {s(op)} </label>
      </div>
    })
    ->React.array

  <div className="pt-6 sm:pt-5">
    <div>
      <div className="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-baseline">
        <div>
          <div className="text-base font-medium text-gray-900 sm:text-sm sm:text-gray-700">
            {s(question)}
          </div>
        </div>
        <div className="sm:col-span-2">
          <div className="max-w-lg"> <div className="mt-4 space-y-4"> {radioTags} </div> </div>
        </div>
      </div>
    </div>
  </div>
}
