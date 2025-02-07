import { Application } from "stimulus";
import DropdownController from "./dropdown_controller";
import HeaderController from "./header_controller";
import TagsController from "./tags_controller";

const application = Application.start();
application.register("dropdown", DropdownController);
application.register("header", HeaderController);
application.register("tags", TagsController);

window.Stimulus = application;

export { application };
