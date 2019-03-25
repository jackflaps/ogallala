<template>
  <b-container fluid class="content-pane">
    <b-row v-if="entity">
      <b-col md="12">
        <div class="record-pane">
          <b-alert dismissible show variant="danger" v-if="alerts.error">{{ alerts.error }}</b-alert>
          <b-alert dismissible show variant="success" v-if="alerts.success">{{ alerts.success }}</b-alert>
          <h2>{{ entity.authorized_name }}</h2>

          <section id="entity_names">
            <h3>Names</h3>
            <div v-for="name in entity.names" :key="name.id">
              <p class="variant-forms">
                <span>{{ name.name }}</span>
                <span class="badge badge-info">{{ name.form }}</span>
              </p>
            </div>
          </section>

          <section id="entity_bioghist" v-if="entity.bioghist">
            <h3 v-if="entity.entity_type === 'person'">
              Biography
            </h3>
            <h3 v-else>
              History
            </h3>
            <p>{{ entity.bioghist }}</p>
          </section>

          <section id="entity_admin_details">
            <div role="admin-details">
              <b-card no-body class="mb-0">
                <b-card-header id="admin-heading" class="p-1" role="tab">
                  <b-button href="#" v-b-toggle.admin-details variant="light">Administrative Details</b-button>
                </b-card-header>
                <b-collapse id="admin-details" accordion="my-accordion" role="tabpanel">
                  <b-card-body>
                    <div v-if="entity.legal_status">
                      <p><strong>legal status</strong> {{ entity.legal_status }}</p>
                    </div>
                    <p><strong>record status</strong> {{ entity.record_status }}</p>
                    <p><strong>cataloging level</strong> {{ entity.cataloging_level }}</p>
                  </b-card-body>
                </b-collapse>
              </b-card>
            </div>
          </section>

          <section id="entity_actions" class="entity-actions" v-if="currentUser">
            <b-button :href="edit_path" size="sm" variant="primary">Edit</b-button>
            <b-button @click="deleteEntity" size="sm" variant="danger">Delete</b-button>
          </section>
        </div>
      </b-col>
    </b-row>
    <b-row v-else>
      <b-col md="12">
        <b-alert show variant="danger">{{ errors[0] }}: /entities/{{ $route.params.id }}</b-alert>
        <p>Return to the <a href="/">home page</a></p>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ShowEntity',
  props: ['alerts'],
  data () {
    return {
      entity: null,
      edit_path: this.$route.path + '/edit',
      errors: []
    }
  },
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  methods: {
    deleteEntity: function () {
      console.log('trying to delete!')
    }
  },
  created () {
    this.$http.get('/entities/' + this.$route.params.id)
      .then(response => { this.entity = response.data })
      .catch(e => { this.errors.push(e) })
  }
}
</script>

<style scoped>
.entity-actions {
  float: right;
  padding-top: 10px;
}
</style>
