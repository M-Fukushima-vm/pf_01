<template>
  <div>
    <h2 class="primary--text font-weight-thin">{{ message }}</h2>
    <p class="secondary--text">{{ message }}</p>
    <v-list class="transparent">
      <v-list-item class="ma-n1">
        <v-btn small color="primary">ボタン</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="primary">Primary</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="accent">Accent</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="secondary">Secondary</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="error">Error</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="warning">Warning</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small color="info">Info</v-btn>
      </v-list-item class="ma-n1">
      <v-list-item class="ma-n1">
        <v-btn small color="success">Success</v-btn>
      </v-list-item>
    </v-list>
    <v-list class="transparent">
      <v-list-item class="ma-n1">
        <v-btn small outlined color="primary">ボタン</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="primary">Primary</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="accent">Accent</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="secondary">Secondary</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="error">Error</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="warning">Warning</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="info">Info</v-btn>
      </v-list-item>
      <v-list-item class="ma-n1">
        <v-btn small outlined color="success">Success</v-btn>
      </v-list-item>
    </v-list>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Hello Vue!"
      }
    },
  }
</script>

<style lang="scss" scoped>

</style>