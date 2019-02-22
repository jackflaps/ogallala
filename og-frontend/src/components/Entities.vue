<template>
  <div id="entities">
    <h2>Entities</h2>

    <div v-for="entity in entities" :key="entity.id">
      <p><a :href="'/entities/' + entity.id">{{ entity.authorized_name }}</a></p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      entities: []
    }
  },
  created () {
    axios.get('http://localhost:8080/entities')
      .then(response => {
        this.entities = response.data
      })
      .catch(e => {
        this.error.push(e)
      })
  }
}
</script>
