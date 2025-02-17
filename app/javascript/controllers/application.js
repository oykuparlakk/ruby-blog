import { Application } from "@hotwired/stimulus";

const application = Application.start();

window.Stimulus = application;

export { application };

import { Tabs } from "tailwindcss-stimulus-components";

application.register("tabs", Tabs);
