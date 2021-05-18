import Vue from 'vue'
import './plugins/axios'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'

import { ApiPlugin } from './lib/api.js'
import { StoragePlugin } from './lib/storage.js'
import { AlertErrorPlugin } from './lib/common.js'

//this.$storage.set('foo','bar');

Vue.use(ApiPlugin);
Vue.use(StoragePlugin);
Vue.use(AlertErrorPlugin)

Vue.config.productionTip = false

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
