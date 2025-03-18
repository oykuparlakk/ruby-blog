import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["publishAtField", "checkbox"]

  connect() {
    this.togglePublishAtField()
  }

  togglePublishAtField() {
    if (this.checkboxTarget.checked) {
      this.publishAtFieldTarget.style.display = "block";
    } else {
      this.publishAtFieldTarget.style.display = "none";
    }
  }
}
