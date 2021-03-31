let s = React.string

@react.component
let make = (~question, ~field, ~options) => {
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
