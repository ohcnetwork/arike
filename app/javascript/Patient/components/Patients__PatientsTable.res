type patient = Patients__Types.patient
type patients = Patients__Types.patients

let s = React.string


module Patient = {
    @react.component
    let make = (~patient: patient) => {
        <tr className="bg-white">
            <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                {s(patient.name)}
            </td>

            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {s(patient.dob->Js.Date.toDateString)}
            </td>

            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {s(patient.phone)}
            </td>

            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {s(patient.address)}
            </td>

            <td className="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                <Link
                    className="cursor-pointer text-indigo-600 hover:text-indigo-900"
                    href={`patients/${patient.id}`}
                    text="Visit"
                />
            </td>
        </tr>
    }
}


@react.component
let make = (~patients: patients) => {


    <div className="shadow overflow-hidden border-b border-gray-200 rounded-lg">
        <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
                <tr>
                    <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Full Name")}
                    </th>
                    <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Date of Birth")}
                    </th>
                    <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Phone")}
                    </th>
                    <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Address")}
                    </th>
                    <th
                        scope="col"
                        colSpan={2}
                        className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Actions")}
                    </th>
                </tr>
            </thead>
            <tbody>
                {
                    patients->Js.Array2.map(patient =>
                        <Patient key={patient.id} patient />
                    )->React.array
                }
            </tbody>
        </table>
    </div>
}