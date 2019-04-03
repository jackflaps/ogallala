<template>
  <b-container fluid class="content-pane">
    <b-row>
      <b-col md="12">
        <router-view :alerts="alerts"></router-view>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'Entities',
  props: ['alerts']
}
</script>

<style scoped>
.btn-group-xs > .btn, .btn-xs {
  padding: 0.25rem 0.4rem;
  font-size: 0.75rem;
  line-height: 0.5;
  border-radius: 0.2rem;
}
</style>
