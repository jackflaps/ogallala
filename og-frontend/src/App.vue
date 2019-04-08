<template>
  <div id="app">
    <Navbar/>
    <b-container fluid class="content-pane">
      <Alerts :alerts="alerts"/>
      <router-view :alerts="alerts"></router-view>
    </b-container>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Alerts from '@/components/Alerts'

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
  components: { Navbar, Alerts }
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
