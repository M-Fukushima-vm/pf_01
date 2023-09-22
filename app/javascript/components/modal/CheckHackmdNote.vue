<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }" class="py-n1">
				<v-list-item three-line v-on="on">
					<v-list-item-content>
						<v-list-item-title class="subtitle-1 text--secondary mb-n3">
							{{ data.title }}
						</v-list-item-title>
						<v-list-item-subtitle class="text-caption">
							{{ data.content }}
						</v-list-item-subtitle>
					</v-list-item-content>
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
							v-model="title"
							:rules="memoTitleRules"
							label="memo_title:"
							dense
							required
							prepend-icon="mdi-format-title"
							persistent-hint
							hint="入力必須"
							ref="modalTop"
						></v-text-field>

						<v-textarea
							class="py-2 mr-2"
							v-model="description"
							label="memo_description:"
							dense
							auto-grow
							prepend-icon="mdi-text"
							hint="ー 補足 or 本文として 入力してください ー * 任意入力 *"
						></v-textarea>

						<v-card-actions class="mt-n1 mb-n7">
							<v-spacer />
							<v-spacer />

							<v-btn icon color="info" @click="saveNewMemo">
								<div>
									<v-icon>mdi-check-circle</v-icon>
									<v-list-item-title class="text-caption">
										save
									</v-list-item-title>
								</div>
							</v-btn>

							<v-spacer />

							<v-btn icon @click="closeForm">
								<div>
									<v-icon>mdi-close</v-icon>
									<v-list-item-title class="text-caption"
										>cancel</v-list-item-title
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
			title: "",
			description: "",
		};
	},
	computed: {
		memoTitleRules() {
			// 必須入力
			return [(v) => !!v || "Titleは必ず入力してください"];
		},
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
		closeForm() {
			this.isOpen = false;
			this.title = "";
			this.description = "";
		},
	},
};
</script>

<style lang="scss" scoped></style>
