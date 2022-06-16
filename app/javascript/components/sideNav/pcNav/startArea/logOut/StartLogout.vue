<template>
  <div>
    <v-list-item-icon>
      <v-btn
        icon
        class="px-1 mx-2"
        @click="toggleLoginForm"
      >
        <div>
          <v-icon>mdi-login-variant</v-icon>
          <v-list-item-title class="text-caption">start</v-list-item-title>
        </div>
      </v-btn>
    </v-list-item-icon>

    <v-dialog
      v-model="toggleLoginFlag"
      hide-overlay
      width="300px"
    >
      
      <login-form
        class="justify-center"
        @closeForm="toggleLoginForm"
      ></login-form>
      
    </v-dialog>
  </div>
</template>

<script>
  import loginForm from '@/components/sideNav/pcNav/startArea/logOut/loginForm/LoginForm'
  export default {
    components: {
      loginForm,
    },
    data() {
      return {
        toggleLoginFlag: false,
      }
    },
    methods: {
      toggleLoginForm(){
        this.toggleLoginFlag = !this.toggleLoginFlag;
      },
    },
  }
</script>

<style lang="scss" scoped>

</style>