<template>
  <div id="logout-wrapper"/>
</template>

<script>
export default {
  name: 'Logout',
  created () {
    delete localStorage.token
    this.$store.dispatch('logout')
    this.$router.push('/')
  }
}
</script>
