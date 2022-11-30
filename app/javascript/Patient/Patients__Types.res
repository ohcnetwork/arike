type patient = {
    id: string,
    name: string,
    dob: Js.Date.t,
    phone: string,
    address: string,
}

type patients = array<patient>

type props = {patients: patients}


let decode = json => {
    open Json.Decode
    {
        id: field("id", string, json),
        name: field("name", string, json),
        dob: field("dob", date, json),
        phone: field("phone", string, json),
        address: field("address", string, json)
    }
}