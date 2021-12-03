type patient = Agenda__Types.patient
type props = Agenda__Types.props

let s = React.string

@react.component
let make = (~props: props) => {
    
    <div>
        <Agenda__Goto />

        <h3>{s("Agenda")}</h3>
        <Agenda__Patient patient={props.scheduled_patients[0].patients[0]} />
    </div>
}