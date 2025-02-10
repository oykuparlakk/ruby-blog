import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["progress"];

  connect() {
    this.updateProgress();
    window.addEventListener("scroll", this.updateProgress.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.updateProgress.bind(this));
  }

  updateProgress() {
    const scrollTop = window.scrollY;
    const docHeight =
      document.documentElement.scrollHeight - window.innerHeight;
    const scrollPercent = (scrollTop / docHeight) * 100;
    this.progressTarget.style.width = `${scrollPercent}%`;
  }
}
