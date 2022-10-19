<template>
  <div>
    <users-tool-bar></users-tool-bar>
    <v-row>
      <v-col>
        <mute-users-list></mute-users-list>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import usersToolBar from '@/components/toolBar/UsersToolBar'
  import muteUsersList from '@/components/lists/MuteUsersList'
  export default {
    components: {
      usersToolBar,
      muteUsersList,
    },
    created() {
      // 読み込みの確認用
        // console.log(this.$children)
    }
  }
</script>

<style lang="scss" scoped>

</style>