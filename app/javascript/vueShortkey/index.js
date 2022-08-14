import Vue from 'vue'
const ShortKey = require('vue-shortkey')

Vue.use(ShortKey, {
  prevent: [
    'input', 'textarea',
  ] // ショートカットキーを反映させない要素タグを登録
})

export default ShortKey

