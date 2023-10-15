<template>
	<v-list :style="{ background: 'transparent' }" width="380px">
		<v-row class="text-center text-caption grey--text my-1 mx-5" align="center">
			<v-divider class="px-n9 mx-7" />
			Imported Notes
			<v-divider class="px-n9 mx-7" />
		</v-row>
		<div v-if="this.hackmdNotes !== []">
			<template v-for="note in hackmdNotes">
				<div :key="note.id">
					<item-hackmd-note :noteData="note" @delete="deleteNotes" />
				</div>
			</template>
			<template v-if="pagingMeta">
				<div class="pt-7">
					<v-pagination
						circle
						color="info"
						v-model="pagingMeta.current_page"
						:length="pagingMeta.total_pages"
						@input="paging"
					></v-pagination>
				</div>
			</template>
		</div>
		<div
			v-else
			class="text-center text-caption grey--text mt-1"
			justify="center"
			align="center"
		>
			<v-icon color="grey lighten-1" class="mb-1 mr-1">mdi-robot-dead</v-icon>
			* APIコール上限に達し、データ取得ができませんでした *
		</div>
	</v-list>
</template>

<script>
import axios from "axios";
import qs from "qs";
import itemHackmdNote from "@/components/listItem/ItemHackmdNote";

export default {
	props: {
		title: String,
		notes: Array,
	},
	components: {
		itemHackmdNote,
	},
	data() {
		return {
			hackmdNotes: [],
			currentPage: 1,
			pagingMeta: null,
			// searchQuery: "",
			addNotes: [],
			// onFocus: false,
		};
	},
	watch: {
		// searchQuery(newValue) {
		// 	this.searchQuery = newValue;
		// 	// this.fetchHackmdArchives();
		// },
		notes: {
			handler(newNotes) {
				// addNotesを更新
				this.addNotes = newNotes;
			},
			immediate: true,
		},
		addNotes: {
			handler() {
				// addNotesが変更されたら、要素を追加
				this.addNotesToHackmdNotes();
			},
			deep: true, // addNotes内部の変更も監視
		},
	},
	// computed: {
	//
	// },
	created() {
		this.fetchHackmdNotes();
	},
	methods: {
		paging(pageNumber) {
			this.currentPage = pageNumber;
			this.fetchHackmdNotes();
			this.$vuetify.goTo(0);
		},
		async fetchHackmdNotes() {
			const searchParams = {
				q: {
					title: this.title,
				},
			};
			const pagingParams = { page: this.currentPage };
			const params = { ...searchParams, ...pagingParams };
			const paramsSerializer = (params) => qs.stringify(params);
			try {
				const res = await axios.get(`/api/hackmd_notes`, {
					params,
					paramsSerializer,
				});
				if (res) {
					// console.log(res);
					this.hackmdNotes = res.data.hackmd_notes;
					this.pagingMeta = res.data.meta;
					this.currentPage = 1;
				}
			} catch (error) {
				// console.log(error.response.data.error.messages);
				console.log(error.response.data);
				// console.error(error.message);
			}
		},
		deleteNotes(obj) {
			// 表示データ(data) の配列操作
			// hackmdNotesの配列内 から 同じidのデータを削除
			const delete_note = this.hackmdNotes.findIndex(({ id }) => id === obj.id);
			if (delete_note !== -1) {
				this.hackmdNotes.splice(delete_note, 1);
			}
		},
		addNotesToHackmdNotes() {
			// 配列hackmdNotesの先頭に 配列addNotesの要素を追加
			this.addNotes.forEach((note) => {
				this.hackmdNotes.splice(0, 0, { ...note });
			});
			// spliceの第1引数は追加する位置のインデックス、第2引数は削除する要素の数（消さない場合は0）、第3引数以降は新しい要素

			// 配列hackmdNotesの末尾に 配列addNotesの要素を追加
			// this.addNotes.forEach((archive) => {
			// 	this.$set(this.hackmdNotes, this.hackmdNotees.length, {
			// 		...note,
			// 	});
			// });
		},
	},
};
</script>

<style lang="scss" scoped></style>
