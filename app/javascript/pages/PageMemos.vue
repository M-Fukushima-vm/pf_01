<template>
	<div>
		<memos-tool-bar />
		<memos-list />
	</div>
</template>

<script>
// import axios from "axios";
import memosToolBar from "@/components/toolBar/MemosToolBar";
import memosList from "@/components/lists/MemosList";

export default {
	components: {
		memosToolBar,
		memosList,
	},
	data() {
		return {
			//
		};
	},
	methods: {
		//
	},
};
</script>

<style lang="scss" scoped></style>
