<template>
	<div>
		<check-hackmd-note :data="noteData" @delete="deleteNote" />
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
			// archive: null,
		};
	},
	methods: {
		deleteNote(obj) {
			// this.archive = archive;
			this.$emit("delete", obj);
		},
		// outFocus() {
		// 	this.nowFocus = false;
		// },
	},
};
</script>

<style lang="scss" scoped></style>
