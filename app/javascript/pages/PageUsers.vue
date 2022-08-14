<template>
  <v-container>
    <v-row>
      <v-col>
        <v-text-field
          class="pt-n3 pb-3"
          prepend-inner-icon="mdi-magnify"
          persistent-hint
          hint="入力内容で絞り込み表示 (フォーカスは shift + space )"
          persistent-placeholder
          placeholder="user name"
          v-model="query.userName"
          @input="fetchUsers"
          v-shortkey.once="['shift', 'space']"
          @shortkey.native="searchFocus"
          ref="searchUser"
        ></v-text-field>
        <v-list
          two-line
          :style="{ background: 'transparent' }"
          width="300"
        >
          <template v-for="user in users">
            <v-list-item
              :key="user.id"
              link
              @focus="focus(user)"
              @mouseover="focus(user)"
            >
              <v-list-item-avatar>
                <v-img
                  v-if="user.avatar_url"
                  :src="user.avatar_url"
                ></v-img>
                <v-avatar
                  color="primary"
                  size="40"
                  v-if="!user.avatar_url && user.avatar_name"
                >
                  <span class="white--text text-sm">{{ user.avatar_name }}</span>
                </v-avatar>
                <v-avatar
                  color="primary lighten-1"
                  size="40"
                  v-if="!user.avatar_url && !user.avatar_name"
                >
                  <v-icon
                    class="white--text text-sm"
                  >mdi-account</v-icon>
                </v-avatar>
              </v-list-item-avatar>

              <v-list-item-content>
                <v-list-item-title
                  v-text="user.name"
                  class="subtitle-1 text--secondary"
                ></v-list-item-title>
                <v-list-item-subtitle
                  v-text="user.introduction"
                  class="caption"
                ></v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
            <v-divider/>
          </template>
        </v-list>
          
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
      </v-col>

      <transition>
        <v-list
          :style="{ background: 'transparent' }"
          width="350"
          v-show="onFocus"
        >
          <v-col class="pl-9 pr-n9 py-9 ml-9 mr-n9 my-9" v-model="tmp">
            <v-spacer class="pl-9 pr-n9 py-5 ml-9 mr-n9 my-5"></v-spacer>
            <v-divider/>
            <v-list-item-subtitle class="text-caption grey--text">
              preview
            </v-list-item-subtitle>
            <v-list-item class="justify-center">
              <v-list-item-icon class="mt-n3 ml-6 pl-6">
                <v-list-item-avatar>
    
                  <v-img
                    :src="this.tmp.avatar_url"
                    v-if="this.tmp.avatar_url"
                  ></v-img>
    
                  <v-avatar
                    color="primary"
                    size="40"
                    v-if="!this.tmp.avatar_url && this.tmp.avatar_name "
                  >
                    <span class="white--text text-sm">{{ tmp.avatar_name }}</span>
                  </v-avatar>
    
                  <v-avatar
                    color="primary lighten-1"
                    size="40"
                    v-if="!this.tmp.avatar_url && !this.tmp.avatar_name "
                  >
                    <v-icon
                      class="white--text text-sm"
                    >mdi-account</v-icon>
                  </v-avatar>
    
                </v-list-item-avatar>
              </v-list-item-icon>
            </v-list-item>
    
            <v-list-item class="mt-n7">
              <v-list-item-content>
                <v-list-item-title class="text-h6 text-center">
                  {{ tmp.name }}
                </v-list-item-title>
                <!-- <v-list-item-subtitle class="text-center">
                  
                </v-list-item-subtitle> -->
                <v-list-item class="mt-2 justify-center">
                  <div
                    style="white-space: pre-wrap;"
                    class="text-center text-justify font-weight-thin caption"
                    v-text="this.tmp.introduction"
                  />
                </v-list-item>
              </v-list-item-content>
            </v-list-item>
            <v-divider/>
          </v-col>
        </v-list>
      </transition>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import qs from "qs";

export default {
  data() {
    return {
      users: [],
      currentPage: 1,
      pagingMeta: null, 
      query: {
        userName: "",
      },
      tmp: "",
      onFocus: false,
    };
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    searchFocus() {
      this.$refs.searchUser.focus();
    },
    focus(user) {
      this.tmp = user
      this.onFocus = true
      // console.log(user)
    },
    async fetchUsers() {
      // const res = await axios.get(`/api/users`, {
      //   params: { page: this.currentPage },
      // });
      const searchParams = {
        q: {
          name: this.query.userName,
        },
      };
      const pagingParams = { page: this.currentPage };
      const params = { ...searchParams, ...pagingParams };
      const paramsSerializer = (params) =>
        qs.stringify(params);
      const res = await axios.get(`/api/users`, { params, paramsSerializer });
      this.users = res.data.users;
      this.pagingMeta = res.data.meta;
      this.currentPage = 1;
    },
    paging(pageNumber) {
      this.currentPage = pageNumber;
      this.fetchUsers();
      this.$vuetify.goTo(0);
    },
  },
};
</script>

<style>
/* 表示・非表示アニメーション中 */
.v-enter-active, /* .v-leave-active */ {
  transition: all 200ms;
}

/* 表示アニメーション開始時 ・ 非表示アニメーション後 */
.v-enter, .v-leave-to {
  opacity: 0;
}
</style>