<template>
	<div>
		<v-dialog v-model="isOpen" hide-overlay width="700px">
			<template #activator="{ on }">
				<v-btn icon class="mx-4 mt-1" v-on="on">
					<div>
						<v-icon color="grey darken-1"> mdi-cog-outline </v-icon>
						<v-list-item-title class="text-caption">HackMD</v-list-item-title>
					</div>
				</v-btn>
			</template>

			<v-list-item
				class="pa-7 mb-1"
				:style="{ background: 'rgba(240, 240, 245, 0.82)' }"
			>
				<v-card
					outlined
					color="transparent"
					class="justify-center"
					min-width="640px"
				>
					<v-list-item-subtitle class="py-2 mr-2 ml-9 mb-3">
						<div class="text-center">
							HackMD の APIキー を登録することで<br />
							* 閲覧権限：全員のノート *<br />
							へのリンクをメモに追加可能になります。
						</div>
					</v-list-item-subtitle>
					<v-row
						class="text-center text-caption grey--text mb-3"
						align="center"
					>
						<v-col>
							<div>
								<v-icon color="grey lighten-1" class="mt-n1">mdi-cat</v-icon>
								* 登録前にご自身の各HackMDノートの閲覧権限を確認ください *
							</div>
						</v-col>
					</v-row>

					<v-list-item class="justify-center mt-n4">
						<v-btn small color="info" @click="formFocus"> 登録する </v-btn>
					</v-list-item>

					<v-expand-transition>
						<v-list-item v-show="ok_agree" class="justify-center mt-2">
							<v-card outlined color="transparent" min-width="600px">
								<v-form ref="form" lazy-validation class="mb-3">
									<v-text-field
										class="py-2 mr-2"
										v-model="key_name"
										:rules="keyNameRules"
										label="key_name:"
										dense
										required
										prepend-icon="mdi-tag-text-outline"
										persistent-hint
										hint="入力必須"
										ref="modalTop"
									></v-text-field>

									<v-text-field
										class="py-2 mr-2"
										v-model="api_key"
										:rules="apiKeyRules"
										:append-icon="toggle.icon"
										@click.append="showApiKey = !showApiKey"
										label="api_key:"
										dense
										prepend-icon="mdi-key-outline"
										persistent-hint
										hint="行内クリックで内容確認できます *入力必須*"
										counter
										:type="toggle.type"
									></v-text-field>

									<v-card-actions class="mt-1 mb-n7">
										<v-spacer />

										<v-btn icon color="info" @click="saveHackmd">
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
									</v-card-actions>
								</v-form>
							</v-card>
						</v-list-item>
					</v-expand-transition>
				</v-card>
			</v-list-item>
		</v-dialog>
	</div>
</template>

<script>
import axios from "axios";

export default {
	// props: {
	//
	// },
	data() {
		return {
			isOpen: false,
			showApiKey: false,
			key_name: "",
			api_key: "",
			ok_agree: false,
		};
	},
	computed: {
		toggle() {
			const icon = this.showApiKey ? "mdi-eye" : "mdi-eye-off";
			const type = this.showApiKey ? "text" : "password";
			return { icon, type };
		},
		keyNameRules() {
			// 必須入力
			return [(v) => !!v || "必ず入力してください"];
		},
		apiKeyRules() {
			// 必須入力
			return [(v) => !!v || "必ず入力してください"];
		},
	},
	mounted() {
		//
	},
	methods: {
		async formFocus() {
			this.getApiKeySaveKey();
			this.ok_agree = true;
			await (this.isOpen = true);
			this.$nextTick(() => {
				this.$refs.modalTop.focus();
			});
		},
		async getApiKeySaveKey() {
			await this.$store.dispatch("hackmd/get_api_key_save_key");
		},
		async saveHackmd() {
			if (this.$refs.form.validate()) {
				try {
					const current_user =
						this.$store.getters["auth/reference_currentUser"];
					const hackmdParams = {
						hackmd_account: {
							key_name: this.key_name,
							api_key: this.api_key,
							user_id: current_user.id,
						},
					};
					await axios.post(`/api/hackmd_accounts`, hackmdParams);
				} catch (error) {
					alert(error.response.data.error.messages);
				}
			}
		},
		closeForm() {
			this.isOpen = false;
			this.key_name = "";
			this.api_key = "";
			this.ok_agree = false;
		},
	},
};
</script>

<style lang="scss" scoped></style>
