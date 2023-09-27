<template>
	<v-list :style="{ background: 'transparent' }" width="380px">
		<v-row class="text-center text-caption grey--text my-1 mx-5" align="center">
			<v-divider class="px-n9 mx-7" />
			Archives
			<v-divider class="px-n9 mx-7" />
		</v-row>
		<div v-if="this.hackmdArchives !== []">
			<template v-for="archive in hackmdArchives">
				<div :key="archive.short_id">
					<item-hackmd-archive :archiveData="archive" />
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
import itemHackmdArchive from "@/components/listItem/ItemHackmdArchive";

export default {
	props: {
		title: String,
	},
	components: {
		itemHackmdArchive,
	},
	data() {
		return {
			hackmdArchives: [],
			currentPage: 1,
			pagingMeta: null,
			searchQuery: "",
			// onFocus: false,
		};
	},
	watch: {
		searchQuery(newValue) {
			this.searchQuery = newValue;
			this.searchHackmdArchives();
		},
	},
	computed: {
		searchHackmdArchives() {
			this.fetchHackmdArchives();
		},
	},
	created() {
		this.fetchHackmdArchives();
	},
	methods: {
		paging(pageNumber) {
			this.currentPage = pageNumber;
			this.fetchHackmdArchives();
			this.$vuetify.goTo(0);
		},
		async fetchHackmdArchives() {
			const searchParams = {
				q: {
					title: this.title,
				},
			};
			const pagingParams = { page: this.currentPage };
			const params = { ...searchParams, ...pagingParams };
			const paramsSerializer = (params) => qs.stringify(params);
			try {
				const res = await axios.get(`/api/hackmd_archives`, {
					params,
					paramsSerializer,
				});
				if (res) {
					// console.log(res);
					this.hackmdArchives = res.data.hackmd_archives;
					this.pagingMeta = res.data.meta;
					this.currentPage = 1;
				}
			} catch (error) {
				// console.log(error.response.data.error.messages);
				console.log(error.response.data);
				// console.error(error.message);
			}
		},
	},
};
</script>

<style lang="scss" scoped></style>
