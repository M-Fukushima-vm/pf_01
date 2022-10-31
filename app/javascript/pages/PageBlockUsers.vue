<template>
  <div>
    <users-tool-bar></users-tool-bar>
    <v-row>
      <v-col>
        <block-users-list></block-users-list>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import usersToolBar from '@/components/toolBar/UsersToolBar'
  import blockUsersList from '@/components/lists/BlockUsersList.vue'
  export default {
    components: {
      usersToolBar,
      blockUsersList,
    },
    created() {
      // 読み込みの確認用
        // console.log(this.$children)
    }
  }
</script>

<style lang="scss" scoped>

</style>