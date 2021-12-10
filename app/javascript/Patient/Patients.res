type patient = Patients__Types.patient
type props = Patients__Types.props

let s = React.string

@react.component
let make = (~props: props) => {
    
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
                        <Patients__PatientsTable patients={props.patients} />
                    </div>
                </div>
            </div>
        </div>
    </div>
}