<template>
  <div id="app">
    <Navbar/>
    <router-view :alerts="alerts"/>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'

export default {
  name: 'App',
  data () {
    return {
      alerts: {
        error: null,
        success: null
      }
    }
  },
  components: { Navbar }
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

.content-pane {
  padding-top: 10px;
}
</style>
