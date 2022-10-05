<template>
  <v-container>
    <v-row v-if="!this.users.length">
      <v-col
        class="text-center text-caption grey--text mb-n5"
      >
        <v-icon
          color="grey lighten-1"
          class="mb-1"
        >mdi-cat</v-icon>
        * 相互フォローのユーザーがいる場合、表示します *
      </v-col>
    </v-row>
    <v-row v-if="this.users.length">
      <v-col>
        <div
          class="text-center text-caption grey--text ml-n3"
        >
          <v-icon
            color="grey lighten-1"
            class="mb-1"
          >mdi-cat</v-icon>
          * 相互フォローのユーザーを表示中 *
        </div>
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
                <v-row class="justify-space-around">
                  <v-spacer/>
                  <v-col>
                    <v-list-item-subtitle class="text-center">
                      <span
                        class="text-body-1"
                      >
                        {{ tmp_followings_count }}
                      </span>
                      followings
                    </v-list-item-subtitle>
                  </v-col>
                  <v-col>
                    <v-list-item-subtitle class="text-center">
                      <span
                        class="text-body-1"
                      >
                        {{ tmp_followers_count }}
                      </span>
                      followers
                    </v-list-item-subtitle>
                  </v-col>
                  <v-spacer/>
                </v-row>
                
                <v-list-item-subtitle
                  class="text-center text-caption grey--text mt-n3"
                  v-if="this.current_user_followings.some( following => following.id === this.tmp.id )"
                >
                  * フォローしています *
                </v-list-item-subtitle>

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

            <v-list-item-group>
              <v-row>
                <v-spacer/>

                <v-col
                  class="justify-center pl-9 mr-n9"
                  v-if="!this.current_user_followings.some( following => following.id === this.tmp.id )"
                >
                  <v-list-item-icon>
                    <v-btn
                      icon
                      color="error darken-1"
                      @click="followUser"
                    >
                      <div>
                        <v-icon>mdi-heart-plus-outline</v-icon>
                        <v-list-item-title class="text-caption">follow</v-list-item-title>
                      </div>
                    </v-btn>
                  </v-list-item-icon>
                </v-col>

                <v-col
                  class="justify-center pl-9 mr-n9"
                  v-if="this.current_user_followings.some( following => following.id === this.tmp.id )"
                >
                  <v-list-item-icon>
                    <v-btn
                      icon
                      color="accent"
                      @click="unfollowUser"
                    >
                      <div>
                        <v-icon>mdi-heart-minus-outline</v-icon>
                        <v-list-item-title class="text-caption">unfollow</v-list-item-title>
                      </div>
                    </v-btn>
                  </v-list-item-icon>
                </v-col>
                
                <v-spacer/>
              </v-row>
            </v-list-item-group>

            <v-list-item-subtitle
              class="text-center text-caption grey--text mt-1 mb-2"
              v-if="this.both_users.length > 0 &&
                    !this.current_user_followings.some( following => following.id === this.tmp.id )"
            >
              * フォロー中の以下のユーザー も フォローしています *
            </v-list-item-subtitle>

            <v-list-item-group
              v-if="this.both_users.length > 0 &&
                    !this.current_user_followings.some( following => following.id === this.tmp.id )"
              class="mx-4"
            >
              <template v-for="both_user in both_users">
                <v-list-item
                  :key="both_user.id"
                  class="pl-9"
                >
                  <v-list-item-avatar>
                    <v-img
                      v-if="both_user.avatar_url"
                      :src="both_user.avatar_url"
                    ></v-img>
                    <v-avatar
                      color="primary"
                      size="40"
                      v-if="!both_user.avatar_url && both_user.avatar_name"
                    >
                      <span class="white--text text-sm">{{ both_user.avatar_name }}</span>
                    </v-avatar>
                    <v-avatar
                      color="primary lighten-1"
                      size="40"
                      v-if="!both_user.avatar_url && !both_user.avatar_name"
                    >
                      <v-icon
                        class="white--text text-sm"
                      >mdi-account</v-icon>
                    </v-avatar>
                  </v-list-item-avatar>

                  <v-list-item-content>
                    <v-list-item-title
                      v-text="both_user.name"
                      class="subtitle-1 text--secondary"
                    ></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </template>
            </v-list-item-group>

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
      tmp_followers: [],
      tmp_followings_count: null,
      tmp_followers_count: null,
      current_user: "",
      current_user_followings: [],
      both_users: [],
      current_user_applicants: [],
    };
  },
  created() {
    this.getCurrentUser();
    this.fetchUsers();
    this.getCurrentUserFollowings();
  },
  methods: {
    searchFocus() {
      this.$refs.searchUser.focus();
    },
    focus(user) {
      this.both_users = []  // 初期化
      // 指定のプロパティを省いた user のサブセット(other) を this.tmp へ返す
        this.tmp = (({ followings, followers, ...other }) => other)(user)
      this.tmp_followings_count = user.followings.length
      this.tmp_followers_count = user.followers.length
      this.tmp_followers = user.followers
      // 以下の共通ユーザーを抽出
        // プレビューユーザーのフォロワー から current_userのフォローしているユーザー とマッチするもの 
        const both_users = this.tmp_followers.filter(x => this.current_user_followings.filter
                            (
                              y => y.id === x.id && y.name === x.name
                            ).length > 0)
      // 抽出した共通ユーザーからランダム抽出
        const copy = [...both_users] // コピーの配列
        // 共通ユーザーか3より多い場合は 3ユーザー抽出
          if (copy.length > 3) {
            const selected = [...Array(3)].map(() => {
              return copy.splice(Math.floor(Math.random() * copy.length), 1)[0]
            });
            this.both_users = selected
        // 1以上 3未満の場合は 1ユーザー抽出
          } else if (copy.length > 0) {
            const selected = [...Array(1)].map(() => {
              return copy.splice(Math.floor(Math.random() * copy.length), 1)[0]
            });
            this.both_users = selected
          } else {}
      this.onFocus = true
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
      const res = await axios.get(`/api/users/${this.current_user.id}/mates`, { params, paramsSerializer });
      this.users = res.data.users;
      this.pagingMeta = res.data.meta;
      this.currentPage = 1;
    },
    paging(pageNumber) {
      this.currentPage = pageNumber;
      this.fetchUsers();
      this.$vuetify.goTo(0);
    },
    async followUser(){
      // post リクエストの送信
      const targetUser = {
        target: {
          id: this.tmp.id
        }
      };
      const params = { ...targetUser };
      await axios.post(`/api/relationships`, params );

      // 表示データ(data) の配列操作
        // current_user_followingsの配列 に追加
        const addFollowing = {
          id: this.tmp.id,
          name: this.tmp.name
        }
        this.current_user_followings.push(addFollowing)

        // プレビューのフォロワー数に current_user 分を追加(+1)
        this.tmp_followers.push(this.current_user)
        this.tmp_followers_count ++;

        // リスト内の"プレビューユーザーのフォロワー"に current_user を追加
        const index_users = this.users.findIndex(({id}) => id === this.tmp.id)
        const user = this.users[index_users]
        const index_u_followers = user.followers
                                        .findIndex(({id}) => id === this.current_user.id)
        if (index_u_followers === -1) {
          user.followers.push(addFollowing)
        }
    },
    async unfollowUser(){
      // delete リクエストの送信
      await axios.delete(`/api/relationships/${this.tmp.id}`);

      // 表示データ(data) の配列操作
        // current_user_followingsの配列内 から プレビューのユーザーを削除
        const index_cu_following = this.current_user_followings
                                    .findIndex(({id}) => id === this.tmp.id)
        if (index_cu_following !== -1) {
          this.current_user_followings.splice(index_cu_following, 1)
        }

        // プレビューのフォロワーから current_user を削除
        const index_t_followers = this.tmp_followers
                                    .findIndex(({id}) => id === this.current_user.id)
        if (index_t_followers !== -1) {
          this.tmp_followers.splice(index_t_followers, 1)
          this.tmp_followers_count --;
        }

        // リスト内の"プレビューユーザーのフォロワー"から current_user を削除
        const index_users = this.users.findIndex(({id}) => id === this.tmp.id)
        const user = this.users[index_users]
        const index_u_followers = user.followers
                                        .findIndex(({id}) => id === this.current_user.id)
        if (index_u_followers !== -1) {
          user.followers.splice(index_u_followers, 1)
        }
    },
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
