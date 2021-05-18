<template>
  <div class="px-5">
    <h2>Вход</h2>

    <form class="">
      <div class="form-group">
        <input class="form-control form-control-sm text-center" type="text" placeholder="логин" v-model="login">
      </div>
      <div class="form-group">
        <input class="form-control form-control-sm text-center" type="password" placeholder="пароль"
               v-model="password">
      </div>
      <div class="form-group"><b-button @click="doLogin()" variant="primary" class="btn btn-sm btn-primary btn-block">Вход</b-button></div>
      <hr>
      <b-alert variant="danger" v-if="alert" show><small>{{this.alertmessage}}</small></b-alert>
    </form>


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
        const res = await this.$api.get('login', {
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
