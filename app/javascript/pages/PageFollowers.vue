<template>
  <div>
    <users-tool-bar></users-tool-bar>
    <v-row>
      <v-col>
        <followers-list></followers-list>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import usersToolBar from '@/components/toolBar/UsersToolBar'
  import followersList from '@/components/lists/FollowersList'
  export default {
    components: {
      usersToolBar,
      followersList,
    },
    created() {
      // 読み込みの確認用
        // console.log(this.$children)
    }
  }
</script>

<style lang="scss" scoped>

</style>