// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"

// Stimulusの設定
const application = Application.start()

application.debug = false
window.Stimulus = application

export { application }
