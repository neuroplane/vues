<template>
  <v-app>
    <v-container>
      <v-row>
        <v-col v-if="token" xl="1" md="2" lg="2">
          <Navigation ></Navigation>
          <a class="m-1" href="/" @click.prevent="doLogout()"> Выйти </a>
        </v-col>
        <v-col xl="11" md="10" lg="10" style="background-color: azure">

          <div id="app">
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
          </div>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<style>

</style>

<script>

import Login from './controllers/auth/login.vue'
import Navigation from "@/components/Navigation";

export default {
  components: {Navigation, Login },
  data() {
    return {
      items: [
        { title: 'Home', icon: 'mdi-view-dashboard', url: 'home' },
        { title: 'Main', icon: 'mdi-image', url: 'main' },
        { title: 'None', icon: 'mdi-help-box', url: '' }
      ],
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
      this.user = null
      this.token = null
      this.$router.push({ name: 'Main' })
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
