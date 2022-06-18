<template>
  <v-card>
    <v-navigation-drawer
      class="transparent"
      app
      mini-variant
      :expand-on-hover="expandOn"
    >
      <start-area></start-area>

      <v-divider></v-divider>

      <v-list
        nav
        dense
      >
        <menu-area></menu-area>
      </v-list>
    </v-navigation-drawer>
  </v-card>
</template>

<script>
  import startArea from '@/components/sideNav/pcNav/startArea/StartArea'
  import menuArea from '@/components/sideNav/pcNav/menuArea/MenuArea'
  export default {
    components: {
      startArea,
      menuArea,
    },
    computed: {
      expandOn(){
        if (this.$store.getters['auth/currentUser']) {
          return true;
        }
      }
    },
  }
</script>

<style lang="scss" scoped>

</style>