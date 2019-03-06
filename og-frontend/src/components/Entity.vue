<template>
  <div id="entity">
    <div v-if="entity">
      <h2>{{ entity.authorized_name }}</h2>
      <pre><code>{{ entity }}</code></pre>
    </div>
    <div v-else>
      <b-alert show variant="danger">{{ errors[0] }}: /entities/{{ $route.params.id }}</b-alert>
      <p>Return to the <a href="/">home page</a></p>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      entity: null,
      errors: []
    }
  },
  created () {
    axios.get('/entities/' + this.$route.params.id)
      .then(response => {
        this.entity = response.data
      })
      .catch(e => {
        this.errors.push(e)
      })
  }
}
</script>

<style>
pre {
  color: red;
  background-color: rgb(0,0,0,0.05);
  padding: 15px;
  border: 1px solid black;
}
</style>
