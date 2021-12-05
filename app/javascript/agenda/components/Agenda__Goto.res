@val external window: {..} = "window"

let s = React.string

@react.component
let make = () => {
    let (date, setDate) = React.useState(_ => "")

    let onDateChange = event => {
        let value = ReactEvent.Synthetic.currentTarget(event)["value"]
        setDate(_ => value)
    }

    let scrollTo = _ => {
        let target = window["document"]["getElementById"](`agenda-${date}`)
        
        if (target != Js.Nullable.null) {
            Webapi.Dom.HtmlElement.scrollIntoViewWithOptions({"behavior": "smooth", "block": "center"}, target)
        } 
    }


    <div className="mt-10 flex align-center justify-end">
        <input id="agenda-goto-date" type_="date" onChange={onDateChange} className="rounded-md my-2 mx-2 mb-4" />
        <button
            onClick={scrollTo}
            className="items-center px-2 py-2 mb-4 mt-2 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none">
            {s("Goto")}
        </button>
    </div>
}