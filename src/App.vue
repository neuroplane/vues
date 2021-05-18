<template>
  <div class="m-1">
    <div class="col-md-6 offset-md-3">
      <div id="app">

        <div v-if="!token" class="">

          <div v-if="show_reg">
            <register @done="HandleLoginOrRegisterComplete"/>
            <br/>
            <div class="pl-5 pr-5">
              <button @click="show_reg=false" class="btn btn-sm btn-outline-primary btn-block">Вход по паролю</button>
            </div>

          </div>
          <div v-else>
            <login @done="HandleLoginOrRegisterComplete"/>
            <br/>
            <div class="pl-5 pr-5">
              <button @click="show_reg=true" class="btn btn-sm btn-outline-primary btn-block">Регистрация</button>
            </div>

          </div>
        </div>
        <div v-if="user">
          <small style="display:inline-block;"></small>
          <div id="nav" class="mt-1 bg-light">
            <span>{{$storage.state.user.name}} : : : </span>
            <router-link class="m-1" to="/goals">Цели</router-link>
            <router-link class="m-1" v-if="!role" to="/calc">Примеры</router-link>
            <span v-if="role">
              <router-link class="m-1" to="/admin">Админка</router-link>
            </span>

            <!--<router-link to="/register">Рега</router-link>
            |-->
            <a class="m-1" href="/" @click.prevent="doLogout()"> Выйти </a>
          </div>
          <hr>

          <router-view/>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.card-body {
  -ms-flex: 1 1 auto;
  -webkit-box-flex: 1;
  flex: 1 1 auto;
  padding: 0.5rem;
}
ul {
  padding-inline-start: 20px;
}
div#radio-group-1 {
  width: 100%;
}
.statistics {
  font-size: 9pt;
}
.table.transactions{
  font-size: 9pt;
}
.table.transactions td:nth-child(4){
  text-align: right;
}
.table.transactions td:nth-child(-n+3){
  text-align: left;
}
.table.transactions th:nth-child(4){
  text-align: right;
}
.table.transactions th:nth-child(-n+3){
  text-align: left;
}
.calcbuttons {
  flex-wrap: wrap;
}
#calc, .table, td, tr {
  padding: 4px !important;
  border-spacing: 0px;
  border: 0px
}
#app {
  font-family: 'Ubuntu', sans-serif;
  /*font-family: 'Avenir', Helvetica, Arial, sans-serif;*/
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#nav {
  padding: 5px;
  font-size: 9pt;
}
#pricelist {
  font-size: 10pt;
}
#nav a {
  /*// font-weight: bold;*/
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
  font-weight: bold;
}
body {
  font-family: 'Ubuntu', sans-serif;
}
input, select, textarea {
  font-size: 100%;
}
</style>

<script>

import Login from './controllers/auth/login.vue'

export default {
  components: { Login },
  data() {
    return {
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
