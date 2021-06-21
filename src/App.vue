<template>
  <v-app>
    <v-navigation-drawer v-if="user" v-model="drawer" absolute temporary app >
      <v-list dense nav>
        <v-list-group
            prepend-icon="mdi-menu"
            sub-group
        >
          <template v-slot:activator>
            <v-list-item-title>Меню</v-list-item-title>
          </template>
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
        </v-list-group>
        <v-list-item>
          <v-date-picker class="mt-5"
              v-model="picker"
              type="month"
              full-width
              locale="ru"
              @change="alertdate"
              color="blue"
              min="2021-04"
              no-title
          ></v-date-picker>
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



<script>

import Login from './controllers/auth/login.vue'

export default {

  components: {Login },
  data() {

    return {
      done: [false, false, false],
      mouseMonth: null,
      picker: new Date().toISOString().substr(0, 10),
      items: [
        //{ title: 'Home', icon: 'mdi-home', url: 'home' },
        { title: 'Основная', icon: 'mdi-credit-card-outline', url: 'main' },
        { title: 'КТУ', icon: 'mdi-file-table-box-multiple', url: 'ktu' },
        { title: 'Сотрудники', icon: 'mdi-account-group', url: 'users' },
        { title: 'Ввод данных', icon: 'mdi-database-plus', url: 'inputdata'},
        { title: 'Смены', icon: 'mdi-calendar', url: 'workhours'}
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
      actualdate: null,
      report_date: null,
      month_date: null,
      year_date: null,
      day_date: 1
    }
  },
/////////////////
  beforeMount() {
    this.token = this.$cookie.get('token')
    if (this.token === 'undefined') {
      this.token = null
    }
    this.alertdate()
    console.log('token', this.token)
    if (this.token) {
      this.getUser()
    }
  },
//////////////////////
  methods: {
    alertdate(){
      this.month_date = this.picker.split('-')[1]
      this.year_date = this.picker.split('-')[0]
      this.actualdate = new Date(this.picker.split('-')[0], this.picker.split('-')[1]-1,1);
      //alert(this.actualdate.getFullYear() + "-" + this.actualdate.getMonth() + "-" + this.actualdate.getDate())
      this.report_date = this.actualdate.getFullYear() + "-" + this.actualdate.getMonth() + "-" + this.actualdate.getDate()
      this.$storage.set('report_date', this.report_date)
      console.log(this.year_date + "-" + this.month_date + "-" + this.day_date)
      console.log(this.$storage.state.report_date)
      //console.log(this.actualdate)
      //console.log(typeof this.actualdate)
    },
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
          this.$alerterr('Токен устарел, перелогиньтесь.')
          this.doLogout()
        } else {
          this.$alerterr(e.message)
        }
      }
    }
  }

}
</script>
