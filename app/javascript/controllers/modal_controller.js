import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["parent", "frame"];

  connect() {
    const frameTarget = this.frameTarget;
    const observer = new MutationObserver((changes) => {
      changes.forEach((change) => {
        if (change.attributeName === "src" && frameTarget.src) {
          this.open();
        }
      });
    });

    observer.observe(frameTarget, { attributes: true });
  }

  open() {
    this.parentTarget.classList.remove("hidden");
  }

  close() {
    this.frameTarget.removeAttribute("src");
    this.parentTarget.classList.add("hidden");
    window.location.reload();
  }
}
