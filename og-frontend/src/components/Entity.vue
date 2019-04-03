<template>
  <b-container fluid class="content-pane">
    <b-row v-if="entity">
      <b-col md="12">
        <router-view :alerts="alerts" :entity="entity"></router-view>
      </b-col>
    </b-row>

    <b-row v-else>
      <b-col md="12">
        <b-alert show variant="danger">{{ alerts.error }}: /entities/{{ $route.params.id }}</b-alert>
        <p>Return to the <a href="/">home page</a></p>
      </b-col>
    </b-row>
  </b-container>
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
  created () {
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
