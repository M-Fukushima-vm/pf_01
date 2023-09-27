import Vue from "vue";
import VueRouter from "vue-router";
Vue.use(VueRouter);
import colorSample from "@/components/colorSample/ColorSample";
import PageUsers from "@/pages/PageUsers";
import PageMates from "@/pages/PageMates";
import PageMuteUsers from "@/pages/PageMuteUsers";
import PageBlockUsers from "@/pages/PageBlockUsers";
import PageFollowers from "@/pages/PageFollowers";
import PageMemos from "@/pages/PageMemos";
import PageHackmdNotes from "@/pages/PageHackmdNotes";
const router = new VueRouter({
	routes: [
		{ path: "/", component: colorSample, name: "top" },
		{ path: "/users", component: PageUsers, name: "users" },
		{ path: "/mates", component: PageMates, name: "mates" },
		{ path: "/mute_users", component: PageMuteUsers, name: "mute_users" },
		{ path: "/block_users", component: PageBlockUsers, name: "block_users" },
		{ path: "/followers", component: PageFollowers, name: "followers" },
		{ path: "/memos", component: PageMemos, name: "memos" },
		{ path: "/hackmd_notes", component: PageHackmdNotes, name: "hackmd_notes" },
	],
});

export default router;
