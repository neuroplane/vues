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
          <v-date-picker
              picker-date="2021-5"
              class="mt-5"
              v-model="picker"
              type="month"
              full-width
              locale="ru"
              @change="alertdate"
              color="blue"
              min="2021-4"
              max="2021-6"
              no-title
              show-current="2021-05"
          ></v-date-picker>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar v-if="user" dense app>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-app-bar-title>{{ this.$storage.state.title_date }}</v-app-bar-title>
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
      picker: "2021-05",
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
      actualdate: null,
      report_date: null,
      month_date: null,
      year_date: null,
      day_date: 1,
      date_to_convert: null,
      picker_range: [],
      month_now: null,
      year_now: null,
      date_now: null
    }
  },
/////////////////
  created() {
    this.pickerset()
  },
  mounted() {
    this.get_picker_range()
    this.alertdate()
  },
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
////////////////////// Доделать сраную дату в пикере!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  methods: {

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
    async get_picker_range(){
      this.picker_range = await this.$api.post('getpickerrange',{})
      console.log(this.picker_range)
    },
    alfertdate(){
      this.month_date = this.picker.split('-')[1]
      this.year_date = this.picker.split('-')[0]
      this.actualdate = new Date(this.picker.split('-')[0], this.picker.split('-')[1],1);
      //alert(this.actualdate.getFullYear() + "-" + this.actualdate.getMonth() + "-" + this.actualdate.getDate())
      this.report_date = this.actualdate.getFullYear() + "-" + this.actualdate.getMonth() + "-" + this.actualdate.getDate()
      this.$storage.set('report_date', this.report_date)
      this.$storage.set('month_date', this.month_date)
      this.$storage.set('year_date', this.year_date)
      this.$storage.set('day_date', this.day_date)
      const options = { month: 'long', year:'2-digit'};
      const newreportdate = new Date(Date.UTC(this.year_date, this.month_date-1, this.day_date))
      this.$storage.set('title_date', newreportdate.toLocaleDateString('ru-RU', options))
      this.drawer = false
      console.log(this.$storage.state.title_date)
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
