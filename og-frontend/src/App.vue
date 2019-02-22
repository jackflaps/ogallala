<template>
  <div id="app">
    <b-navbar toggleable="sm" variant="success" fixed="top">
      <b-navbar-brand href="/">Ogallala</b-navbar-brand>

      <b-navbar-toggle target="nav_collapse" />

      <b-collapse is-nav id="nav_collapse">
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="/entity/new">New Entity</b-nav-item>
          <b-nav-item href="/entities">View Entities</b-nav-item>
          <b-nav-item href="https://github.com/jackflaps/ogallala">GitHub</b-nav-item>
          <b-nav-item>Login</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <div class="container">
      <router-view/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}

.container {
  padding-top: 15px;
}
</style>
