let removeCHCSelect = () => {
  let value = document.getElementById("facility_kind").value;
  if (value === "CHC") {
    document.getElementById("remove_this_div").style.display = "none";
    document
      .getElementById("facility_parent_id")
      .setAttribute("disabled", "disabled");
  } else if (value === "Hospital") {
    document
      .getElementById("facility_parent_id")
      .setAttribute("disabled", "disabled");
    document.getElementById("remove_this_div").style.display = "none";
  } else {
    document.getElementById("facility_parent_id").removeAttribute("disabled");
    document.getElementById("remove_this_div").style.display = "block";
  }
};

let getDistrictOptionsAndEnableSelect = () => {
  let value = document.getElementById("facility_state_id").value;
  let district = document.getElementById("facility_district_id");
  if (value) {
    district.removeAttribute("disabled");
    district.className =
      "mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm";
    Rails.ajax({
      type: "GET",
      url: `districts_of_state/${value}`,
      success: function (districts) {
        district.innerHTML = "";
        const districtHTML = districts.map(
          (district) => `<option value=${district.id}>${district.name}</option>`
        );
        const districtOptions = districtHTML.join("\n");
        district.innerHTML = districtOptions;
      },
    });
  } else {
    district.setAttribute("disabled", "disabled");
    district.value = "";
    district.className =
      "mt-1 block w-full py-2 px-3 border border-gray-300 bg-gray-200 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm";
  }
};

let getWardOptionsAndEnableSelect = () => {
  let value = document.getElementById("facility_lsg_body_id").value;
  let ward = document.getElementById("facility_ward_id");
  if (value) {
    ward.removeAttribute("disabled");
    ward.className =
      "mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm";
    Rails.ajax({
      type: "GET",
      url: `wards_of_lsg_body/${value}`,
      success: function (wards) {
        ward.innerHTML = "";
        const wardHTML = wards.map(
          (ward) => `<option value=${ward.id}>${ward.number}</option>`
        );
        const wardOptions = wardHTML.join("\n");
        ward.innerHTML = wardOptions;
      },
    });
  } else {
    ward.setAttribute("disabled", "disabled");
    ward.value = "";
    ward.className =
      "mt-1 block w-full py-2 px-3 border border-gray-300 bg-gray-200 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm";
  }
};

document.addEventListener("turbolinks:load", () => {
  const facilityKindInput = document.getElementById("facility_kind");
  facilityKindInput.addEventListener("click", (event) => {
    removeCHCSelect();
  });

  const facilityStateInput = document.getElementById("facility_state_id");
  facilityStateInput.addEventListener("click", (event) => {
    getDistrictOptionsAndEnableSelect();
  });

  const facilityLsgBodyInput = document.getElementById("facility_lsg_body_id");
  facilityLsgBodyInput.addEventListener("click", (event) => {
    getWardOptionsAndEnableSelect();
  });
});
