let s = React.string
@module("nanoid") @val external nanoid: unit => string = "nanoid"

// to store the suggestions and their key(nanoid) together
module Record = {
  type t = {
    id: string,
    name: string,
  }

  let make = (id, word) => {
    id: id,
    name: word,
  }
  let id = t => t.id
  let name = t => t.name
}

@react.component
let make = (~id, ~api, ~name, ~label="Enter", ~placeholder="Start searching", ~value="") => {
  let (inputValue, setInputValue) = React.useState(() => value)
  let (renderSuggestions, setRenderSuggestions) = React.useState(() => false)
  let (sg, setSg) = React.useState(() => [])

  // line 45
  let createSuggestionArrayReducer = (acc, current) => {
    let idNameArray =
      current->Js.Json.decodeObject->Belt.Option.getWithDefault(Js.Dict.empty())->Js.Dict.entries
    // get the id and the name in type Js.Json.t
    let (_, idValue) = idNameArray[2]
    let (_, nameValue) = idNameArray[3]

    // convert id and name to type string
    let idValue = idValue->Js.Json.decodeString->Belt.Option.getWithDefault("")
    let nameValue = nameValue->Js.Json.decodeString->Belt.Option.getWithDefault("")
    if idValue != "" && nameValue != "" {
      acc->Belt.Array.concat([Record.make(idValue, nameValue)])
    } else {
      acc
    }
  }

  React.useEffect0(() => {
    open Js.Promise
    // Fetch the data({id: string, name:string}) from the given api
    Fetch.fetch(api)
    |> then_(Fetch.Response.json)
    |> then_(json => Js.Json.decodeArray(json) |> resolve)
    |> then_(opt => Belt.Option.getExn(opt) |> resolve)
    |> then_(items => {
      // convert the array<Js.Json.t> into array<Record.t>
      let suggestionsList = items->Belt.Array.reduce([], createSuggestionArrayReducer)
      setSg(_ => suggestionsList)->resolve
    })
    |> then_(opt => opt->resolve)
    |> resolve
    |> ignore

    None
  })

  // click a suggestion
  let handleListClick = word => {
    setInputValue(_ => word->Record.name)
    setRenderSuggestions(_ => false)
  }

  // press enter on a suggestion
  let handleListEnterPressed = (event, word) => {
    if event->ReactEvent.Keyboard.key == "Enter" {
      setInputValue(_ => word->Record.name)
      setRenderSuggestions(_ => false)
    }
  }

  let handleInputValueChange = event => {
    let value = ReactEvent.Form.target(event)["value"]
    setInputValue(_ => value)
  }

  // filter the original array to create suggestions array
  let getFilteredArray = input => {
    if input == "" {
      sg
    } else {
      let newSg = sg->Js.Array2.filter(info => info.name->Js.String2.includes(input))
      newSg
    }
  }

  let getSuggestions = input => {
    // getFilteredArray takes the input string and returns a suggestion array(array<string>)
    let sg = getFilteredArray(input)->Belt.Array.map(w => Record.make(w.id, w.name))

    // if there is no suggestions
    if sg->Belt.Array.length < 1 {
      <div
        className="w-full absolute rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none text-sm text-center py-2">
        {"No Matches Found"->s}
      </div>
    } else {
      // return the dropdown of suggestions
      <div
        className="z-10 w-full max-h-32 overflow-y-scroll absolute rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5"
        role="menu"
        ariaLabelledby="options-menu">
        <ul className="py-1" role="menu" ariaLabel="menu">
          {sg
          ->Belt.Array.map(word =>
            <li
              key={word->Record.id}
              id={word->Record.name}
              tabIndex=0
              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 focus:bg-gray-100 hover:text-gray-900"
              role="menuitem"
              onClick={_ => handleListClick(word)}
              onKeyDown={event => handleListEnterPressed(event, word)}>
              {word->Record.name->s}
            </li>
          )
          ->React.array}
        </ul>
      </div>
    }
  }

  // component starts
  <div className="bg-white">
    <div className="w-full">
      <div className="relative">
        <label htmlFor="email" className="block text-sm font-medium text-gray-700">
          {s(label)}
        </label>
        <div className="mt-1">
          <input
            tabIndex=0
            autoComplete="off"
            type_="search"
            name
            id
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            placeholder
            ariaDescribedby="disease-description"
            value=inputValue
            onChange={event => handleInputValueChange(event)}
            onClick={_ => setRenderSuggestions(_ => !renderSuggestions)}
          />
        </div>
        {if renderSuggestions == true {
          getSuggestions(inputValue)
        } else {
          <> </>
        }}
      </div>
    </div>
  </div>
}
