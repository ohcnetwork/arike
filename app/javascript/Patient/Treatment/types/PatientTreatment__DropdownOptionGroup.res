type t = {
  categoryName: string,
  options: array<PatientTreatment__DropdownOption.t>,
}

let categoryName = t => t.categoryName
let options = t => t.options

let make = (~categoryName, ~options) => {
  categoryName: categoryName,
  options: options,
}
