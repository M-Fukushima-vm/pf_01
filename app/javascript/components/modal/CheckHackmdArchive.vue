<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }" class="py-n1">
				<v-row align="center" no-gutters>
					<v-col @mouseover="onFocus" @mouseout="outFocus">
						<v-list-item @focus="onFocus" link two-line>
							<v-list-item-content v-on="on">
								<v-list-item-title
									v-if="data.title.length >= 20"
									v-html="data.title.substring(0, 19) + '…'"
									class="subtitle-1 text--secondary mb-1"
								/>
								<!-- {{ data.title }}
								</v-list-item-title> -->
								<v-list-item-title
									v-else
									v-html="data.title"
									class="subtitle-1 text--secondary mb-1"
								/>
								<v-list-item-subtitle class="text-caption">
									公開リンク末尾 : {{ data.short_id }}
								</v-list-item-subtitle>
							</v-list-item-content>
						</v-list-item>
					</v-col>
					<v-card-actions align="center" no-gutters>
						<div @mouseover="onFocus" @mouseout="outFocus">
							<v-btn
								v-show="nowFocus"
								@blur=""
								icon
								color="secondary"
								class="mt-1 mr-2"
								@click="createNote"
							>
								<div>
									<v-icon small class="mb-n1"> mdi-arrow-collapse-down </v-icon>
									<v-list-item-title class="text-caption"
										>Import</v-list-item-title
									>
								</div>
							</v-btn>
						</div>
						<div @mouseover="onFocus" @mouseout="outFocus">
							<v-btn
								v-show="nowFocus"
								@blur="outFocus"
								icon
								color="error"
								class="mt-1 ml-2"
								@click="deleteArchive"
							>
								<div>
									<v-icon class="mb-n1"> mdi-trash-can-outline </v-icon>
									<v-list-item-title class="text-caption"
										>delete</v-list-item-title
									>
								</div>
							</v-btn>
						</div>
					</v-card-actions>
				</v-row>
				<v-divider @mouseout="outFocus" />
			</template>

			<v-list-item
				@keydown.esc="closeForm"
				class="pa-7"
				:style="{ background: 'rgba(240, 240, 245, 0.82)' }"
			>
				<v-card
					outlined
					color="transparent"
					class="justify-center"
					min-width="540px"
				>
					<v-form ref="form" lazy-validation class="mb-3">
						<v-text-field
							class="py-2 mr-2"
							v-model="data.title"
							label="title:"
							dense
							required
							prepend-icon="mdi-format-title"
							readonly
							ref="modalTop"
						></v-text-field>

						<v-text-field
							class="py-2 mr-2"
							v-model="data.short_id"
							label="公開リンクの末尾 : "
							dense
							auto-grow
							prepend-icon="mdi-identifier"
							readonly
						></v-text-field>

						<v-card-actions class="mt-n1 mb-n7">
							<v-spacer />
							<v-spacer />

							<v-btn icon @click="checkSourceLink" color="success">
								<div>
									<v-icon>mdi-open-in-new</v-icon>
									<v-list-item-title class="text-caption"
										>check</v-list-item-title
									>
								</div>
							</v-btn>

							<v-spacer />

							<v-btn icon @click="closeForm">
								<div>
									<v-icon>mdi-close</v-icon>
									<v-list-item-title class="text-caption"
										>close</v-list-item-title
									>
								</div>
							</v-btn>

							<v-spacer />
							<v-spacer />
						</v-card-actions>
					</v-form>
				</v-card>
			</v-list-item>
		</v-dialog>
	</div>
</template>

<script>
import axios from "axios";
import qs from "qs";

export default {
	props: {
		data: {},
	},
	data() {
		return {
			isOpen: false,
			nowFocus: false,
			// title: "",
			// description: "",
		};
	},
	computed: {
		// memoTitleRules() {
		// 	// 必須入力
		// 	return [(v) => !!v || "Titleは必ず入力してください"];
		// },
	},
	mounted() {
		//
	},
	methods: {
		async formFocus() {
			await (this.isOpen = true);
			this.$nextTick(() => {
				this.$refs.modalTop.focus();
			});
		},
		async deleteArchive() {
			try {
				// console.log(this.data.id);
				// const archiveParams = {
				// 	archive: {
				// 		title: data.title,
				// 	},
				// };
				const archive = this.data;
				await axios.delete(`/api/hackmd_archives/${this.data.id}`);
				this.$emit("delete", archive);
			} catch (error) {
				alert(error.response.data.error.messages);
			}
		},
		async createNote() {
			try {
				const noteParams = {
					hackmd_note: {
						title: this.data.title,
						short_id: this.data.short_id,
					},
				};
				const params = { ...noteParams };
				const paramsSerializer = (params) => qs.stringify(params);
				await axios.post(`/api/hackmd_notes`, {
					...params,
					paramsSerializer,
				});
				// this.$emit("delete", archive);
			} catch (error) {
				alert(error.response.data.error.messages);
			}
		},
		checkSourceLink() {
			window.open(this.data.link, "_blank");
		},
		onFocus() {
			this.nowFocus = true;
		},
		outFocus() {
			this.nowFocus = false;
		},
		openForm() {
			this.isOpen = true;
			this.formFocus();
		},
		closeForm() {
			this.isOpen = false;
		},
	},
};
</script>

<style lang="scss" scoped></style>
