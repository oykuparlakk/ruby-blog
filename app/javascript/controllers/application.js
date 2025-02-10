import { Application } from "stimulus";
import DropdownController from "./dropdown_controller";
import TocController from "./toc_controller";
import HeaderController from "./header_controller";
import TagsController from "./tags_controller";
import NotificationController from "./notification_controller";
import ModalController from "./modal_controller";
import ProgressController from "./controllers/progress_controller";

const application = Application.start();
application.register("dropdown", DropdownController);
application.register("header", HeaderController);
application.register("tags", TagsController);
application.register("toc", TocController);
application.register("notification", NotificationController);
application.register("modal", ModalController);
application.register("progress", ProgressController);

window.Stimulus = application;

export { application };
