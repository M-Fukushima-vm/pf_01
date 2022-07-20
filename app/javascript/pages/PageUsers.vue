<template>
  <v-container>
    <v-list
      three-line
      class="pt-7"
      :style="{ background: 'transparent' }"
    >
      <template v-for="user in users">
        <v-list-item
          :key="user.id"
        >
          <v-list-item-avatar>
            <v-img
              v-if="user.avatar"
              :src="user.avatar"
            ></v-img>
            <v-avatar
              color="primary"
              size="40"
              v-if="!user.avatar && user.avatar_name"
            >
              <span class="white--text text-sm">{{ user.avatar_name }}</span>
            </v-avatar>
            <v-avatar
              color="primary lighten-1"
              size="40"
              v-if="!user.avatar && !user.avatar_name"
            >
              <v-icon
                class="white--text text-sm"
              >mdi-account</v-icon>
            </v-avatar>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title
              v-text="user.name"
              class="subtitle-1"
            ></v-list-item-title>
            <v-list-item-subtitle
              v-text="user.introduction"
              class="caption"
            ></v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider/>
      </template>
      
      <template v-if="pagingMeta">
        <div class="text-center pt-7">
          <v-pagination
            circle
            color="info"
            v-model="pagingMeta.current_page"
            :length="pagingMeta.total_pages"
            @input="paging"
          ></v-pagination>
        </div>
      </template>
    </v-list>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      users: [],
      currentPage: 1,
      pagingMeta: null, 
    };
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      const res = await axios.get(`/api/users`, {
        params: { page: this.currentPage },
      });
      this.users = res.data.users;
      this.pagingMeta = res.data.meta;
    },
    paging(pageNumber) {
      this.currentPage = pageNumber;
      this.fetchUsers();
      this.$vuetify.goTo(0);
    },
  },
};
</script>