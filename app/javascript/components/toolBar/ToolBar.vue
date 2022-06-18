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
        <v-btn icon class="mx-3">
          <div>
            <v-icon>mdi-television-play</v-icon>
            <v-list-item-title class="text-caption">Video</v-list-item-title>
          </div>
        </v-btn>

        <v-btn icon class="mx-3">
          <div>
            <v-icon>mdi-music-note</v-icon>
            <v-list-item-title class="text-caption">Music</v-list-item-title>
          </div>
        </v-btn>

        <v-btn icon class="mx-3">
          <div>
            <v-icon>mdi-book</v-icon>
            <v-list-item-title class="text-caption">Book</v-list-item-title>
          </div>
        </v-btn>

        <v-btn icon class="mx-3">
          <div>
            <v-icon>mdi-image</v-icon>
            <v-list-item-title class="text-caption">Image</v-list-item-title>
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

</style>