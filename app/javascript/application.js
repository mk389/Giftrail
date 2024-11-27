// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"

// Stimulusの設定
const application = Application.start()

const swiper = new Swiper('.swiper', {
  loop: true, // スライダーをループさせる
  pagination: {
    el: '.swiper-pagination', // ページネーションを有効にする
  },
  navigation: {
    nextEl: '.swiper-button-next', // 次へボタン
    prevEl: '.swiper-button-prev', // 前へボタン
  },
});

application.debug = false
window.Stimulus = application

export { application }
