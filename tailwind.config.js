module.exports = {
  content: [
    './app/views/**/*.{html,erb}',    // ビュー内のHTMLやERBファイル
    './app/helpers/**/*.rb',          // ヘルパーのRubyファイル（クラスが動的に挿入される場合）
    './app/javascript/**/*.js',       // JavaScriptファイル
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('daisyui'), // DaisyUIプラグインの追加
  ],
  daisyui: {
    themes: ['pastel'], // 使用するテーマを選択
  },
}
