<template>
	<v-container>
		<v-row
			v-if="!this.memos.length"
			class="text-center text-caption grey--text"
		>
			<v-col>
				<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
				* メモ一覧を取得・表示します *
			</v-col>
		</v-row>
		<v-row v-if="this.memos.length" class="text-center text-caption grey--text">
			<v-col>
				<div>
					<v-icon color="grey lighten-1" class="mb-1">mdi-cat</v-icon>
					* メモ一覧を表示中 *
				</div>
			</v-col>
		</v-row>
		<v-row>
			<v-col>
				<v-text-field
					class="pt-n3 mt-n3 pb-3"
					prepend-inner-icon="mdi-magnify"
					persistent-hint
					hint="入力内容で絞り込み表示 (フォーカスは shift + space )"
					persistent-placeholder
					placeholder="memo title"
					v-model="query.memoTitle"
					@input="fetchMemos"
					v-shortkey.once="['shift', 'space']"
					@shortkey.native="searchFocus"
					ref="searchMemo"
				></v-text-field>
				<v-list
					v-if="this.memos.length"
					two-line
					:style="{ background: 'transparent' }"
					width="300"
				>
					<template v-for="memo in memos">
						<v-list-item :key="memo.id" link three-line>
							<v-list-item-content>
								<v-row align="center">
									<v-col>
										<v-list-item-title
											v-text="memo.title"
											class="subtitle-1 text--secondary"
										></v-list-item-title>
										<v-list-item-subtitle
											v-text="memo.intro"
											class="caption"
										></v-list-item-subtitle>
									</v-col>
									<edit-memo-modal :memo="memo" />
								</v-row>
							</v-list-item-content>
						</v-list-item>
						<v-divider />
					</template>
				</v-list>

				<template v-if="pagingMeta">
					<div class="text-center pt-7">
						<v-pagination
							circle
							color="info"
							v-model="pagingMeta.current_page"
							:length="pagingMeta.total_pages"
							@input="paging"
						></v-pagination>
					</div>
				</template>
			</v-col>
		</v-row>
	</v-container>
</template>

<script>
import axios from "axios";
import qs from "qs";
import editMemoModal from "@/components/modal/EditMemoModal";

export default {
	components: {
		editMemoModal,
	},
	// props: {
	//
	// },
	data() {
		return {
			memos: [],
			currentPage: 1,
			pagingMeta: null,
			query: {
				memoTitle: "",
			},
			// onFocus: false,
		};
	},
	created() {
		this.fetchMemos();
	},
	methods: {
		searchFocus() {
			this.$refs.searchMemo.focus();
		},
		// focus(memo) {
		// 	this.onFocus = true;
		// },
		paging(pageNumber) {
			this.currentPage = pageNumber;
			this.fetchMemos();
			this.$vuetify.goTo(0);
		},
		async fetchMemos() {
			const searchParams = {
				q: {
					title: this.query.memoTitle,
				},
			};
			const pagingParams = { page: this.currentPage };
			const params = { ...searchParams, ...pagingParams };
			const paramsSerializer = (params) => qs.stringify(params);
			const current_user = this.$store.getters["auth/reference_currentUser"];
			const res = await axios.get(`/api/users/${current_user.id}/memos`, {
				params,
				paramsSerializer,
			});
			this.memos = res.data.memos;
			// console.log(res.data.memos)
			this.pagingMeta = res.data.meta;
			this.currentPage = 1;
			this.$nextTick(() => this.searchFocus());
		},
	},
};
</script>

<style>
/* 表示・非表示アニメーション中 */
.v-enter-active, /* .v-leave-active */ {
	transition: all 200ms;
}

/* 表示アニメーション開始時 ・ 非表示アニメーション後 */
.v-enter,
.v-leave-to {
	opacity: 0;
}
</style>
