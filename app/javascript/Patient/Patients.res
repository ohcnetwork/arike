type patient = Patients__Types.patient
type props = Patients__Types.props

let s = React.string

@react.component
let make = (~props: props) => {
    let (patients, setPatients) = React.useState(_ => props.patients)
    let (searchTerm, setSearchTerm) = React.useState(_ => "")

    React.useEffect1(() => {
        let search_term = searchTerm->Js.String.toLowerCase
        let filtered_patients =
        props.patients->Js.Array2.filter(patient =>
            search_term->Js.String.includes(patient.name->Js.String.toLowerCase) ||
            search_term->Js.String.includes(patient.address->Js.String.toLowerCase) ||
            search_term->Js.String.includes(patient.phone->Js.String.toLowerCase)
        )

        setPatients(_ => filtered_patients)
        None
  }, [searchTerm])
    
    <div className=" py-6">
        <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div className="flex mb-5 ml-1 items-center justify-between">
                <div className="font-semibold text-xl">{s("Patients")}</div>

                <div className="flex space-x-4">
                    <Link
                        className="cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                        href="patients/new"
                        text="Create New Patient"
                    />
                </div>
            </div>
            <div className="flex flex-col">
                <div className="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                    <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                        <Patients__Search placeholder="Search Patients" setSearchTerm />
                        <Patients__PatientsTable patients />
                    </div>
                </div>
            </div>
        </div>
    </div>
}