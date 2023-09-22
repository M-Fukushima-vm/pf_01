<template>
	<div>
		<v-row align="center" no-gutters>
			<v-col cols="9">
				<check-hackmd-note :data="noteData" />
			</v-col>
			<v-col cols="1">
				<v-btn icon class="mx-4 mt-1" @click="">
					<div>
						<v-icon color="grey darken-1" small class="mb-n1">
							mdi-arrow-collapse-down
						</v-icon>
						<v-list-item-title class="text-caption">Import</v-list-item-title>
					</div>
				</v-btn>
			</v-col>
		</v-row>
	</div>
</template>

<script>
import checkHackmdNote from "@/components/modal/CheckHackmdNote";

export default {
	props: {
		noteData: {},
	},
	components: {
		checkHackmdNote,
	},
	data() {
		return {
			nowFocus: false,
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
