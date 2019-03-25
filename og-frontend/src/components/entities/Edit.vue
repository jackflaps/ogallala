<template>
  <b-container fluid class="content-pane">
    <b-row v-if="entity">
      <b-col md="12">
        <div class="record-pane" v-if="currentUser">
          <b-alert dismissible show variant="danger" v-if="alerts.error">{{ alerts.error }}</b-alert>
          <b-alert dismissible show variant="success" v-if="alerts.success">{{ alerts.success }}</b-alert>
          <b-form class="entity-record-form" @submit.prevent="post" v-if="show">
            <h2>Edit {{ entity.authorized_name }}</h2>
            <section id="entity_basic_information">
              <h3 class="subrecord-form-heading">Basic Information</h3>
              <b-form-group id="entity_type" label-cols-sm="3" label="Entity Type" label-for="entity_type">
                <b-form-select v-model="form.entity.entity_type" :options="entityTypeOptions"/>
              </b-form-group>
              <b-form-group id="bioghist" label-cols-sm="3" label="Biographical/Historical Note" label-for="bioghist">
                <b-form-textarea v-model="form.entity.bioghist"/>
              </b-form-group>
            </section>

            <section id="entity_names">
              <h3 class="subrecord-form-heading">
                <span class="subrecord-form-heading-label">Names</span>
                <b-button size="sm" variant="light" class="subrecord-add btn-pull-right" @click="addNewName">Add Name</b-button>
              </h3>

              <div class="subrecord-form-container">
                <ul class="subrecord-form-list">
                  <name-entry v-for="(name, index) in form.entity.names_attributes" :key="name.id" :name="name" :index="index" v-show="!name._destroy"/>
                </ul>
              </div>
            </section>

            <section id="entity_admin_details">
              <h3 class="subrecord-form-heading">Administrative Details</h3>
              <b-form-group id="legal_status" label-cols-sm="3" label="Legal Status" label-for="legal_status">
                <b-form-input v-model="form.entity.legal_status"/>
              </b-form-group>
              <b-form-group id="cataloging_level" label-cols-sm="3" label="Cataloging Level" label-for="cataloging_level">
                <b-form-select v-model="form.entity.cataloging_level" :options="catalogingLevelOptions"/>
              </b-form-group>
              <b-form-group id="record_status" label-cols-sm="3" label="Record Status" label-for="record_status">
                <b-form-select v-model="form.entity.record_status" :options="recordStatusOptions"/>
              </b-form-group>
            </section>

            <div class="form-actions">
              <b-button type="submit" size="sm" variant="primary">Save</b-button>
              <b-button :href="this.uri" size="sm" variant="outline-secondary">Cancel</b-button>
            </div>
          </b-form>
        </div>
        <div class="record-pane" v-else>
          <b-alert show variant="danger"><strong>Error:</strong> You are not authorized to edit this resource.</b-alert>
          <p>Return to the <a href="/">home page</a></p>
        </div>
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
import { mapGetters } from 'vuex'

export default {
  name: 'EditEntity',
  props: ['alerts'],
  data () {
    return {
      show: true,
      uri: this.$route.path.replace('/edit', ''),
      entity: null,
      form: null,
      entityTypeOptions: [
        { value: 'person', text: 'Person' },
        { value: 'corporate_body', text: 'Corporate Body' },
        { value: 'family', text: 'Family' }
      ],
      catalogingLevelOptions: [
        { value: 'minimal', text: 'Minimal' },
        { value: 'partial', text: 'Partial' },
        { value: 'full', text: 'Full' }
      ],
      recordStatusOptions: [
        { value: 'draft', text: 'Draft' },
        { value: 'finalized', text: 'Finalized' },
        { value: 'revised', text: 'Revised' },
        { value: 'deleted', text: 'Deleted' }
      ]
    }
  },
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  methods: {
    addNewName: function () {
      this.form.entity.names_attributes.push({
        _destroy: null,
        id: null,
        name: '',
        form: ''
      })
    },
    post (event) {
      this.$http.post(this.uri, this.form)
        .then(response => {
          this.alerts.success = 'Updated: ' + this.uri
          this.$router.push(this.uri)
        })
        .catch(e => { this.alerts.error = e.response.status + ' ' + e.response.data.message })
    }
  },
  created (names) {
    this.$http.get('/entities/' + this.$route.params.id)
      .then(response => {
        this.entity = response.data
        names = this.entity.names
        names.forEach(function (name) { name._destroy = null })
        this.form = { entity: {
          id: this.entity.id,
          entity_type: this.entity.entity_type,
          bioghist: this.entity.bioghist,
          names_attributes: names,
          legal_status: this.entity.legal_status,
          cataloging_level: this.entity.cataloging_level,
          record_status: this.entity.record_status
        } }
      })
      .catch(e => { this.alerts.error = e.response.status + ' ' + e.response.data.message })
  }
}
</script>

<style>
.btn-pull-right,
.form-actions {
  float: right;
}

.form-actions {
  margin-bottom: 1rem;
}

.form-group {
  padding: 0.5rem 1rem;
}

.subrecord-form-container {
  margin-left: 0.5rem;
}

.subrecord-form-heading {
  padding: 0.25rem;
  background-color: rgba(245, 245, 245, 0.75);
}

.subrecord-form-list {
  list-style-type: none;
  padding-left: 0;
}

.subrecord-add {
  border: 1px solid rgba(0, 0, 0, 0.125);
  background: #fff;
}

.subrecord-remove {
  line-height: 100%;
  border: 1px solid rgba(0, 0, 0, 0.125);
  background: #fff;
  padding: 0.25rem;
}
</style>
