import Vue from 'vue'
import VueRouter from 'vue-router'
import Main from '../views/Main.vue'

Vue.use(VueRouter)

const routes = [
  {path: '/', name: 'Main', component: Main},
  {path: '/about', name: 'About', component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')},
  {path: '/home', name: 'Home', component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue')},
  {path: '/main', name: 'Main', component: () => import(/* webpackChunkName: "about" */ '../views/Main.vue')},
]

const router = new VueRouter({
  routes
})

export default router
