<template>
  <b-container fluid class="content-pane">
    <b-row>
      <b-col md="12">
        <div class="not-found">
          <b-alert show variant="danger"><strong>Page not found:</strong> {{ path }}</b-alert>
          <p>Return to the <a href="/">home page</a></p>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'NotFound',
  data () {
    return {
      path: this.$route.path
    }
  }
}
</script>
