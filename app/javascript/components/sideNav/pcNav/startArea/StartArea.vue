<template>
  <div>
    <start-logout
      v-if="!$store.getters['auth/currentUser']"
    ></start-logout>
    <start-login
      v-if="$store.getters['auth/currentUser']"
    ></start-login>
  </div>
</template>

<script>
  import startLogout from '@/components/sideNav/pcNav/startArea/logOut/StartLogout'
  import startLogin from '@/components/sideNav/pcNav/startArea/logIn/StartLogin'
  export default {
    components: {
      startLogout,
      startLogin,
    },
  }
</script>

<style lang="scss" scoped>

</style>