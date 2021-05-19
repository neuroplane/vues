<template>
  <div class="px-5">
    <h2>Вход</h2>
    <v-container>
      <v-row class="mb-6" no-gutters>
        <v-col md="6" offset-lg="6" offset-xl="6">
        <v-text-field type="text" placeholder="логин" v-model="login"></v-text-field>
        <v-text-field type="password" placeholder="пароль" v-model="password"></v-text-field>
        <v-btn @click="doLogin()" variant="primary" class="btn btn-sm btn-primary btn-block">Вход</v-btn>
        <v-alert variant="danger" v-if="alert" show><small>{{this.alertmessage}}</small></v-alert>
        </v-col>
      </v-row>
    </v-container>

  </div>
</template>

<script> export default {
  data() {
    return {
      chartShow: false,
      alert: false,
      alertmessage: null,
      login: null,
      password: null,

      options: {
      },

      series: [{
        name: 'solved',
        data: []
      }]
    }

  },
  mounted(){

  },
  beforeMount(){
    //this.getstats()
  },
  methods: {
    async doLogin() {
      try {
        const res = await this.$api.post('login', {
          login: this.login,
          password: this.password
        }, { skipTokenCheck: true })
        this.$cookie.set('token', res.token)
        this.$emit('done')
        this.$router.push('/goals')
      } catch (e) {
        this.alertmessage = e.message
        this.alert = true
        console.log(e.message)
      }
    }

  }

}
</script>
