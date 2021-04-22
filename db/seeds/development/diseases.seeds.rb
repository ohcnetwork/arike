after "development:lsg_bodies" do
  Disease.create!([
    {name: "DM", icds_code: "D-32"},
    {name: "Hypertension", icds_code: "HT-58"},
    {name: "IHD", icds_code: "IDH-21"},
    {name: "COPD", icds_code: "DPOC-144"},
    {name: "Dementia", icds_code: "DM-62"},
    {name: "CVA", icds_code: "CAV-89"},
    {name: "Cancer", icds_code: "C-98"},
    {name: "CKD", icds_code: "DC-25"}
  ])
end
