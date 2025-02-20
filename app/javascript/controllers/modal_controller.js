import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["parent", "frame"];

  open() {
    this.parentTarget.classList.remove("hidden");
  }

  close() {
    this.frameTarget.innerHTML = "";
    this.parentTarget.classList.add("hidden");
  }
}
