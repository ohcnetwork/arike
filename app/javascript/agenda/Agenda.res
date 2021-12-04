type patient = Agenda__Types.patient
type props = Agenda__Types.props

let s = React.string

@react.component
let make = (~props: props) => {
    
    <div>
        <Agenda__Goto />
        <Agenda__Timeline schedules={props.schedules} />
    </div>
}