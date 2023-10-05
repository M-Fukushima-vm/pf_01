<template>
	<div>
		<v-row align="center" no-gutters>
			<v-col>
				<check-memo-modal :data="memoData" />
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
		<!-- <v-divider /> -->
	</div>
</template>

<script>
import checkMemoModal from "@/components/modal/CheckMemoModal";

export default {
	props: {
		memoData: {},
	},
	components: {
		checkMemoModal,
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
