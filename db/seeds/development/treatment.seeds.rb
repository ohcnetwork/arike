hash = { "a" => ["a", "b", "c"], "b" => ["b", "c"] }

treatments = {
  "General care" => [
    "Mouth care",
    "Bath",
    "Nail cutting",
    "Shaving",
  ],
  "Genito urinary care" => [
    "Perennial care",
    "Condom catheterisation & training",
    "Nelcath catheterisation & training",
    "Foley’s catheterisation",
    "Foley’s catheter care",
    "Suprapubic catheterisation",
    "Suprapubic catheter care",
    "Bladder wash with normal saline",
    "Bladder wash with soda bicarbonate",
    "Urostomy care",
  ],
  "Gastro-intestinal care" => [
    "Ryles tube insertion",
    "Ryles tube care",
    "Ryles tube feeding & training",
    "PEG care",
    "Per Rectal Enema",
    "High enema",
    "Bisacodyl Suppository",
    "Digital evacuation",
    "Colostomy care",
    "Colostomy irrigation care",
    "ileostomy care",
  ], 
  "Wound care" => [
    "Wound care training given to family",
    "Wound dressing",
    "Suture removal",
    "Vacuum dressing",
  ],
  "Respiratory care" => [
    "Tracheostomy care",
    "Chest physiotherapy",
    "Inhaler training",
    "Oxygen concentrator - training",
    "Bi-PAP training",
    "Bandaging",
    "Upper limb lymphedema bandaging",
    "Lower limb lymphedema bandaging",
    "Upper limb lymphedema hosiery",
    "PVOD bandaging",
  ],
  "Invasive care" => [
    "IV fluid infusion",
    "IV medicine bolus administration",
    "IV cannula care",
    "IV cannula insertion",
    "S/C cannula insertion",
    "S/C fluid infusion (subcutaneous)",
    "S/C medicine bolus administration",
    "S/C cannula care",
    "Ascites tapping",
    "Ascitic catheter care"
  ],
  "Physiotherapy" => [
    "Passive Movement",
    "Active Movement",
    "Strengthening exercises",
    "NDT",
    "GAIT Training",
    "Modalities + text field",
    "Breathing exercises",
    "Balance & Coordination exercises",
    "Stretching",
    "Postural correction",
  ]
}

treatments.each do | key , val | 
  val.each do |it|
    Treatment.create!(
      name: it,
      category: key
    )
  end
end

# treatments.each do |t|
#   Treatment.create!(
#     name: t,
#   )
# end
