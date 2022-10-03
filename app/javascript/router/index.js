import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
import colorSample from '@/components/colorSample/ColorSample'
import PageUsers from "@/pages/PageUsers"
import PageMates from "@/pages/PageMates"
import PageApplicants from "@/pages/PageApplicants"
const router = new VueRouter({
    routes: [
      { path: "/", component: colorSample, name: "top" },
      { path: "/users", component: PageUsers, name: "users" },
      { path: "/mates", component: PageMates, name: "mates" },
      { path: "/applicants", component: PageApplicants, name: "applicants" },
    ],
});

export default router; 