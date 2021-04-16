let s = React.string

@react.component
let make = (~question, ~field, ~form_id, ~divClass, ~isRequired, ~defaultValue) => {
  <div className=divClass>
    <label className="block text-sm font-medium text-gray-700"> {s(question)} </label>
    <div className="mt-1">
      <textarea
        type_="text"
        name=field
        cols=50
        rows=1
        id=form_id
        required=isRequired
        className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-16">
        {s(defaultValue)}
      </textarea>
    </div>
  </div>
}

module EnabledTextInput = {
  @react.component
  let make = (~question, ~field, ~form_id, ~divClass, ~isRequired, ~defaultValue, ~isEnabled) => {
    <div className=divClass>
      <label className="block text-sm font-medium text-gray-700"> {s(question)} </label>
      <div className="mt-1">
        <textarea
          type_="text"
          name=field
          cols=50
          rows=1
          id=form_id
          required=isRequired
          disabled={!isEnabled}
          className="shadow-sm
          focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-16">
          {s(defaultValue)}
        </textarea>
      </div>
    </div>
  }
}
