<template>
  <div>
    <v-list-item>
      <v-list-item-icon class="ml-n2">
        <v-list-item-avatar>
          <v-img
            :src="$store.getters['auth/currentUserAvatar']"
            v-if="$store.getters['auth/currentUserAvatar']"
            ></v-img>

          <v-avatar
            color="primary"
            size="40"
            v-if="!$store.getters['auth/currentUserAvatar'] && user.avatar_name"
          >
            <span class="white--text text-sm">{{ user.avatar_name }}</span>
          </v-avatar>

          <v-avatar
            color="primary lighten-1"
            size="40"
            v-if="!$store.getters['auth/currentUserAvatar'] && !user.avatar_name"
          >
            <v-icon
              class="white--text text-sm"
            >mdi-account</v-icon>
          </v-avatar>
        </v-list-item-avatar>
      </v-list-item-icon>

      <v-list-item-icon
        class="ml-9 mt-7"
        @click="pushMenuOpen"
      >
        <v-btn
          icon
        >
          <div>
            <v-icon>mdi-dots-vertical-circle-outline</v-icon>
            <v-list-item-title class="text-caption">menu</v-list-item-title>
          </div>
        </v-btn>
      </v-list-item-icon>

      <v-spacer></v-spacer>

      <v-list-item-icon
        class="mr-3 mt-7"
        v-show="pushMenu"
      >
        <v-btn
          icon
          color="error darken-1"
          @click="logout"
        >
          <div>
            <v-icon>mdi-logout-variant</v-icon>
            <v-list-item-title class="text-caption">logout</v-list-item-title>
          </div>
        </v-btn>
      </v-list-item-icon>

    </v-list-item>

    <v-list-item
      class="mt-n6"
    >
      <v-list-item-content class="my-2">
        <v-list-item-title class="text-h6">
          <!-- Sandra Adams -->
          {{ user.name }}
        </v-list-item-title>
        <v-list-item-subtitle>
          <!-- sandra_a88@gmail.com -->
          {{ user.email }}
        </v-list-item-subtitle>
      </v-list-item-content>

      <v-list-item-icon
        v-show="pushMenu"
        class="mr-3 mt-6"
      >
        <v-btn
          icon
          @click="pushEditOpen"
        >
          <div>
            <v-icon>mdi-playlist-edit</v-icon>
            <v-list-item-title class="text-caption">edit</v-list-item-title>
          </div>
        </v-btn>
      </v-list-item-icon>
    </v-list-item>

    <v-dialog
      v-model="toggleEditFlag"
      hide-overlay
      width="320px"
    >
      <edit-user class="justify-center"
        @closeForm="pushEditOpen"
      ></edit-user>
    </v-dialog>
  </div>
</template>

<script>
  import editUser from '@/components/sideNav/pcNav/startArea/logIn/editUser/EditUser'
  export default {
    components: {
      editUser,
    },
    data() {
      return {
        pushMenu: false,
        user: "",
        toggleEditFlag: false,
      }
    },
    methods: {
      pushMenuOpen() {
        this.pushMenu = !this.pushMenu;
      },
      pushEditOpen() {
        this.toggleEditFlag = !this.toggleEditFlag;
        this.pushMenu = false;
      },
      logout() {
        if (confirm("ログアウトしますか？")) {
          this.$store.dispatch("auth/logout");
          this.pushMenuOpen();
          this.$router.push('/');
        }
      },
    },
    computed: {
      userState() {
        return this.$store.getters["auth/currentUser"]
      },
    },
    watch: {
      userState() {
        this.$nextTick(() => {
          this.user = this.userState;
        })
      },
    },
    created() {
      this.user = this.userState;
    }
  }
</script>

<style lang="scss" scoped>

</style>