<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }">
				<v-btn icon class="mx-4 mt-1" v-on="on" @click="formFocus">
					<div>
						<v-icon color="grey darken-1"> mdi-file-edit-outline </v-icon>
						<v-list-item-title class="text-caption">New</v-list-item-title>
					</div>
				</v-btn>
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

						<!-- <v-textarea
							class="py-2 mr-2"
							v-model="description"
							label="memo_description:"
							dense
							auto-grow
							prepend-icon="mdi-text"
							hint="ー 補足 or 本文として 入力してください ー * 任意入力 *"
						></v-textarea> -->

						<tiptap @input="getTiptapInput" />

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
import Tiptap from "@/components/editor/Tiptap";

export default {
	// props: {
	//
	// },
	components: {
		Tiptap,
	},
	data() {
		return {
			isOpen: false,
			title: "",
			description: "",
			tiptapInput: null,
			intro: null,
		};
	},
	computed: {
		memoTitleRules() {
			// 必須入力
			return [(v) => !!v || "Titleは必ず入力してください"];
		},
	},
	// mounted() {
	//
	// },
	methods: {
		async formFocus() {
			await (this.isOpen = true);
			this.$nextTick(() => {
				this.$refs.modalTop.focus();
			});
		},
		async saveNewMemo() {
			if (this.$refs.form.validate()) {
				try {
					this.getTiptapInput();
					this.$nextTick(() => {
						const newMemoParams = {
							memo: {
								title: this.title,
								// memo_content: this.description,
								intro: this.intro,
								content: this.tiptapInput,
							},
						};
					});
					await axios.post(`/api/memos`, newMemoParams);
					this.closeForm();
				} catch (error) {
					alert(error.response.data.error.messages);
				}
			}
		},
		getTiptapInput(value) {
			// console.log(value);
			this.tiptapInput = value;
			// HTMLデータをDOM要素に変換
			const parser = new DOMParser();
			const doc = parser.parseFromString(value, "text/html");
			// テキストを抽出する
			// const text = doc.body.textContent || doc.body.innerText;
			const text = doc.body.innerText;
			// console.log(text);
			// 最初の150文字を抜き出す
			const intro_text = text.substring(0, 150);
			// console.log(intro_text);
			this.intro = intro_text;
		},
		closeForm() {
			this.isOpen = false;
			this.title = "";
			this.description = "";
			this.tiptapInput = "";
		},
	},
};
</script>

<style lang="scss" scoped></style>
