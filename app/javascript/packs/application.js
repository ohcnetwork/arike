// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
window.Rails = Rails;

import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import * as PatientFormPage from "../Patient/New/PersonalDetails/PersonalDetails.bs";
import * as PatientVitals from "../Patient/RecurringVisit/PatientVitals.bs";
import * as Schedule from "../schedule/Schedule.bs"

import "stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";

if (Rails.fire(document, "rails:attachBindings")) {
  Rails.start();
}

Turbolinks.start();
ActiveStorage.start();

window.PatientFormPage = PatientFormPage;
window.PatientVitals=PatientVitals;
window.Schedule = Schedule;
