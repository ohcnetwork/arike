let s = React.string

type date = Agenda__Types.date
type patients = Agenda__Types.patients
type schedules = Agenda__Types.schedules

module Timeline__Day = {
    @react.component
    let make = (~date: date, ~patients: patients) => {

        <div className="mb-2">
            <div className="flex items-center mb-2 mt-4">
                <div className="bg-gray-500 rounded-full h-8 w-8"></div>
                <div 
                    className="flex-1 ml-4 font-medium font-bold" 
                    id={`agenda-${date->Js.Date.toISOString->Js.String2.slice(~from=0, ~to_=10)}`}>
                    {s(date->Js.Date.toDateString)}
                </div>
            </div> 

            <Agenda__Patients patients />  
        </div>
    }
}


@react.component
let make = (~schedules: schedules) => {
    <div className="relative w-full m-8">
        <div className="border-r-2 border-gray-500 absolute h-full top-5 left-3.5"></div>
        <div className="list-none m-0 p-0">
            {
                schedules->Js.Array2.map(({date, patients}) =>
                    <Timeline__Day key={date->Js.Date.toDateString} date patients />
                )->React.array
            }
        </div>
    </div>
}