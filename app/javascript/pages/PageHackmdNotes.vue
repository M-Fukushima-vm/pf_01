<template>
	<div>
		<memos-tool-bar />
		<v-row class="text-center text-caption grey--text mt-1">
			<v-col>
				<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
				* HackMD の情報一覧を表示しています *
			</v-col>
		</v-row>
		<v-row class="justify-center">
			<v-card outlined color="transparent" class="justify-center">
				<v-text-field
					class="pt-n3 mt-n4 pb-3"
					prepend-inner-icon="mdi-magnify"
					persistent-hint
					hint="入力内容で絞り込み表示 (フォーカスは shift + space )"
					persistent-placeholder
					placeholder="note title:"
					v-model="query.noteTitle"
					@input=""
					v-shortkey.once="['shift', 'space']"
					@shortkey.native="searchFocus"
					ref="searchHackmd"
				></v-text-field>
			</v-card>
		</v-row>
		<v-row>
			<v-col>
				<!-- <import-hackmd-notes-list /> -->
			</v-col>
			<v-col cols="5" justify="center">
				<hackmd-notes-list :title="query.noteTitle" />
			</v-col>
		</v-row>
	</div>
</template>

<script>
// import axios from "axios";
import memosToolBar from "@/components/toolBar/MemosToolBar";
import hackmdNotesList from "@/components/lists/HackmdNotesList";

export default {
	components: {
		memosToolBar,
		hackmdNotesList,
	},
	data() {
		return {
			query: {
				noteTitle: "",
			},
		};
	},
	created() {
		this.$nextTick(() => this.searchFocus());
	},
	methods: {
		searchFocus() {
			this.$refs.searchHackmd.focus();
		},
	},
};
</script>

<style lang="scss" scoped></style>
