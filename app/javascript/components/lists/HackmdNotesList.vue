<template>
	<div :style="{ background: 'transparent' }">
		<template v-for="note in hackmdNotes">
			<div :key="note.short_id">
				<item-hackmd-note :noteData="note" />
			</div>
		</template>
		<template v-if="pagingMeta">
			<div class="text-center pt-7 ml-n9 mr-9">
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
</template>

<script>
import axios from "axios";
import qs from "qs";
import itemHackmdNote from "@/components/listItem/ItemHackmdNote";

export default {
	props: {
		title: String,
	},
	components: {
		itemHackmdNote,
	},
	data() {
		return {
			hackmdNotes: [],
			currentPage: 1,
			pagingMeta: null,
			// onFocus: false,
		};
	},
	computed: {
		searchHackmdNotes() {
			this.fetchHackmdNotes(this.title);
		},
	},
	created() {
		this.fetchHackmdNotes();
	},
	methods: {
		paging(pageNumber) {
			this.currentPage = pageNumber;
			this.fetchMemos();
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
			const res = await axios.get(`/api/hackmd_user_notes`, {
				params,
				paramsSerializer,
			});
			this.hackmdNotes = res.data.hackmd_notes;
			this.pagingMeta = res.data.meta;
			this.currentPage = 1;
		},
	},
};
</script>

<style lang="scss" scoped></style>
