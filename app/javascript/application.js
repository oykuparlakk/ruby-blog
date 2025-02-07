import { Application } from "@hotwired/stimulus";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

const application = Application.start();

window.Stimulus = application;

eagerLoadControllersFrom("controllers", application);

console.log("Stimulus initialized!", window.Stimulus.controllers);
