<template>
  <v-app id="app" :style="{ background: 'transparent' }">
    <h2 class="primary--text font-weight-thin">{{ message }}</h2>
    <p class="secondary--text">{{ message }}</p>
    <v-btn small color="primary">ボタン</v-btn>
    <v-btn small color="primary">Primary</v-btn>
    <v-btn small color="accent">Accent</v-btn>
    <v-btn small color="secondary">Secondary</v-btn>
    <v-btn small color="error">Error</v-btn>
    <v-btn small color="warning">Warning</v-btn>
    <v-btn small color="info">Info</v-btn>
    <v-btn small color="success">Success</v-btn>
    <v-btn small outlined color="primary">ボタン</v-btn>
    <v-btn small outlined color="primary">Primary</v-btn>
    <v-btn small outlined color="accent">Accent</v-btn>
    <v-btn small outlined color="secondary">Secondary</v-btn>
    <v-btn small outlined color="error">Error</v-btn>
    <v-btn small outlined color="warning">Warning</v-btn>
    <v-btn small outlined color="info">Info</v-btn>
    <v-btn small outlined color="success">Success</v-btn>
  </v-app>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
/* p {
  font-size: 2em;
  text-align: center;
} */
</style>
