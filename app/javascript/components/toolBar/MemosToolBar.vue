<template>
	<v-app-bar color="transparent" app flat dense>
		<v-list-item>
			<v-spacer />
			<v-list-item-icon>
				<new-memo-button />
			</v-list-item-icon>
			<v-list-item-icon v-if="$store.getters['auth/reference_currentUser']">
				<v-btn to="/memos" icon class="mx-4 mt-1" align="center">
					<div>
						<v-icon>mdi-file-document-outline</v-icon>
						<v-list-item-title class="text-caption">HackMD</v-list-item-title>
					</div>
				</v-btn>
			</v-list-item-icon>
			<v-list-item-icon v-if="$store.getters['auth/reference_currentUser']">
				<v-btn to="/hackmd_notes" icon class="mx-4 mt-1" align="center">
					<div>
						<v-icon>mdi-link-variant-plus</v-icon>
						<v-list-item-title class="text-caption">HackMD</v-list-item-title>
					</div>
				</v-btn>
			</v-list-item-icon>
			<v-list-item-icon class="ml-12" v-if="$store.getters['auth/currentUser']">
				<hackmd-account />
			</v-list-item-icon>
			<v-spacer />
		</v-list-item>
	</v-app-bar>
</template>

<script>
// import axios from "axios";
// import qs from "qs";
import newMemoButton from "@/components/modal/NewMemoModal";
import HackmdAccount from "@/components/modal/HackmdAccount";

export default {
	// props: {
	//
	// },
	components: {
		newMemoButton,
		HackmdAccount,
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
