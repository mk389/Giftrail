// postcss.config.js
module.exports = {
    plugins: [
      require('tailwindcss'),    // TailwindCSS プラグインを追加
      require('autoprefixer'),   // ベンダープレフィックスを自動で追加
      require('daisyui'),        // DaisyUI プラグインを追加
    ]
  }
  