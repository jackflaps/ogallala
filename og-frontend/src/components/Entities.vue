<template>
  <b-container fluid class="content-pane">
    <b-row>
      <b-col md="12">
        <div class="record-pane">
          <h2>Entities</h2>
          <b-row v-for="entity in entities" :key="entity.id">
            <b-col class="entity-actions" sm="2">
              <b-button :href="'/entities/' + entity.id + '/edit'" size="xs" variant="primary" v-if="currentUser">Edit</b-button>
              <b-button :href="'/entities/' + entity.id" size="xs" variant="outline-secondary">View</b-button>
            </b-col>
            <b-col md="10">
              {{ entity.authorized_name }}
            </b-col>
          </b-row>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      entities: []
    }
  },
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
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

<style scoped>
.btn-group-xs > .btn, .btn-xs {
  padding: 0.25rem 0.4rem;
  font-size: 0.75rem;
  line-height: 0.5;
  border-radius: 0.2rem;
}

.entity-actions {
  float: left;
}
</style>
