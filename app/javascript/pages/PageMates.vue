<template>
  <div>
    <users-tool-bar></users-tool-bar>
    <v-row>
      <v-col>
        <mates-list></mates-list>
      </v-col>

    </v-row>
  </div>
</template>

<script>
  import usersToolBar from '@/components/toolBar/UsersToolBar'
  import matesList from '@/components/lists/MatesList'
  export default {
    components: {
      usersToolBar,
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