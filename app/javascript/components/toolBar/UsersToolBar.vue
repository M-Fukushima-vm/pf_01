<template>
  <v-app-bar
    color="transparent"
    app
    flat
    dense
  >
    <v-list-item>
      <v-spacer></v-spacer>
      <v-list-item-icon>
        <v-btn
          link
          to="/mates"
          icon
          class="mx-4 mt-1"
        >
          <div>
            <v-icon class="ml-2">mdi-account-switch-outline</v-icon>
            <v-list-item-title class="text-caption">Mates</v-list-item-title>
          </div>
        </v-btn>

        <v-btn
          link
          to="/followers"
          icon
          class="mx-4 mt-1"
        >
          <div>
            <v-badge
              bordered
              overlap
              bottom
              left
              offset-x="30"
              offset-y="30"
              color="error"
              :content="this.current_user_followers.length"
              :value="this.current_user_followers.length"
            >
              <v-icon class="ml-6">mdi-account-music-outline</v-icon>
            </v-badge>
            <v-list-item-title class="text-caption">Followers</v-list-item-title>
          </div>
        </v-btn>

        <v-btn
          link
          to="/users"
          icon
          class="mx-4 mt-1"
        >
          <div>
            <v-icon class="ml-3">mdi-account-search-outline</v-icon>
            <v-list-item-title class="text-caption">Search</v-list-item-title>
          </div>
        </v-btn>

        <v-btn
          link
          to="/mute_users"
          icon
          class="mx-3 mt-1"
        >
          <div>
            <v-icon class="ml-1">mdi-account-minus-outline</v-icon>
            <v-list-item-title class="text-caption">Mute</v-list-item-title>
          </div>
        </v-btn>

        <v-btn
          link
          to="/block_users"
          icon
          class="mx-4 mt-1"
        >
          <div>
            <v-icon class="ml-2">mdi-account-cancel-outline</v-icon>
            <v-list-item-title class="text-caption">Block</v-list-item-title>
          </div>
        </v-btn>

      </v-list-item-icon>
      <v-spacer></v-spacer>
    </v-list-item>
  </v-app-bar>
</template>

<script>
import axios from "axios";
import qs from "qs";

export default {
  data() {
    return {
      current_user: "",
      current_user_followings: [],
      current_user_mutings: [],
      current_user_blockings: [],
      current_user_followers: [],
    };
  },
  async created() {
    await this.getCurrentUser();
    this.getCurrentUserFollowings();
    this.getCurrentUserMutings();
    this.getCurrentUserBlockings();
    this.getCurrentUserFollowers();
  },
  methods: {
    getCurrentUser() {
      const current_user_data = this.$store.getters['auth/reference_currentUser']
          // console.log(JSON.stringify(current_user_data, null, 2))
      const new_current_user = {
        id: current_user_data.id,
        name: current_user_data.name
      }
      this.current_user = new_current_user
          // console.log(JSON.stringify(this.current_user, null, 2))
    },
    async getCurrentUserFollowings() {
      const current_user = this.$store.getters['auth/reference_currentUser']
      const res = await axios.get(`/api/users/${current_user.id}/followings`);
      this.current_user_followings = res.data.users
      // console.log(this.current_user_followings)
    },
    async getCurrentUserMutings() {
      const current_user = this.$store.getters['auth/reference_currentUser']
      const res = await axios.get(`/api/users/${current_user.id}/muting_users`);
      this.current_user_mutings = res.data.users
      // console.log(this.current_user_mutings)
    },
    async getCurrentUserBlockings() {
      const current_user = this.$store.getters['auth/reference_currentUser']
      const res = await axios.get(`/api/users/${current_user.id}/blocking_users`);
      this.current_user_blockings = res.data.users
      // console.log(this.current_user_blockings)
    },
    async getCurrentUserFollowers() {
      const current_user = this.$store.getters['auth/reference_currentUser']
      const res = await axios.get(`/api/users/${current_user.id}/followers`);
      this.current_user_followers = res.data.users
      // console.log(this.current_user_followers)
    },
  },
};
</script>

<style lang="scss" scoped>
.v-btn {
  text-decoration: none;
}
</style>