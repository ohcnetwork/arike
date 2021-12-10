@val external window: {..} = "window"

let s = React.string

@react.component
let make = (~className: string, ~href: string, ~text: string) => {
    <a 
        className={className}
        onClick={event => {
            event->ReactEvent.Mouse.stopPropagation
            window["location"]["href"] = href
        }}>
        {s(text)}
    </a>
}