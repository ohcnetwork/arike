let s = React.string
@val external alert: string => unit = "alert"
@module("nanoid") @val external nanoid: unit => string = "nanoid"
@send external focus: Dom.element => unit = "focus"

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
let make = (~getFilteredArray: string => array<string>) => {
  let (inputValue, setInputValue) = React.useState(() => "")
  let (renderSuggestions, setRenderSuggestions) = React.useState(() => false)

  let getSuggestions = input => {
    let sg = getFilteredArray(input)->Belt.Array.map(w => Record.make(w))

    <div
      className="w-full absolute rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none"
      role="menu"
      ariaLabelledby="options-menu">
      <div className="py-1" role="none" ariaExpanded={true}>
        {sg
        ->Belt.Array.map(word =>
          <li
            key={word->Record.id}
            tabIndex=0
            className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 focus:bg-gray-100 hover:text-gray-900"
            role="menuitem"
            onClick={_ => {
              setInputValue(_ => word->Record.word)
              setRenderSuggestions(_ => false)
            }}
            onKeyDown={event => {
              if event->ReactEvent.Keyboard.key == "Enter" {
                setInputValue(_ => word->Record.word)
                setRenderSuggestions(_ => false)
              }
            }}>
            {word->Record.word->s}
          </li>
        )
        ->React.array}
      </div>
    </div>
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
            type_="text"
            name="diseases"
            id="diseases"
            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
            placeholder="Pneumonia"
            ariaDescribedby="disease-description"
            value=inputValue
            onChange={event =>
              setInputValue(_ => {
                let value = ReactEvent.Form.target(event)["value"]
                let len = value->Js.String2.length
                if len > 1 {
                  setRenderSuggestions(_ => true)
                } else {
                  setRenderSuggestions(_ => false)
                }
                ReactEvent.Form.target(event)["value"]
              })}
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
