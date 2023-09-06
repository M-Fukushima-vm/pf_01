<template>
	<v-app-bar color="transparent" app flat dense>
		<v-list-item>
			<v-spacer></v-spacer>
			<v-list-item-icon>
				<new-memo-button />
				<!-- <v-btn icon class="mx-4 mt-1" @click="toggleModal">
					<div>
						<v-icon color="grey darken-1"> mdi-file-edit-outline </v-icon>
						<v-list-item-title class="text-caption">New</v-list-item-title>
					</div>
				</v-btn> -->

				<!-- <v-btn link to="/followers" icon class="mx-4 mt-1">
					<div>
						<v-badge
							bordered
							overlap
							bottom
							left
							offset-x="30"
							offset-y="30"
							color="error"
							:content="uncheck_followers.length"
							:value="uncheck_followers.length"
						>
							<v-icon class="ml-6" color="grey darken-1">
								mdi-account-music
							</v-icon>
						</v-badge>
						<v-list-item-title class="text-caption">
							Followers
						</v-list-item-title>
					</div>
				</v-btn>

				<v-btn link to="/users" icon class="mx-4 mt-1">
					<div>
						<v-icon class="ml-3" color="grey darken-1">
							mdi-account-search
						</v-icon>
						<v-list-item-title class="text-caption">Search</v-list-item-title>
					</div>
				</v-btn>

				<v-btn link to="/mute_users" icon class="mx-3 mt-1">
					<div>
						<v-icon class="ml-1">mdi-account-minus</v-icon>
						<v-list-item-title class="text-caption">Mute</v-list-item-title>
					</div>
				</v-btn>

				<v-btn link to="/block_users" icon class="mx-4 mt-1">
					<div>
						<v-icon class="ml-2" color="grey darken-1">
							mdi-account-cancel
						</v-icon>
						<v-list-item-title class="text-caption">Block</v-list-item-title>
					</div>
				</v-btn> -->
			</v-list-item-icon>
			<v-spacer></v-spacer>
		</v-list-item>
	</v-app-bar>
</template>

<script>
// import axios from "axios";
// import qs from "qs";
import newMemoButton from "@/components/modal/NewMemoModal";

export default {
	// props: {
	//
	// },
	components: {
		newMemoButton,
	},
	// data() {
	// 	return {
	//
	// 	};
	// },
	// computed: {
	//
	// },
	// created() {
	//
	// },
	methods: {
		//
	},
};
</script>

<style lang="scss" scoped>
.v-btn {
	text-decoration: none;
}
</style>
