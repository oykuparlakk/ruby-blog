// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import RecommendationPopupController from "./controllers/recommendation_popup_controller";

application.register("recommendation-popup", RecommendationPopupController);

eagerLoadControllersFrom("controllers", application);
