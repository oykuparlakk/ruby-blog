import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "trigger", "content"];

  connect() {
    console.log("Modal Controller Yüklendi:", this.modalTarget);
  }

  open() {
    if (!this.modalTarget) {
      console.error("Modal target bulunamadı!");
      return;
    }
    this.modalTarget.showModal();
    this.loadForm();
  }

  close() {
    this.modalTarget.close();
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }

  loadForm() {
    if (!this.contentTarget) {
      console.error("Content target bulunamadı!");
      return;
    }

    const url = this.contentTarget.dataset.formUrl;
    fetch(url)
      .then((response) => response.text())
      .then((html) => {
        this.contentTarget.innerHTML = html;
      })
      .catch((error) => console.error("Form yüklenirken hata oluştu:", error));
  }
}
