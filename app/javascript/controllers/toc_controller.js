import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toc"];

  connect() {
    this.generateTOC();
    this.setupStickyBehavior();
  }

  generateTOC() {
    const headings = document.querySelectorAll(
      "article .article-body h1, article .article-body h2, article .article-body h3, article .article-body h4, article .article-body h5, article .article-body h6"
    );
    if (headings.length === 0) return;

    const ul = document.createElement("ul");
    ul.className = "space-y-2";

    headings.forEach((heading, index) => {
      if (!heading.id) {
        heading.id = "heading-" + index;
      }

      const level = parseInt(heading.tagName.substring(1), 10);

      const li = document.createElement("li");
      li.style.marginLeft = (level - 1) * 1 + "rem";

      const a = document.createElement("a");
      a.href = `#${heading.id}`;
      a.textContent = heading.textContent;
      a.className =
        "text-primary-500 hover:text-primary-800 transition-colors text-sm";

      li.appendChild(a);
      ul.appendChild(li);
    });

    this.tocTarget.innerHTML = "";
    this.tocTarget.appendChild(ul);
  }

  setupStickyBehavior() {
    const tocContainer = this.element.querySelector(".sticky");
    const article = document.querySelector(".article-body");
    const header = document.querySelector("header");

    if (!tocContainer || !article || !header) return;

    const headerHeight = header.offsetHeight;
    const topOffset = headerHeight;

    window.addEventListener("scroll", () => {
      const articleRect = article.getBoundingClientRect();
      const tocRect = tocContainer.getBoundingClientRect();

      if (
        articleRect.top <= topOffset &&
        articleRect.bottom >= tocRect.height + topOffset
      ) {
        tocContainer.style.position = "fixed";
        tocContainer.style.top = `${topOffset}px`;
        tocContainer.style.width = `${tocContainer.parentElement.offsetWidth}px`;
      } else if (articleRect.top > topOffset) {
        tocContainer.style.position = "static";
        tocContainer.style.width = "auto";
      } else if (articleRect.bottom < tocRect.height + topOffset) {
        tocContainer.style.position = "absolute";
        tocContainer.style.top = `${article.offsetHeight - tocRect.height}px`;
        tocContainer.style.width = `${tocContainer.parentElement.offsetWidth}px`;
      }
    });
  }
}
