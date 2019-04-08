<template>
  <b-row>
    <b-col md="12" v-if="entity">
      <router-view :alerts="alerts" :entity="entity"></router-view>
    </b-col>
    <b-col md="12" v-else>
      <b-alert show variant="danger">{{ alerts.error }}: /entities/{{ $route.params.id }}</b-alert>
      <p>Return to the <a href="/">home page</a></p>
    </b-col>
  </b-row>
</template>

<script>
export default {
  name: 'Entity',
  props: ['alerts'],
  data () {
    return {
      entity: null
    }
  },
  beforeCreate () {
    this.$http.get('/entities/' + this.$route.params.id)
      .then(response => { this.entity = response.data })
      .catch(e => { this.alerts.error = e })
  }
}
</script>

<style scoped>
.entity-actions {
  float: right;
  padding-top: 10px;
}
</style>
