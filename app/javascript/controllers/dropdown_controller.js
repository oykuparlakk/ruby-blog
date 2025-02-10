import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }

  connect() {
    document.addEventListener("click", this.closeOnClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnClickOutside.bind(this));
  }
}
