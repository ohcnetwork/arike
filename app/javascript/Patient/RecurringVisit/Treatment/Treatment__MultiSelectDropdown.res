let s = React.string

type option = {
  id: string,
  name: string,
}

let onWindowClick = (showDropdown, setShowDropdown, _event) =>
  if showDropdown {
    setShowDropdown(_ => false)
  } else {
    ()
  }

let search = (searchString, options) => {
  (options |> Js.Array.filter(option =>
    option.name
    |> String.lowercase_ascii
    |> Js.String.includes(searchString |> String.lowercase_ascii)
  ))->Belt.SortArray.stableSortBy((x, y) => String.compare(x.name, y.name))
}

module DropDown = {
  @react.component
  let make = (~options, ~show, ~onClick) => {
    let options =
      options->Belt.Array.map(option =>
        <button
          key=option.id
          className="-m-3 p-3 block rounded-md hover:bg-gray-50 transition ease-in-out duration-150"
          onClick={e => onClick(option.id, option.name)}>
          <p className="text-base font-medium text-gray-900"> {s(option.name)} </p>
        </button>
      )

    if show {
      <div
        className="absolute z-10 left-1/2 transform -translate-x-1/2 mt-3 px-2 w-full sm:px-0 max-h-80 overflow-auto">
        <div className="rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 overflow-hidden">
          <div className="relative grid gap-6 bg-white px-5 py-6 sm:gap-8 sm:p-8">
            {options->React.array}
          </div>
        </div>
      </div>
    } else {
      <div />
    }
  }
}

@react.component
let make = (~id, ~className, ~name, ~options, ~label, ~onClick) => {
  let (showDropdown, setShowDropdown) = React.useState(() => false)
  let (results, setResults) = React.useState(() => options)

  React.useEffect1(() => {
    let curriedFunction = onWindowClick(showDropdown, setShowDropdown)

    let removeEventListener = () =>
      Webapi.Dom.Window.removeEventListener("click", curriedFunction, Webapi.Dom.window)

    if showDropdown {
      Webapi.Dom.Window.addEventListener("click", curriedFunction, Webapi.Dom.window)
      Some(removeEventListener)
    } else {
      removeEventListener()
      None
    }
  }, [showDropdown])

  <div className id>
    <label className="block text-lg font-medium text-gray-700"> {s(label)} </label>
    <div className="relative mt-1 w-full">
      <input
        type_="text"
        onClick={_ => setShowDropdown(_ => true)}
        onChange={e => {
          let value = ReactEvent.Form.target(e)["value"]
          setResults(_ => search(value, options))
        }}
        name
        className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md "
      />
      <DropDown options=results show=showDropdown onClick />
    </div>
  </div>
}
