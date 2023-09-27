<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }" class="py-n1">
				<v-list-item three-line>
					<v-list-item-content v-on="on">
						<v-list-item-title class="subtitle-1 text--secondary mb-n3">
							{{ data.title }}
						</v-list-item-title>
						<v-list-item-subtitle class="text-caption">
							公開リンク末尾 : {{ data.short_id }}
						</v-list-item-subtitle>
					</v-list-item-content>
					<v-btn icon class="mx-4 mt-1" @click="">
						<div>
							<v-icon color="grey darken-1" small class="mb-n1">
								mdi-arrow-collapse-down
							</v-icon>
							<v-list-item-title class="text-caption">Import</v-list-item-title>
						</div>
					</v-btn>
				</v-list-item>
			</template>

			<v-list-item
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

export default {
	props: {
		data: {},
	},
	data() {
		return {
			isOpen: false,
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
		// onFocus() {
		// 	this.$emit("openButton");
		// },
		async saveNewMemo() {
			// if (this.$refs.form.validate()) {
			// 	try {
			// 		const newMemoParams = {
			// 			memo: {
			// 				memo_title: this.title,
			// 				memo_content: this.description,
			// 			},
			// 		};
			// 		await axios.post(`/api/memos`, newMemoParams);
			// 	} catch (error) {
			// 		alert(error.response.data.error.messages);
			// 	}
			// }
		},
		checkSourceLink() {
			window.open(this.data.link, "_blank");
		},
		closeForm() {
			this.isOpen = false;
			this.title = "";
			this.description = "";
		},
	},
};
</script>

<style lang="scss" scoped></style>
