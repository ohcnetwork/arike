type patient = Patients__Types.patient
type props = Patients__Types.props

let s = React.string

@react.component
let make = (~props: props) => {
    Js.log(props)
    
    <div>
        <h1>{s("Patients")}</h1>
    </div>
}