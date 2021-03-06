import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {path: '/about', name: 'About', component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')},
  {path: '/', name: 'Start', component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue')},
  //{path: '/home', name: 'Home', component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue')},
  {path: '/main', name: 'Main', component: () => import(/* webpackChunkName: "about" */ '../views/Main.vue')},
  {path: '/ktu', name: 'Ktu', component: () => import(/* webpackChunkName: "about" */ '../views/Ktu.vue')},
  {path: '/users', name: 'Users', component: () => import(/* webpackChunkName: "about" */ '../views/Users.vue')},
  {path: '/inputdata', name: 'Inputdata', component: () => import(/* webpackChunkName: "about" */ '../views/Inputdata.vue')},
  {path: '/workhours', name: 'Workhours', component: () => import(/* webpackChunkName: "about" */ '../views/Workhours.vue')},
  {path: '/test', name: 'Test', component: () => import(/* webpackChunkName: "about" */ '../views/Test.vue')},
]

const router = new VueRouter({
  routes
})

export default router
