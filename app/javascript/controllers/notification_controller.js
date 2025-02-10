import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { delay: Number };

  connect() {
    const delay = this.hasDelayValue ? this.delayValue : 3000;

    this.timeout = setTimeout(() => {
      this.dismiss();
    }, delay);
  }

  dismiss() {
    this.element.classList.add("opacity-0", "transition", "duration-500");
    setTimeout(() => {
      this.element.remove();
    }, 500);
  }
}
