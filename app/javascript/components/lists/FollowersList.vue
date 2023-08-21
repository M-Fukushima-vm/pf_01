<template>
	<v-container>
		<v-row
			v-if="!this.users.length"
			class="text-center text-caption grey--text"
		>
			<v-col>
				<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
				* あなたをフォロー中の 未フォローユーザー がいる場合、表示します *
			</v-col>
		</v-row>
		<v-row v-if="this.users.length" class="text-center text-caption grey--text">
			<v-col>
				<div>
					<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
					* あなたをフォロー中の 未フォローユーザー を表示中 *
				</div>
			</v-col>
		</v-row>
		<v-row>
			<v-col>
				<v-text-field
					class="pt-n3 mt-n3 pb-3"
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
					v-if="this.users.length"
					two-line
					:style="{ background: 'transparent' }"
					width="300"
				>
					<template v-for="user in users">
						<v-list-item
							:key="user.id"
							link
							@focus="focus(user), seenFollower(user)"
						>
							<v-badge
								bordered
								overlap
								left
								offset-x="25"
								offset-y="25"
								color="error"
								dot
								v-if="
									(followers.length === 0 && uncheck_followers.length === 0) ||
									uncheck_followers.some((follower) => follower.id === user.id)
								"
								v-model="badge_on"
							>
								<v-list-item-avatar>
									<v-img v-if="user.avatar_url" :src="user.avatar_url"></v-img>
									<v-avatar
										color="primary"
										size="40"
										v-if="!user.avatar_url && user.avatar_name"
									>
										<span class="white--text text-sm">{{
											user.avatar_name
										}}</span>
									</v-avatar>
									<v-avatar
										color="primary lighten-1"
										size="40"
										v-if="!user.avatar_url && !user.avatar_name"
									>
										<v-icon class="white--text text-sm">mdi-account</v-icon>
									</v-avatar>
								</v-list-item-avatar>
							</v-badge>

							<v-list-item-avatar
								class="ml-4"
								v-if="
									followers.length > 0 &&
									!uncheck_followers.some((follower) => follower.id === user.id)
								"
							>
								<v-img v-if="user.avatar_url" :src="user.avatar_url"></v-img>
								<v-avatar
									color="primary"
									size="40"
									v-if="!user.avatar_url && user.avatar_name"
								>
									<span class="white--text text-sm">{{
										user.avatar_name
									}}</span>
								</v-avatar>
								<v-avatar
									color="primary lighten-1"
									size="40"
									v-if="!user.avatar_url && !user.avatar_name"
								>
									<v-icon class="white--text text-sm">mdi-account</v-icon>
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
						<v-divider />
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
					<v-col class="pl-9 pr-n9 py-6 ml-9 mr-n9 my-6" v-model="tmp">
						<v-spacer class="pl-9 pr-n9 py-5 ml-9 mr-n9 my-5"></v-spacer>
						<v-divider />
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
										v-if="!this.tmp.avatar_url && this.tmp.avatar_name"
									>
										<span class="white--text text-sm">{{
											tmp.avatar_name
										}}</span>
									</v-avatar>

									<v-avatar
										color="primary lighten-1"
										size="40"
										v-if="!this.tmp.avatar_url && !this.tmp.avatar_name"
									>
										<v-icon class="white--text text-sm">mdi-account</v-icon>
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
									<v-spacer />
									<v-col>
										<v-list-item-subtitle class="text-center">
											<span class="text-body-1">
												{{ tmp_followings_count }}
											</span>
											followings
										</v-list-item-subtitle>
									</v-col>
									<v-col>
										<v-list-item-subtitle class="text-center">
											<span class="text-body-1">
												{{ tmp_followers_count }}
											</span>
											followers
										</v-list-item-subtitle>
									</v-col>
									<v-spacer />
								</v-row>

								<v-list-item-subtitle
									class="text-center text-caption grey--text mt-n3"
									v-if="
										this.followings.some(
											(following) => following.id === this.tmp.id
										)
									"
								>
									* フォローしています *
								</v-list-item-subtitle>

								<v-list-item class="mt-2 justify-center">
									<div
										style="white-space: pre-wrap"
										class="text-center text-justify font-weight-thin caption"
										v-text="this.tmp.introduction"
									/>
								</v-list-item>
							</v-list-item-content>
						</v-list-item>

						<v-list-item-subtitle
							class="text-center text-caption grey--text mt-n3"
							v-if="
								this.blockings.some(
									(blocking_user) => blocking_user.id === this.tmp.id
								) ||
								this.mutings.some((mute_user) => mute_user.id === this.tmp.id)
							"
						>
							* 次回以降、非表示 にします *
						</v-list-item-subtitle>

						<v-divider />

						<v-list-item-group>
							<v-row class="ml-n9">
								<v-spacer />

								<v-col
									class="justify-center pl-9 mr-n9"
									v-if="
										!this.followings.some(
											(following) => following.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="error darken-1" @click="followUser">
											<div>
												<v-icon>mdi-heart-plus-outline</v-icon>
												<v-list-item-title class="text-caption"
													>Re: follow</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-col
									class="justify-center pl-9 mr-n9"
									v-if="
										this.followings.some(
											(following) => following.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="accent" @click="unfollowUser">
											<div>
												<v-icon>mdi-heart-minus-outline</v-icon>
												<v-list-item-title class="text-caption"
													>unfollow</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-col
									class="justify-center pl-9 mr-n9"
									v-if="
										!this.mutings.some(
											(muting_user) => muting_user.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="primary darken-1" @click="muteUser">
											<div>
												<v-icon>mdi-volume-off</v-icon>
												<v-list-item-title class="text-caption"
													>Mute</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-col
									class="justify-center pl-9 mr-n9"
									v-if="
										this.mutings.some(
											(muting_user) => muting_user.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="primary darken-1" @click="unmuteUser">
											<div>
												<v-icon>mdi-volume-low</v-icon>
												<v-list-item-title class="text-caption"
													>Unmute</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-col
									class="justify-center pl-7 mr-n7"
									v-if="
										!this.blockings.some(
											(blocking_user) => blocking_user.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="accent" @click="blockUser">
											<div>
												<v-icon>mdi-cancel</v-icon>
												<v-list-item-title class="text-caption"
													>Block</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-col
									class="justify-center pl-7 mr-n7"
									v-if="
										this.blockings.some(
											(blocking_user) => blocking_user.id === this.tmp.id
										)
									"
								>
									<v-list-item-icon>
										<v-btn icon color="primary darken-1" @click="unblockUser">
											<div>
												<v-icon>mdi-stop-circle-outline</v-icon>
												<v-list-item-title class="text-caption"
													>Unblock</v-list-item-title
												>
											</div>
										</v-btn>
									</v-list-item-icon>
								</v-col>

								<v-spacer />
							</v-row>
						</v-list-item-group>

						<v-list-item-subtitle
							class="text-center text-caption grey--text mt-1 mb-2"
							v-if="
								this.both_users.length > 0 &&
								!this.followings.some(
									(following) => following.id === this.tmp.id
								)
							"
						>
							* フォロー中の以下のユーザー も フォローしています *
						</v-list-item-subtitle>

						<v-list-item-group
							v-if="
								this.both_users.length > 0 &&
								!this.followings.some(
									(following) => following.id === this.tmp.id
								)
							"
							class="mx-4"
						>
							<template v-for="both_user in both_users">
								<v-list-item :key="both_user.id" class="pl-9">
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
											<span class="white--text text-sm">{{
												both_user.avatar_name
											}}</span>
										</v-avatar>
										<v-avatar
											color="primary lighten-1"
											size="40"
											v-if="!both_user.avatar_url && !both_user.avatar_name"
										>
											<v-icon class="white--text text-sm">mdi-account</v-icon>
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
	props: {
		current_user: {},
		followings: {},
		mutings: {},
		blockings: {},
		seen_followers: {},
		followers: {},
		uncheck_followers: {},
	},
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
			both_users: [],
			badge_on: false,
		};
	},
	created() {
		// this.checkNewFollowers();
		this.fetchUsers();
	},
	methods: {
		searchFocus() {
			this.$refs.searchUser.focus();
		},
		focus(user) {
			this.both_users = []; // 初期化
			// 指定のプロパティを省いた user のサブセット(other) を this.tmp へ返す
			this.tmp = (({ followings, followers, ...other }) => other)(user);
			this.tmp_followings_count = user.followings.length;
			this.tmp_followers_count = user.followers.length;
			this.tmp_followers = user.followers;
			// 以下の共通ユーザーを抽出
			// プレビューユーザーのフォロワー から current_userのフォローしているユーザー とマッチするもの
			const both_users = this.tmp_followers.filter(
				(x) =>
					this.followings.filter((y) => y.id === x.id && y.name === x.name)
						.length > 0
			);
			// 抽出した共通ユーザーからランダム抽出
			const copy = [...both_users]; // コピーの配列
			// 共通ユーザーか3より多い場合は 3ユーザー抽出
			if (copy.length > 3) {
				const selected = [...Array(3)].map(() => {
					return copy.splice(Math.floor(Math.random() * copy.length), 1)[0];
				});
				this.both_users = selected;
				// 1以上 3未満の場合は 1ユーザー抽出
			} else if (copy.length > 0) {
				const selected = [...Array(1)].map(() => {
					return copy.splice(Math.floor(Math.random() * copy.length), 1)[0];
				});
				this.both_users = selected;
			} else {
			}
			this.onFocus = true;
		},
		paging(pageNumber) {
			this.currentPage = pageNumber;
			this.fetchUsers();
			this.$vuetify.goTo(0);
		},
		async followUser() {
			// post リクエストの送信
			const targetUser = {
				target: {
					id: this.tmp.id,
				},
			};
			const params = { ...targetUser };
			await axios.post(`/api/relationships`, params);

			// 表示データ(data) の配列操作
			// followingsの配列 に追加
			const addFollowing = {
				id: this.tmp.id,
				name: this.tmp.name,
			};
			this.followings.push(addFollowing);

			// プレビューのフォロワー数に current_user 分を追加(+1)
			this.tmp_followers.push(this.current_user);
			this.tmp_followers_count++;

			// リスト内の"プレビューユーザーのフォロワー"に current_user を追加
			const index_users = this.users.findIndex(({ id }) => id === this.tmp.id);
			const user = this.users[index_users];
			const index_u_followers = user.followers.findIndex(
				({ id }) => id === this.current_user.id
			);
			if (index_u_followers === -1) {
				user.followers.push(addFollowing);
			}

			// blockingsの配列内の プレビューと一致するid を抽出
			const index_cu_blockings = this.blockings.findIndex(
				({ id }) => id === this.tmp.id
			);
			// 一致があったら unblockUser() を実行
			if (index_cu_blockings !== -1) {
				this.$nextTick(() => this.unblockUser());
			}
			this.onFocus = false;
			this.fetchUsers();
			this.checkAgain();
		},
		async unfollowUser() {
			// delete リクエストの送信
			await axios.delete(`/api/relationships/${this.tmp.id}`);

			// 表示データ(data) の配列操作
			// followingsの配列内 から プレビューのユーザーを削除
			const index_cu_following = this.followings.findIndex(
				({ id }) => id === this.tmp.id
			);
			if (index_cu_following !== -1) {
				this.followings.splice(index_cu_following, 1);
			}

			// プレビューのフォロワーから current_user を削除
			const index_t_followers = this.tmp_followers.findIndex(
				({ id }) => id === this.current_user.id
			);
			if (index_t_followers !== -1) {
				this.tmp_followers.splice(index_t_followers, 1);
				this.tmp_followers_count--;
			}

			// リスト内の"プレビューユーザーのフォロワー"から current_user を削除
			const index_users = this.users.findIndex(({ id }) => id === this.tmp.id);
			const user = this.users[index_users];
			const index_u_followers = user.followers.findIndex(
				({ id }) => id === this.current_user.id
			);
			if (index_u_followers !== -1) {
				user.followers.splice(index_u_followers, 1);
			}
			this.checkAgain();
		},
		async fetchUsers() {
			this.users = this.followers;
			const searchParams = {
				q: {
					name: this.query.userName,
				},
			};
			const pagingParams = { page: this.currentPage };
			const params = { ...searchParams, ...pagingParams };
			const paramsSerializer = (params) => qs.stringify(params);
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(
				`/api/users/${this.current_user.id}/followers`,
				{ params, paramsSerializer }
			);
			this.users = res.data.users;
			// console.log(res.data.users)
			this.pagingMeta = res.data.meta;
			this.currentPage = 1;
			await this.$nextTick(() => this.searchFocus());
			// this.$nextTick(() => this.badgeOn());
			this.badgeOn();
		},
		async muteUser() {
			// post リクエストの送信
			const targetUser = {
				target: {
					id: this.tmp.id,
				},
			};
			const params = { ...targetUser };
			await axios.post(`/api/mute_users`, params);

			// 表示データ(data) の配列操作
			// followingsの配列 に追加
			const addMuting = {
				id: this.tmp.id,
				name: this.tmp.name,
			};
			this.mutings.push(addMuting);
			this.checkAgain();
		},
		async unmuteUser() {
			// delete リクエストの送信
			await axios.delete(`/api/mute_users/${this.tmp.id}`);

			// 表示データ(data) の配列操作
			// mutingsの配列内 から プレビューのユーザーを削除
			const index_cu_mutings = this.mutings.findIndex(
				({ id }) => id === this.tmp.id
			);
			if (index_cu_mutings !== -1) {
				this.mutings.splice(index_cu_mutings, 1);
			}
			this.checkAgain();
		},
		async blockUser() {
			// post リクエストの送信
			const targetUser = {
				target: {
					id: this.tmp.id,
				},
			};
			const params = { ...targetUser };
			await axios.post(`/api/block_users`, params);

			// 表示データ(data) の配列操作
			// blockingsの配列 に追加
			const addBlocking = {
				id: this.tmp.id,
				name: this.tmp.name,
			};
			this.blockings.push(addBlocking);

			// followingsの配列内の プレビューと一致するid を抽出
			const index_cu_following = this.followings.findIndex(
				({ id }) => id === this.tmp.id
			);
			// 一致があったら unfollowUser() を実行
			if (index_cu_following !== -1) {
				this.$nextTick(() => this.unfollowUser());
			}

			// mutingsの配列内の プレビューと一致するid を抽出
			const index_cu_mutings = this.mutings.findIndex(
				({ id }) => id === this.tmp.id
			);
			// 一致があったら unmuteUser() を実行
			if (index_cu_mutings !== -1) {
				this.$nextTick(() => this.unmuteUser());
			}
			this.checkAgain();
		},
		async unblockUser() {
			// delete リクエストの送信
			await axios.delete(`/api/block_users/${this.tmp.id}`);

			// 表示データ(data) の配列操作
			// blockingsの配列内 から プレビューのユーザーを削除
			const index_cu_blockings = this.blockings.findIndex(
				({ id }) => id === this.tmp.id
			);
			if (index_cu_blockings !== -1) {
				this.blockings.splice(index_cu_blockings, 1);
			}
			this.checkAgain();
		},
		async seenFollower(user) {
			// post リクエストの送信
			const targetUser = {
				target: {
					id: user.id,
				},
			};
			const params = { ...targetUser };
			// 表示データ(data) の配列操作
			const addSeenFollower = {
				id: user.id,
			};
			const seen_array = [addSeenFollower];
			// data() に seen_followers: [] を 新設するとして
			// ↑ の seen_arrayのid に一致するid を result へ格納
			const result = this.seen_followers.filter(
				(x) => seen_array.filter((y) => y.id === x.id).length > 0
			);
			// result の中身( 既にチェック済のフォロワー )がなければ追加
			if (result.length === 0) {
				axios.post(`/api/seen_followers`, params);
				this.seen_followers.push(addSeenFollower);
			} else {
			}
			this.checkAgain();
		},
		badgeOn() {
			this.badge_on = true;
		},
		checkAgain() {
			const item = this.tmp;
			this.$emit("checkAgain", item);
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
.v-enter,
.v-leave-to {
	opacity: 0;
}
</style>
