// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"
import Swiper from "swiper"

// Stimulusの設定
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }

document.addEventListener('turbo:load', () => {
  const swiperElements = document.querySelectorAll('.swiper'); // swiper要素を取得

  swiperElements.forEach((swiperElement, index) => {
    const swiper = new Swiper(swiperElement, {
      direction: 'horizontal', // 水平方向スライド
      loop: true,              // ループ設定

      // ページネーション
      pagination: {
        el: `.swiper-pagination-${index}`,  // インデックスを使って個別に設定
        clickable: true,
      },

      // ナビゲーションボタン
      navigation: {
        nextEl: `.swiper-button-next-${index}`,  // インデックスを使って個別に設定
        prevEl: `.swiper-button-prev-${index}`,  // インデックスを使って個別に設定
      },

      // スクロールバー（必要なら）
      scrollbar: {
        el: `.swiper-scrollbar-${index}`,  // インデックスを使って個別に設定
      },
    });
  });
});
