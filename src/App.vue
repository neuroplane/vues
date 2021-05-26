<template>
  <v-app>
    <v-navigation-drawer v-if="user" v-model="drawer" absolute temporary app >
      <v-list dense nav>
        <v-list-item
            v-for="item in items"
            :key="item.title"
            link
            :to="item.url"
            v-model="group"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>
              {{ item.title}}
            </v-list-item-title>

          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar v-if="user" dense app>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-spacer></v-spacer>
      <v-btn small plain @click="doLogout">
        <v-icon>mdi-exit-to-app</v-icon>
      </v-btn>
    </v-app-bar>
    <v-main>
      <v-container fluid>
            <div v-if="!user">
                <login @done="HandleLoginOrRegisterComplete"/>
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

export default {
  components: {Login },
  data() {
    return {
      items: [
        //{ title: 'Home', icon: 'mdi-home', url: 'home' },
        { title: 'Main', icon: 'mdi-credit-card-outline', url: 'main' },
        { title: 'Ktu', icon: 'mdi-file-table-box-multiple', url: 'ktu' },
        { title: 'Users', icon: 'mdi-account-group', url: 'users' },
        { title: 'Input Data', icon: 'mdi-database-plus', url: 'inputdata'}
      ],
      right: null,
      show_reg: false,
      token: null,
      user: null,
      role: null,
      role_parent: null,
      role_child: null,
      drawer: false,
      group: null,
    }
  },
/////////////////
  beforeMount() {
    this.token = this.$cookie.get('token')
    if (this.token === 'undefined') {
      this.token = null
    }

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
