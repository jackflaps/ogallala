<template>
  <b-row>
    <b-col md="12">
      <b-alert dismissible show variant="danger" v-if="alerts.error">{{ alerts.error }}</b-alert>
      <b-alert dismissible show variant="info" v-if="alerts.info">{{ alerts.info }}</b-alert>
      <b-alert dismissible show variant="success" v-if="alerts.success">{{ alerts.success }}</b-alert>
    </b-col>
  </b-row>
</template>

<script>
export default {
  name: 'Alerts',
  props: ['alerts']
}
</script>
