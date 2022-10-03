<template>
  <v-app-bar
    color="transparent"
    app
    flat
    dense
  >
    <v-list-item>
      <v-spacer></v-spacer>
      <v-list-item-icon>
        <v-btn
          link
          to="/applicants"
          icon
          class="mx-3"
        >
          <div>
            <v-icon class="ml-3">mdi-account-alert-outline</v-icon>
            <v-list-item-title class="text-caption">Notice</v-list-item-title>
          </div>
        </v-btn>

        <v-btn
          link
          to="/mates"
          icon
          class="mx-3"
        >
          <div>
            <v-icon class="ml-2">mdi-account-switch-outline</v-icon>
            <v-list-item-title class="text-caption">Mates</v-list-item-title>
          </div>
        </v-btn>

      </v-list-item-icon>
      <v-spacer></v-spacer>
    </v-list-item>
  </v-app-bar>
</template>

<script>
  export default {
    
  }
</script>

<style lang="scss" scoped>
.v-btn {
  text-decoration: none;
}
</style>