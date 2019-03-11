<template>
  <div id="entities">
    <h2>Entities</h2>

    <div v-for="entity in entities" :key="entity.id">
      <p><a :href="'/entities/' + entity.id">{{ entity.authorized_name }}</a></p>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      entities: []
    }
  },
  created () {
    this.$http.get('/entities')
      .then(response => {
        this.entities = response.data
      })
      .catch(e => {
        this.error.push(e)
      })
  }
}
</script>
