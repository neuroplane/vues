<template>
  <v-app>
    <Navigation ></Navigation>
    <Appbar ></Appbar>
    <v-main>
      <v-container fluid>
    <a class="m-1" href="/" @click.prevent="doLogout()"> Выйти </a>
            <div v-if="!token" class="">
              <div v-if="show_reg">
              </div>
              <div v-else>
                <login @done="HandleLoginOrRegisterComplete"/>
                <div class="pl-5 pr-5">
                  <button @click="show_reg=true" class="btn btn-sm btn-outline-primary btn-block">Регистрация</button>
                </div>
              </div>
            </div>
            <div v-if="user">

            </div>
            <router-view/>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>

</style>

<script>

import Login from './controllers/auth/login.vue'
import Navigation from "@/components/Navigation";
import Appbar from "@/components/Appbar";

export default {
  components: {Navigation, Appbar, Login },
  data() {
    return {
      right: null,
      show_reg: false,
      token: null,
      user: null,
      role: null,
      role_parent: null,
      role_child: null
    }
  },
/////////////////
  beforeMount() {
    this.token = this.$cookie.get('token')
    if (this.token === 'undefined') {
      this.token = null
    }
    this.$router.push({ name: 'Main' })

    console.log('token', this.token)
    if (this.token) {
      this.getUser()
    }
  },
//////////////////////
  methods: {
    doLogout() {
      this.$cookie.delete('token')
      this.$storage.set('logged_in', false)
      this.user = null
      this.token = null
      //this.$router.push({ name: 'Main' })
      this.$router.push('/')
    },

    HandleLoginOrRegisterComplete() {
      this.token = this.$cookie.get('token')
      this.getUser()
    },

/////////////////////////
    async getUser() {
      if (!this.token) {
        return
      }
      try {
        this.user = await this.$api.get('users/me')
        this.$storage.set('user', this.user)
        this.$storage.set('logged_in', true)
      } catch (e) {
        if (e.code === 401) {
          this.$alerterr('Токен устарел, перелогиньтесь')
          this.doLogout()
        } else {
          this.$alerterr(e.message)
        }
      }
    }
  }

}
</script>
