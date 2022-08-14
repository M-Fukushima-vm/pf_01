// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Rails from "@rails/ujs"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

// Rails.start()
// ActiveStorage.start()

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('/app/assets/sass/main.scss')
require('/app/assets/sass/variables.scss')

import Vue from 'vue'
import App from '../app.vue'
import Vuetify from 'vuetify'
import colors from 'vuetify/es5/util/colors'
import 'vuetify/dist/vuetify.min.css'
import ja from 'vuetify/es5/locale/ja.js'
Vue.use(Vuetify)
const vuetify = new Vuetify({
  defaultAssets: {
    font: false,
    icons: false
  },
  theme: {
    themes: {
      light: {
        primary: '#ADB5BA',
        // accent: colors.lightGreen.lighten1,
        accent: colors.indigo.lighten3,
        secondary: '#7F878C',
        error: colors.pink.accent1,
        warning: colors.deepOrange.accent1,
        info: colors.blue.accent1,
        success: colors.teal.lighten3,
      }
    }
  },
});
import router from '@/router'
import store from '@/store'
import userStringParse from '@/userStringParse'
import shortkey from '@/vueShortkey'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify: new Vuetify({
      lang: {
        locales: { ja },
        current: 'ja',
      },
    }),
    router,
    store,
    userStringParse,
    shortkey,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})