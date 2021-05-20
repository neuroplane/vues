<template>

    <v-container>
      <h2>Вход</h2>
        <v-text-field type="text" placeholder="логин" v-model="login"></v-text-field>
        <v-text-field type="password" placeholder="пароль" v-model="password"></v-text-field>
        <v-btn @click="doLogin()" variant="primary" class="btn btn-sm btn-primary btn-block">Вход</v-btn>
        <v-alert variant="danger" v-if="alert" show><small>{{this.alertmessage}}</small></v-alert>
    </v-container>

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
        this.$router.push('/main')
      } catch (e) {
        this.alertmessage = e.message
        this.alert = true
        console.log(e.message)
      }
    }

  }

}
</script>
