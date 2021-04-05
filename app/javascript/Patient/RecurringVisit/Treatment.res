let s = React.string

module Selectable = MultiselectForTreatment.Selectable

@react.component
let make = () => {
  let unselected = [
    Selectable.makeTreatment(~id="1", ~name="Delhi"),
    Selectable.makeTreatment(~id="2", ~name="India"),
    Selectable.makeTreatment(~id="3", ~name="Washington D.C"),
    Selectable.makeTreatment(~id="4", ~name="USA"),
  ]

  <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-3xl mx-auto">
      <MultiselectForTreatment
        id="care-catheterisation"
        name="care-given"
        label="Catheterisation"
        placeholder="Enter catheterisation"
        options=unselected
      />
      <MultiselectForTreatment
        id="care-wound"
        name="care-given"
        label="Wound"
        placeholder="Enter wounds"
        options=unselected
      />
      <MultiselectForTreatment
        id="care-catheterisation"
        name="care-given"
        label="Catheterisation"
        placeholder="Enter catheterisation"
        options=unselected
      />
    </div>
  </div>
}
