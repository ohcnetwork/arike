let s = React.string
@module("nanoid") @val external nanoid: unit => string = "nanoid"
@send external focus: Dom.element => unit = "focus"

// to store the suggestions and their key(nanoid) together
module Record = {
  type t = {
    id: string,
    word: string,
  }

  let make = word => {
    id: nanoid(),
    word: word,
  }
  let id = t => t.id
  let word = t => t.word
}

@react.component
let make = (
  ~getFilteredArray: string => array<string>,
  ~placeholder="Start searching",
  ~value="",
) => {
  let (inputValue, setInputValue) = React.useState(() => value)
  let (renderSuggestions, setRenderSuggestions) = React.useState(() => false)

  // click a suggestion
  let handleListClick = word => {
    setInputValue(_ => word->Record.word)
    setRenderSuggestions(_ => false)
  }

  // press enter on a suggestion
  let handleListEnterPressed = (event, word) => {
    if event->ReactEvent.Keyboard.key == "Enter" {
      setInputValue(_ => word->Record.word)
      setRenderSuggestions(_ => false)
    }
  }

  let handleInputValueChange = event => {
    let value = ReactEvent.Form.target(event)["value"]
    setInputValue(_ => {
      let len = value->Js.String2.length
      if len > 1 {
        setRenderSuggestions(_ => true)
      } else {
        setRenderSuggestions(_ => false)
      }
      value
    })
  }

  let getSuggestions = input => {
    // getFilteredArray takes the input string and returns a suggestion array(array<string>)
    let sg = getFilteredArray(input)->Belt.Array.map(w => Record.make(w))

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
              id={word->Record.word}
              tabIndex=0
              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 focus:bg-gray-100 hover:text-gray-900"
              role="menuitem"
              onClick={_ => handleListClick(word)}
              onKeyDown={event => handleListEnterPressed(event, word)}>
              {word->Record.word->s}
            </li>
          )
          ->React.array}
        </ul>
      </div>
    }
  }

  // component starts
  <div className="p-8 flex items-center justify-center bg-white">
    <div className="w-full max-w-xs mx-auto">
      <div className="relative">
        <label htmlFor="email" className="block text-sm font-medium text-gray-700">
          {s("Disease")}
        </label>
        <div className="mt-1">
          <input
            tabIndex=0
            autoComplete="off"
            type_="search"
            name="diseases"
            id="diseases"
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            placeholder
            ariaDescribedby="disease-description"
            value=inputValue
            onChange={event => handleInputValueChange(event)}
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
