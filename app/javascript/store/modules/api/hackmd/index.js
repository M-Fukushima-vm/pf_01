import axios from "axios";

// vuex版のdata(){} ... 状態(データ：固定値 の一時保管領域) デフォルトの値はnull(空)
const state = {
	apiKeySaveKey: null,
};

// vuex版のcomputed ... 内容調整して返す類のもの
const getters = {
	apiKeySaveKey: (state) => state.apiKeySaveKey,
	// currentUserAvatar: (state) => state.currentUser.avatar_url,
	// // 指定のプロパティを省いた state.currentUser のサブセット(other) を返す
	// reference_currentUser: (state) =>
	// 	(({ email, token, ...other }) => other)(state.currentUser),
};

// vuex版のmethods ... 詳細内容をまとめて置くだけにし、
//                    実行(commit)はactionsに譲るが無難
//                    (同期処理しか受付けない為)
const mutations = {
	GET_API_KEY_SAVE_KEY: (state, save_key) => {
		state.apiKeySaveKey = save_key;
	},
	// SET_CURRENT_USER: (state, user) => {
	// 	state.currentUser = user;
	// 	localStorage.setItem("currentUser", JSON.stringify(user));
	// 	axios.defaults.headers.common["Authorization"] = `Bearer ${user.token}`;
	// },
	// CLEAR_CURRENT_USER: () => {
	// 	state.currentUser = null;
	// 	localStorage.removeItem("currentUser");
	// 	// location.reload();
	// },
};

// vuex版のmethods ... 実行(commit)担当。
//                    こっちからは非同期処理可能。
//                    主にmutationsから選択して実行
const actions = {
	async get_api_key_save_key({ commit }) {
		const res = await axios.get(`/api/hackmd_accounts`);
		// console.log(res);
		commit("GET_API_KEY_SAVE_KEY", res.data);
	},
	// async login({ commit }, sessionParams) {
	// 	const res = await axios.post(`/api/session`, sessionParams);
	// 	commit("SET_CURRENT_USER", res.data.user);
	// },
	// logout({ commit }) {
	// 	commit("CLEAR_CURRENT_USER");
	// },
	// async updateProfile({ commit, state }, userParams) {
	// 	const res = await axios.patch(`/api/me/account`, userParams);
	// 	commit("SET_CURRENT_USER", {
	// 		...res.data.user,
	// 		...{ token: state.currentUser.token },
	// 	});
	// },
	// async removeAvatar({ commit, state }) {
	// 	const res = await axios.delete(`/api/me/account`);
	// 	commit("SET_CURRENT_USER", {
	// 		...res.data.user,
	// 		...{ token: state.currentUser.token },
	// 	});
	// },
};

export default {
	namespaced: true,
	state,
	mutations,
	actions,
	getters,
};
