<template>
	<div>
		<v-row align="center" no-gutters>
			<v-col>
				<check-hackmd-archive :data="archiveData" />
			</v-col>
			<!-- <v-btn icon class="mx-4 mt-1" @click="">
				<div>
					<v-icon color="grey darken-1" small class="mb-n1">
						mdi-arrow-collapse-down
					</v-icon>
					<v-list-item-title class="text-caption">Import</v-list-item-title>
				</div>
			</v-btn> -->
		</v-row>
		<v-divider />
	</div>
</template>

<script>
import checkHackmdArchive from "@/components/modal/CheckHackmdArchive";

export default {
	props: {
		archiveData: {},
	},
	components: {
		checkHackmdArchive,
	},
	data() {
		return {
			// nowFocus: false,
		};
	},
	methods: {
		// onFocus() {
		// 	this.nowFocus = true;
		// },
		// outFocus() {
		// 	this.nowFocus = false;
		// },
	},
};
</script>

<style lang="scss" scoped></style>
