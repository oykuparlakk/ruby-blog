import { Turbo } from "@hotwired/turbo-rails";
import "./controllers";
import "./packs/edit_article";

document.addEventListener("turbo:load", () => {
  const menuToggle = document.getElementById("menu-toggle");
  const mobileMenu = document.getElementById("mobile-menu");

  console.log(menuToggle, mobileMenu);

  if (menuToggle && mobileMenu) {
    menuToggle.addEventListener("click", () => {
      console.log("Menu toggle clicked!");
      mobileMenu.classList.toggle("hidden");
    });
  }
});
