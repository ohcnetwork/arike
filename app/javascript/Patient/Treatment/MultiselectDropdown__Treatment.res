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
  let make = (~options, ~show, ~id) => {
    let options =
      options->Belt.Array.map(option =>
        <button
          key=option.id
          className="flex text-xs px-4 py-1 items-center w-full hover:bg-gray-200 focus:outline-none focus:bg-gray-200"
          onClick={e => Js.log(ReactDOM.querySelector(`#${id}-question`))}>
          {s(option.name)}
        </button>
      )
    if show {
      <div className=" w-full border border-gray-400 bg-white mt-1 rounded-lg shadow-lg py-2 z-50">
        {React.array(options)}
      </div>
    } else {
      <div className="hidden" />
    }
  }
}

@react.component
let make = (~id, ~className, ~name, ~options, ~label) => {
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
    <label className="block text-sm font-medium text-gray-700"> {s(label)} </label>
    <div className="mt-1 w-full">
      <input
        type_="text"
        onClick={_ => setShowDropdown(s => !s)}
        onChange={e => {
          let value = ReactEvent.Form.target(e)["value"]
          // Js.log(value)
          setResults(_ => search(value, options))
        }}
        name
        className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md "
      />
      <DropDown options=results show=showDropdown id />
    </div>
    <div className="" id={id ++ "-question"} />
  </div>
}
