import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "tab", "loading", "error"];

  connect() {
    console.log("✅ Tags controller yüklendi!");
    if (this.tabTargets.length > 0) {
      this.load(this.tabTargets[0]);
    }
  }

  async load(element) {
    if (element instanceof Event) {
      element.preventDefault();
    }

    let tagId;

    if (element instanceof Event) {
      tagId = element.currentTarget.dataset.id;

      this.tabTargets.forEach((tab) => {
        tab.classList.remove("bg-primary-500", "text-white");
        tab.classList.add("bg-white", "text-gray-700");
      });
      element.currentTarget.classList.remove("bg-white", "text-gray-700");
      element.currentTarget.classList.add("bg-primary-500", "text-white");
    } else {
      tagId = element.dataset.id;

      element.classList.remove("bg-white", "text-gray-700");
      element.classList.add("bg-primary-500", "text-white");
    }

    console.log("Tag clicked or loaded:", tagId);

    this.loadingTarget.classList.remove("hidden");
    this.contentTarget.classList.add("hidden");
    this.errorTarget.classList.add("hidden");

    try {
      const response = await fetch(`/tags/${tagId}.json`);

      if (response.ok) {
        const data = await response.json();
        this.renderArticles(data.articles);
        this.contentTarget.classList.remove("hidden");
      } else {
        throw new Error("Makale verileri alınamadı");
      }
    } catch (error) {
      console.error("Error:", error);
      this.errorTarget.classList.remove("hidden");
      this.contentTarget.innerHTML = "";
    } finally {
      this.loadingTarget.classList.add("hidden");
    }
  }

  renderArticles(articles) {
    if (articles.length > 0) {
      this.contentTarget.innerHTML = `
        <ul class="space-y-4">
          ${articles
            .map(
              (article) => `
            <li class="bg-white shadow rounded-lg p-4">
              <a href="/articles/${article.id}" class="text-lg font-semibold text-primary-600 hover:underline">${article.title}</a>
            </li>
          `
            )
            .join("")}
        </ul>
      `;
    } else {
      this.contentTarget.innerHTML =
        '<p class="text-center text-gray-500">Bu etiket için makale bulunamadı.</p>';
    }
  }
}
