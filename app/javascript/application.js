// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"
import Swiper from "swiper"
import "swiper/css";

// Stimulusの設定
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }

document.addEventListener('DOMContentLoaded', () => {
  const swiper = new Swiper('.swiper-container', {
    slidesPerView: 1,   // 1枚ずつ表示
    spaceBetween: 10,    // スライド間の余白
    navigation: {        // ナビゲーションボタン
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    pagination: {        // ページネーション
      el: '.swiper-pagination',
      clickable: true,   // クリック可能に
    },
    loop: true,          // ループさせる
  });
});