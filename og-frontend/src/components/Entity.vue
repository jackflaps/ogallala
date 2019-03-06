<template>
  <div id="entity">
    <div v-if="entity">
      <h2>{{ entity.authorized_name }}</h2>

      <h3>Names</h3>
      <div v-for="name in entity.names">
        <p class="variant-forms">
          <span>{{ name.name }}</span>
          <span class="badge badge-info">{{ name.form }}</span>
        </p>
      </div>

      <div v-if="entity.bioghist">
        <h3 id="bioghist">
          <div v-if="entity.entity_type === 'person'">
            Biography
          </div>
          <div v-else>
            History
          </div>
        </h3>
        <p>{{ entity.bioghist }}</p>
      </div>

      <div role="admin-details">
        <b-card no-body class="mb-0">
          <b-card-header header-tag="admin-heading" class="p-1" role="tab">
            <b-button href="#" v-b-toggle.admin-details variant="light">Administrative Details</b-button>
          </b-card-header>
          <b-collapse id="admin-details" accordion="my-accordion" role="tabpanel">
            <b-card-body>
              <div v-if="entity.legal_status">
                <p><strong>legal status</strong> {{ entity.legal_status }}</p>
              </div>
              <p><strong>record status</strong> {{ entity.record_status }}</p>
              <p><strong>cataloging level</strong> {{ entity.cataloging_level }}</p>
              <p><strong>cataloging language</strong> {{ entity.cataloging_language }}</p>
            </b-card-body>
          </b-collapse>
        </b-card>
      </div>
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
