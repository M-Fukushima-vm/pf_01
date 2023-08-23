<template>
	<div>
		<users-tool-bar
			:followers="current_user_followers"
			:uncheck_followers="uncheck_followers"
		/>
		<v-row>
			<v-col>
				<mute-users-list
					:current_user="current_user"
					:followings="current_user_followings"
					:mutings="current_user_mutings"
					:blockings="current_user_blockings"
				/>
			</v-col>
		</v-row>
	</div>
</template>

<script>
import axios from "axios";
import usersToolBar from "@/components/toolBar/UsersToolBar";
import muteUsersList from "@/components/lists/MuteUsersList";

export default {
	components: {
		usersToolBar,
		muteUsersList,
	},
	data() {
		return {
			current_user: "",
			current_user_followings: [],
			current_user_seen_followers: [],
			current_user_followers: [],
			uncheck_followers: [],
			current_user_mutings: [],
			current_user_blockings: [],
		};
	},
	async created() {
		// 読み込みの確認用
		// console.log(this.$children)
		this.getCurrentUser();
		this.getCurrentUserFollowings();
		this.getCurrentUserSeenFollowers();
		await this.getCurrentUserFollowers();
		this.unCheckFollowers();
		this.getCurrentUserMutings();
		this.getCurrentUserBlockings();
	},
	methods: {
		getCurrentUser() {
			const current_user_data =
				this.$store.getters["auth/reference_currentUser"];
			// console.log(JSON.stringify(current_user_data, null, 2))
			const new_current_user = {
				id: current_user_data.id,
				name: current_user_data.name,
			};
			this.current_user = new_current_user;
			// console.log(JSON.stringify(this.current_user, null, 2))
		},
		async getCurrentUserFollowings() {
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(`/api/users/${current_user.id}/followings`);
			this.current_user_followings = res.data.users;
			// console.log(this.current_user_followings)
		},
		async getCurrentUserSeenFollowers() {
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(
				`/api/users/${current_user.id}/seen_followers`
			);
			// console.log("seen" + JSON.stringify(res.data.users.length, null, 2));
			this.current_user_seen_followers = res.data.users;
			// console.log(this.current_user_seen_followers);
			// console.log(JSON.stringify(this.current_user_seen_followers, null, 2));
		},
		async getCurrentUserFollowers() {
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(`/api/users/${current_user.id}/followers`);
			this.current_user_followers = res.data.users;
			// console.log(this.current_user_followers)
			// console.log(JSON.stringify(this.current_user_followers, null, 2));
		},
		unCheckFollowers() {
			// フォロワーから見たことあるフォロワーリストを除外
			const unCheck_followers = this.current_user_followers.filter(
				(elem) => !this.current_user_seen_followers.find((x) => x.id == elem.id)
			);
			// console.log(unCheck_followers);
			this.uncheck_followers = unCheck_followers;
			// console.log(this.uncheck_followers);
		},
		async getCurrentUserMutings() {
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(`/api/users/${current_user.id}/muting_users`);
			this.current_user_mutings = res.data.users;
			// console.log(this.current_user_mutings)
		},
		async getCurrentUserBlockings() {
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(
				`/api/users/${current_user.id}/blocking_users`
			);
			this.current_user_blockings = res.data.users;
			// console.log(this.current_user_blockings)
		},
	},
};
</script>

<style lang="scss" scoped></style>
