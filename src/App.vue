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


        <v-list-item class="mt-3">
          <v-col>
            <v-btn
                tile
                min-width="33%"
                max-width="33%"
                plain
                class="font-weight-light"
                :key="button.monthnum"
                v-for="button in months"
                @click="monthset(button.monthnum)"
            >{{button.monthname}}</v-btn>
          </v-col>
        </v-list-item>
        <v-list-item>
          <v-col

          >
            <v-btn
                min-width="50%"
                max-width="50%"
                class="font-weight-light"
                plain
                :key="button.yearnum"
                v-for="button in years"
                @click="yearset(button.yearnum)"
            >{{button.yearnum}}</v-btn>
          </v-col>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar v-if="user" dense app>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-spacer></v-spacer>
      <v-app-bar-title class="font-weight-light">{{ this.$storage.state.calMonth }}.{{ this.$storage.state.calYear }}</v-app-bar-title>
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
      months: [
          {'monthname':'ЯНВ', 'monthnum':1},
          {'monthname':'ФЕВ','monthnum':2},
          {'monthname':'МАР', 'monthnum':3},
          {'monthname':'АПР', 'monthnum':4},
          {'monthname':'МАЙ', 'monthnum':5},
          {'monthname':'ИЮН', 'monthnum':6},
          {'monthname':'ИЮЛ', 'monthnum':7},
          {'monthname':'АВГ', 'monthnum':8},
          {'monthname':'СЕН', 'monthnum':9},
          {'monthname':'ОКТ', 'monthnum':10},
          {'monthname':'НОЯ', 'monthnum':11},
          {'monthname':'ДЕК', 'monthnum':12}
      ],
      years: [{'yearname': 2021, 'yearnum': 2021},{'yearname': 2020, 'yearnum': 2020}],
      picker: new Date().toISOString().substr(0, 10),
      items: [
        //{ title: 'Home', icon: 'mdi-home', url: 'home' },
        { title: 'Основная', icon: 'mdi-credit-card-outline', url: 'main' },
        { title: 'КТУ', icon: 'mdi-file-table-box-multiple', url: 'ktu' },
        { title: 'Сотрудники', icon: 'mdi-account-group', url: 'users' },
        { title: 'Ввод данных', icon: 'mdi-database-plus', url: 'inputdata'},
        { title: 'Смены', icon: 'mdi-calendar', url: 'workhours'},
        { title: 'Проверка таблиц', icon: 'mdi-check', url: 'about'}
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
      picker_range: [],
      month_now: null,
      year_now: null,
      date_now: null,
      cal_obj: {},
      cal_year: null,
      cal_month: null
    }
  },
/////////////////
  created() {

  },
  mounted() {


  },
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
  methods: {
    monthset(monthnum){
      this.monthnum = monthnum
      this.$storage.set('calMonth', monthnum)
      this.cal_month = this.$storage.state.calMonth
    },
    yearset(yearnum){
      this.yearnum = yearnum
      this.$storage.set('calYear', yearnum)
      this.cal_year = this.$storage.state.calYear
    },
    tsvJSON(tsv) {
      const lines = tsv.split('\n');
      const headers = lines.slice(0, 1)[0].split('\t');
      return lines.slice(1, lines.length).map(line => {
        const data = line.split('\t');
        return headers.reduce((obj, nextKey, index) => {
          obj[nextKey] = data[index];
          return obj;
        }, {});
      });
    },
    async getClosestDate(){
      this.cal_year = this.cal_obj.closest_year
      this.cal_month = this.cal_obj.closest_month
      console.log(this.cal_year)
    },
    doLogout() {
      this.$cookie.delete('token')
      this.$storage.set('logged_in', false)
      this.$storage.set('calYear', null)
      this.$storage.set('calMonth', null)
      this.cal_year = null
      this.cal_month = null
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
