# Pin your application's JavaScript files
pin "application", preload: true
pin "swiper", to: "https://cdn.jsdelivr.net/npm/swiper@8.4.5/swiper-bundle.min.js"
pin "swiper/css", to: "https://cdn.jsdelivr.net/npm/swiper@8.4.5/swiper-bundle.min.css"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
