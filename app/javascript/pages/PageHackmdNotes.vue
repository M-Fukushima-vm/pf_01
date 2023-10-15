<template>
	<div>
		<memos-tool-bar />
		<v-row class="text-center text-caption grey--text mt-1">
			<v-col>
				<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
				* HackMD の情報一覧を表示しています *
			</v-col>
		</v-row>
		<v-row justify="center" class="ml-n12">
			<v-spacer />
			<v-card outlined color="transparent" class="justify-center">
				<v-text-field
					class="pt-n3 mt-n4 pb-3"
					prepend-inner-icon="mdi-magnify"
					persistent-hint
					hint="入力内容で絞り込み表示 (フォーカスは shift + space )"
					persistent-placeholder
					placeholder="title"
					v-model="query.title"
					@input="callFetchData"
					v-shortkey.once="['shift', 'space']"
					@shortkey.native="searchFocus"
					ref="searchHackmd"
				></v-text-field>
			</v-card>
			<!-- <v-spacer class="pr-9" /> -->
			<v-tooltip bottom>
				<template v-slot:activator="{ on }">
					<v-btn
						icon
						class="ml-7 mr-1 mt-3"
						align="center"
						v-on="on"
						@click="createArchives"
					>
						<div>
							<v-icon color="grey darken-1"> mdi-arrow-collapse-down </v-icon>
							<v-list-item-title class="text-caption">
								Archive
							</v-list-item-title>
						</div>
					</v-btn>
				</template>
				<div class="text-caption text-center">
					( APIを 1 コールして )
					<span class="font-weight-bold">閲覧権限：全員</span>
					に設定された<br />
					HackMDデータの概要 をアーカイブとして保存します
				</div>
			</v-tooltip>
			<v-col>
				<hackmd-info-button />
				<!-- <v-spacer class="mr-2" /> -->
			</v-col>
			<!-- <v-spacer class="mr-2" /> -->
		</v-row>
		<v-row>
			<v-col justify="center" class="px-4">
				<hackmd-notes-list
					ref="hackmdNotesList"
					:title="query.title"
					:notes="importedData.hackmd_notes"
				/>
			</v-col>
			<v-col justify="center" class="px-4">
				<hackmd-archives-list
					ref="hackmdArchivesList"
					:title="query.title"
					:archives="importedData.hackmd_archives"
				/>
			</v-col>
			<v-spacer />
		</v-row>
	</div>
</template>

<script>
import axios from "axios";
import memosToolBar from "@/components/toolBar/MemosToolBar";
import hackmdInfoButton from "@/components/floatingButton/HackmdInfoButton";
import hackmdNotesList from "@/components/lists/HackmdNotesList";
import hackmdArchivesList from "@/components/lists/HackmdArchivesList";

export default {
	components: {
		memosToolBar,
		hackmdInfoButton,
		hackmdArchivesList,
		hackmdNotesList,
	},
	data() {
		return {
			query: {
				title: "",
				// noteTitle: "",
			},
			importedData: {
				hackmd_archives: [],
				hackmd_notes: [],
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
		async createArchives() {
			try {
				const res = await axios.post(`/api/hackmd_archives`);
				this.importedData.hackmd_archives = res.data;
				location.reload();
			} catch (error) {
				console.log(error.response.data);
				const statusCode = error.response.status;
				const errorDetails = error.response.data.message;
				const errorMessages = error.response.data.errors;
				alert(`${statusCode} : ${errorDetails}\n${errorMessages}`);
			}
		},
		callFetchData() {
			this.$nextTick(() => this.$refs.hackmdNotesList.fetchHackmdNotes());
			this.$nextTick(() => this.$refs.hackmdArchivesList.fetchHackmdArchives());
		},
	},
};
</script>

<style lang="scss" scoped></style>
