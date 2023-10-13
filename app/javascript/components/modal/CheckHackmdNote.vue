<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="600px">
			<template #activator="{ on }" class="py-n1">
				<v-row align="center" no-gutters>
					<v-col @mouseover="onFocus" @mouseout="outFocus">
						<v-list-item @focus="onFocus" link two-line>
							<v-list-item-content v-on="on">
								<v-list-item-title
									v-if="data.title.length >= 22"
									v-html="data.title.substring(0, 22) + '…'"
									class="subtitle-1 text--secondary mb-1"
								/>
								<v-list-item-title
									v-else
									v-html="data.title"
									class="subtitle-1 text--secondary mb-1"
								/>
								<v-list-item-subtitle
									v-if="data.intro.length >= 39"
									v-html="data.intro.substring(0, 39) + '…'"
									class="text-caption"
								/>
							</v-list-item-content>
						</v-list-item>
					</v-col>
					<v-card-actions align="center" no-gutters>
						<div @mouseover="onFocus" @mouseout="outFocus">
							<v-btn
								v-show="nowFocus"
								@blur="outFocus"
								icon
								color="error"
								class="mt-1 ml-2"
								@click="deleteNote"
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
							:rules="noteTitleRules"
							label="title:"
							dense
							required
							prepend-icon="mdi-format-title"
							readonly
							ref="modalTop"
						></v-text-field>

						<tiptap v-model="data.content" @input="getTiptapInput" />

						<v-card-actions class="mt-n1 mb-n7">
							<v-spacer />
							<v-spacer />

							<v-btn icon @click="updateNote(data)" color="success">
								<div>
									<v-icon>mdi-check-circle</v-icon>
									<v-list-item-title class="text-caption"
										>update</v-list-item-title
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
			nowFocus: false,
			tiptapInput: null,
			intro: null,
			// title: "",
			// description: "",
		};
	},
	computed: {
		noteTitleRules() {
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
		async deleteNote() {
			try {
				const note = this.data;
				await axios.delete(`/api/hackmd_notes/${this.data.id}`);
				this.$emit("delete", note);
			} catch (error) {
				alert(error.response.data.error.messages);
			}
		},
		getTiptapInput(value) {
			// console.log(value);
			this.tiptapInput = value;
			// // HTMLデータをDOM要素に変換
			const parser = new DOMParser();
			const doc = parser.parseFromString(value, "text/html");
			// // テキストを抽出する
			const text = doc.body.innerText;
			// // 最初の150文字を抜き出す
			const intro_text = text.substring(0, 150);
			this.intro = intro_text;
		},
		async updateNote(data) {
			if (this.$refs.form.validate()) {
				try {
					// this.getTiptapInput();
					// const current_user =
					// 	this.$store.getters["auth/reference_currentUser"];
					const editNoteParams = {
						hackmd_note: {
							title: data.title,
							intro: this.intro || data.intro,
							content: this.tiptapInput || data.content,
						},
					};
					const params = { ...editNoteParams };
					const paramsSerializer = (params) => qs.stringify(params);
					await axios.patch(`/api/hackmd_notes/${data.id}`, {
						...params,
						paramsSerializer,
					});
					this.closeForm();
				} catch (error) {
					console.log(error);
					// alert(error.response.data.error.messages);
				}
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
