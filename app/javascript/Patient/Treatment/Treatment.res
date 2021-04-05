let s = React.string

type option = MultiselectDropdown__Treatment.option

@react.component
let make = () => {
  let options: array<MultiselectDropdown__Treatment.option> = [
    {id: "1", name: "bed sore"},
    {id: "2", name: "wound"},
    {id: "3", name: "catheterisation"},
  ]

  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-3xl mx-auto">
      <MultiselectDropdown__Treatment
        id="care-catheterisation" className="p-4" name="care-given" label="Catheterisation" options
      />
      <MultiselectDropdown__Treatment
        id="care-wound" className="p-4" name="care-given" label="Wound" options
      />
      <MultiselectDropdown__Treatment
        id="care-catheterisation" className="p-4" name="care-given" label="Catheterisation" options
      />
    </div>
  </div>
}
