<template>
  <div class="record-pane">
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
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ShowEntity',
  props: ['alerts', 'entity'],
  data () {
    return {
      edit_path: this.$route.path + '/edit'
    }
  },
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  methods: {
    deleteEntity: function () {
      console.log('trying to delete!')
    }
  }
}
</script>

<style scoped>
.entity-actions {
  float: right;
  padding-top: 10px;
}
</style>
