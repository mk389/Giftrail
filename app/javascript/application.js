// 必要なライブラリをインポート
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "./controllers"

// Stimulusの設定
const application = Application.start()

// デバッグ設定（開発時に有用）
application.debug = false

// Stimulusをグローバルでアクセスできるように設定
window.Stimulus = application

// アプリケーションをエクスポート
export { application }
