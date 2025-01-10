module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: ['pastel'],  // pastelテーマが適用されるように指定
  },
  theme: {
    extend: {
      colors: {
        primary: '#f7a8b8',  // pastelテーマのprimaryカラー（ピンク系）を強制的に設定
        'primary-focus': '#e57f91',  // hover時に適用される色
      },
    },
  },
}
