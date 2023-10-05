<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }" class="py-n1">
				<v-row align="center">
					<v-col @mouseover="onFocus()" @mouseout="outFocus()">
						<v-list-item
							@focus="onFocus()"
							@keydown.enter="openForm"
							link
							three-line
						>
							<v-list-item-content v-on="on">
								<v-row align="center">
									<v-col>
										<v-list-item-title class="subtitle-1 text--secondary mb-1">
											{{ data.title }}
										</v-list-item-title>
										<v-list-item-subtitle class="caption">
											{{ data.intro }}
										</v-list-item-subtitle>
									</v-col>
									<!-- <edit-memo-modal :memo="memo" /> -->
								</v-row>
							</v-list-item-content>
						</v-list-item>
					</v-col>
					<div @mouseover="onFocus()" @mouseout="outFocus()">
						<v-btn
							v-show="nowFocus"
							@blur="outFocus()"
							@click="deleteMemo(data)"
							icon
							color="error"
							class="mt-3"
						>
							<div>
								<v-icon>mdi-trash-can-outline</v-icon>
								<v-list-item-title class="text-caption">
									delete
								</v-list-item-title>
							</div>
						</v-btn>
					</div>
				</v-row>
				<v-divider @mouseout="outFocus()" />
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
							:rules="memoTitleRules"
							label="memo_title:"
							dense
							required
							prepend-icon="mdi-format-title"
							persistent-hint
							hint="空白への変更はできません"
							ref="modalTop"
						></v-text-field>

						<!-- <v-text-field
							class="py-2 mr-2"
							v-model="data.short_id"
							label="公開リンクの末尾 : "
							dense
							auto-grow
							prepend-icon="mdi-identifier"
							readonly
						></v-text-field> -->

						<tiptap v-model="data.content" @input="getTiptapInput" />
						<!-- <tiptap v-model="data.content" /> -->

						<v-card-actions class="mt-n1 mb-n7">
							<v-spacer />
							<v-spacer />

							<v-btn icon color="success" @click="saveEditMemo(data)">
								<div>
									<v-icon>mdi-check-circle</v-icon>
									<v-list-item-title class="text-caption">
										update
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
	props: {
		data: {},
	},
	components: {
		Tiptap,
	},
	data() {
		return {
			isOpen: false,
			tiptapInput: null,
			intro: null,
			nowFocus: false,
			// title: "",
			// description: "",
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
		async saveEditMemo(data) {
			if (this.$refs.form.validate()) {
				try {
					const current_user =
						this.$store.getters["auth/reference_currentUser"];
					const editMemoParams = {
						memo: {
							title: data.title,
							intro: this.intro || data.intro,
							content: this.tiptapInput || data.content,
						},
					};
					await axios.patch(
						`/api/users/${current_user.id}/memos/${data.id}`,
						editMemoParams
					);
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
		async deleteMemo(data) {
			try {
				const current_user = this.$store.getters["auth/reference_currentUser"];
				const deleteMemoParams = {
					memo: {
						id: data.id,
					},
				};
				await axios.delete(`/api/memos/${data.id}`, deleteMemoParams);
				this.closeForm();
			} catch (error) {
				alert(error.response.data.error.messages);
			}
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
