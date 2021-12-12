@val external window: {..} = "window"

let s = React.string

let reverseDateString = (str) => {
    str->Js.String2.split("-")->Js.Array2.reverseInPlace->Js.Array2.joinWith("-")
}

@react.component
let make = () => {
    let (date, setDate) = React.useState(_ => "")
    let (note, setNote) = React.useState(_ => "")

    let onDateChange = event => {
        let value = ReactEvent.Synthetic.currentTarget(event)["value"]
        setDate(_ => value)
    }

    let scrollTo = _ => {
        let target = window["document"]["getElementById"](`agenda-${date}`)
        
        if (target == Js.Nullable.null) {
            setNote(_ => `No patients scheduled on ${date->reverseDateString}`)
        } else {
            setNote(_ => "")
            Webapi.Dom.HtmlElement.scrollIntoViewWithOptions({"behavior": "smooth", "block": "center"}, target)
        } 
    }


    <div>
        <div className="sticky top-16 md:top-2 bg-gray-50 rounded-md px-2 z-50 flex align-center justify-end">
          <input id="agenda-goto-date" type_="date" onChange={onDateChange} className="rounded-md my-2 mx-2" />
          <button
              onClick={scrollTo}
              className="items-center px-2 py-2 my-2 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none">
              {s("Goto")}
          </button>
        </div>
        <p className="text-right text-yellow-500">{s(note)}</p>
    </div>
}