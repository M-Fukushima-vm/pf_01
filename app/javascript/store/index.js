import Vue from "vue";
import Vuex from "vuex";
import auth from "@/store/modules/auth";
import hackmd from "@/store/modules/api/hackmd";
Vue.use(Vuex);

const store = new Vuex.Store({
	modules: {
		auth,
		hackmd,
	},
});

export default store;
