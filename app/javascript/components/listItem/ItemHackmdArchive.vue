<template>
	<div>
		<check-hackmd-archive
			:data="archiveData"
			@delete="deleteArchive"
			@update=""
		/>
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
			// archive: null,
		};
	},
	methods: {
		deleteArchive(obj) {
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
