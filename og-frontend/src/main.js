// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import BootstrapVue from 'bootstrap-vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faTimes } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import App from './App'
import router from './router'
import store from './store'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

axios.defaults.baseURL = 'http://localhost:8080'
axios.defaults.headers.post = {
  'Content-Type': 'application/json',
  'Authorization': localStorage.token
}

library.add(faTimes)
Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.component('hidden-input-destroy', {
  props: ['value'],
  template: `<input type="hidden" name="_destroy" v-bind:value="value"/>`
})
Vue.component('name-entry', {
  props: ['name', 'index'],
  data: function () {
    return {
      destroy: this.name._destroy,
      nameFormOptions: [
        { value: 'authorized', text: 'Authorized' },
        { value: 'parallel', text: 'Parallel' },
        { value: 'standardized', text: 'Standardized' },
        { value: 'other', text: 'Other' }
      ]
    }
  },
  methods: {
    removeName: function () {
      this.destroy = 'true'
      this.name._destroy = this.destroy
    }
  },
  template: `
    <li class="subrecord-form-fields" :index="index" v-show="!destroy">
      <hidden-input-destroy v-bind:value="destroy"/>
      <h4 class="subrecord-form-heading">
        <span>Name Form</span>
        <b-button size="xs" variant="light" class="btn-pull-right subrecord-remove" @click="removeName">
          <font-awesome-icon icon="times"/>
        </b-button>
      </h4>
      <b-form-group id="name_name" label-cols-sm="3" label="Name" label-for="name_name">
        <b-form-input v-model="name.name"/>
      </b-form-group>
      <b-form-group id="name_form" label-cols-sm="3" label="Name Form" label-for="name_form">
        <b-form-select v-model="name.form" :options="nameFormOptions"/>
      </b-form-group>
    </li>
  `
})

Vue.use(VueAxios, axios)
Vue.use(BootstrapVue)
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
