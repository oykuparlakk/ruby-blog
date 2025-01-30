import { Controller } from "@hotwired/stimulus";

// Stimulus controller
export default class extends Controller {
  static targets = ["popup"];

  connect() {
    console.log("Stimulus controller yüklendi!");
  }

  show() {
    this.popupTarget.classList.remove("hidden");
  }

  hide() {
    this.popupTarget.classList.add("hidden");
  }
}
