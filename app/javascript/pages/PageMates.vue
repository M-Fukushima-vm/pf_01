<template>
  <div>
    <mates-tool-bar></mates-tool-bar>
    <v-row>
      <v-col>
        <mates-list></mates-list>
      </v-col>

    </v-row>
  </div>
</template>

<script>
  import matesToolBar from '@/components/toolBar/MatesToolBar'
  import matesList from '@/components/lists/MatesList'
  export default {
    components: {
      matesToolBar,
      matesList,
      
    },
    created() {
      // 読み込みの確認用
        // console.log(this.$children)
    }
  }
</script>

<style lang="scss" scoped>

</style>