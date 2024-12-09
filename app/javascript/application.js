// import "./controllers";
// import "./packs/edit_article";

// document.addEventListener("turbo:load", () => {
//   const menuToggle = document.getElementById("menu-toggle");
//   const mobileMenu = document.getElementById("mobile-menu");

//   console.log(menuToggle, mobileMenu);

//   if (menuToggle && mobileMenu) {
//     menuToggle.addEventListener("click", () => {
//       console.log("Menu toggle clicked!");
//       mobileMenu.classList.toggle("hidden");
//     });
//   }
// });

// document.addEventListener("DOMContentLoaded", function () {
//   setTimeout(function () {
//     const flashMessages = document.querySelectorAll(".flash-message");
//     flashMessages.forEach(function (message) {
//       message.style.opacity = 0;
//       setTimeout(function () {
//         message.remove();
//       }, 100);
//     });
//   }, 3000);
// });

// document.addEventListener("DOMContentLoaded", () => {
//   const alertBox = document.getElementById("error_explanation");
//   if (alertBox) {
//     setTimeout(() => alertBox.remove(), 5000);
//   }
// });

// Rails.start();

import "@hotwired/turbo-rails";
import "controllers";
