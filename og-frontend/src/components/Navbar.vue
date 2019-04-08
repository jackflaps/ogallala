<template>
  <b-navbar toggleable="sm" variant="success" fixed="top">
    <b-navbar-brand href="/">Ogallala</b-navbar-brand>

    <b-navbar-toggle target="nav_collapse" />

    <b-collapse is-nav id="nav_collapse">
      <b-navbar-nav class="ml-auto">
        <b-nav-item v-if="currentUser">Hello, <strong>{{ currentUser.name }}</strong></b-nav-item>
        <b-nav-item href="/entities/new">New Entity</b-nav-item>
        <b-nav-item href="/entities">View Entities</b-nav-item>
        <b-nav-item href="https://github.com/jackflaps/ogallala">GitHub</b-nav-item>
        <template v-if="currentUser">
          <logoutButton></logoutButton>
        </template>
        <template v-else>
          <loginButton></loginButton>
        </template>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
import { mapGetters } from 'vuex'
import loginButton from '@/components/buttons/login'
import logoutButton from '@/components/buttons/logout'

export default {
  name: 'Navbar',
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  components: { loginButton, logoutButton }
}
</script>
