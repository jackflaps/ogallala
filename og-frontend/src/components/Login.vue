<template>
  <div class="login-wrapper">
    <b-alert dismissible variant="danger" v-if="error" show>{{ error }}</b-alert>
    <b-form @submit.prevent="login" v-if="show">
      <b-form-group id="email" label="E-mail address:" label-for="email">
        <b-form-input id="email" type="text" v-model="form.email"/>
      </b-form-group>
      <b-form-group id="password" label="Password:" label-for="password">
        <b-form-input id="password" type="password" v-model="form.password"/>
      </b-form-group>
      <b-button type="submit" variant="primary">Log in</b-button>
    </b-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Login',
  data () {
    return {
      form: {
        email: '',
        password: ''
      },
      error: false,
      show: true
    }
  },
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  methods: {
    login () {
      this.$http.post('/login', { email: this.form.email, password: this.form.password })
        .then(request => this.loginSuccessful(request))
        .catch(() => this.loginFailed())
    },
    loginSuccessful (req) {
      if (!req.data.token) {
        this.loginFailed()
        return
      }
      localStorage.token = req.data.token
      this.error = false
      this.$store.dispatch('login')
      this.$router.push('/')
    },
    loginFailed () {
      this.error = 'Login failed!'
      delete localStorage.token
    }
  }
}
</script>
