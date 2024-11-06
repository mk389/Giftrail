// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"

// Stimulusの設定
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

document.addEventListener("turbo:render", function() {
    console.log("turbo:render event fired");
    const flashMessage = document.getElementById("flash-message");
    if (flashMessage) {
      setTimeout(() => {
        flashMessage.style.display = "none";
      }, 3000);  // 3秒後に非表示にする
    }
  }); 

export { application }
