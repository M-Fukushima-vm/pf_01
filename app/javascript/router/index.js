import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
import colorSample from '@/components/colorSample/ColorSample'
import PageUsers from "@/pages/PageUsers"
const router = new VueRouter({
    routes: [
      { path: "/", component: colorSample, name: "top" },
      { path: "/users", component: PageUsers, name: "users" },
    ],
});

export default router; 