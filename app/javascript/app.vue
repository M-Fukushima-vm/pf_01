<template>
  <v-app id="app" :style="{ background: 'transparent' }">
    <pc-nav></pc-nav>
    <tool-bar></tool-bar>
    <v-main>
      <v-container>
        <v-row
          dense
          justify="center"
          align-content="center"
        >
          <v-col cols=12>
            <color-sample></color-sample>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
  import pcNav from '@/components/sideNav/pcNav/PcNav'
  import toolBar from '@/components/toolBar/ToolBar'
  import colorSample from '@/components/colorSample/ColorSample'
  export default {
    data: function () {
      return {
        message: "Hello Vue!"
      }
    },
    components: {
      pcNav,
      toolBar,
      colorSample,
    }
  }
</script>

<style scoped>
/* p {
  font-size: 2em;
  text-align: center;
} */
</style>
