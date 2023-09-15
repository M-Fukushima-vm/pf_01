import axios from "axios";

// vuex版のdata(){} ... 状態(データ：固定値 の一時保管領域) デフォルトの値はnull(空)
const state = {
	hackmdAccount: null,
};

// vuex版のcomputed ... 内容調整して返す類のもの
const getters = {
	hackmdAccount: (state) => state.hackmdAccount,
	hackmdAccountName: (state) =>
		state.hackmdAccount ? state.hackmdAccount.key_name : null,
};

// vuex版のmethods ... 詳細内容をまとめて置くだけにし、
//                    実行(commit)はactionsに譲るが無難
//                    (同期処理しか受付けない為)
const mutations = {
	SET_HACKMD_ACCOUNT: (state, account) => {
		state.hackmdAccount = account;
		const decoded_api_key = atob(account.api_key);
		state.hackmdAccount.api_key = decoded_api_key;
	},
	CLEAR_HACKMD_ACCOUNT: () => {
		state.hackmdAccount = null;
	},
};

// vuex版のmethods ... 実行(commit)担当。
//                    こっちからは非同期処理可能。
//                    主にmutationsから選択して実行
const actions = {
	async save({ commit }, hackmdParams) {
		const res = await axios.post(`/api/hackmd_accounts`, hackmdParams);
		// console.log(res.data.hackmd_account);
		// console.log("-------------------------------------");
		commit("SET_HACKMD_ACCOUNT", res.data.hackmd_account);
	},
	async get({ commit }) {
		const res = await axios.get(`/api/hackmd_accounts`);
		// console.log(res.data);
		// console.log(res.data.hackmd_account);
		// console.log("-------------------------------------");
		if (res) {
			commit("SET_HACKMD_ACCOUNT", res.data.hackmd_account);
		}
	},
	async delete({ commit, state }) {
		try {
			await axios.delete(`/api/hackmd_accounts/${state.hackmdAccount.id}`);
		} catch (error) {
			console.log(JSON.stringify(error.response.data.error.messages));
		}
		commit("CLEAR_HACKMD_ACCOUNT");
	},
};

export default {
	namespaced: true,
	state,
	mutations,
	actions,
	getters,
};
