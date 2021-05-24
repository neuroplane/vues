<template>
  <v-app-bar dense app>
    <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
  </v-app-bar>
</template>

<script>
export default {
  data() {
    return {
      items: [
        { title: 'Home', icon: 'mdi-home', url: 'home' },
        { title: 'Main', icon: 'mdi-credit-card-outline', url: 'main' },
        { title: 'None', icon: 'mdi-help-box', url: '' },
        { title: 'Ktu', icon: 'mdi-file-table-box-multiple', url: 'ktu' },
        { title: 'Users', icon: 'mdi-account-group', url: 'users' }
      ],
      right: null,
      show_reg: false,
      token: null,
      user: null,
      drawer: false,
      group: null,
    }
  },
  name: "Appbar",
  methods:{
    doLogout() {
      this.Console.log('LOGOUT SIMULATION')
    },
    switch(){
      this.drawer = true
    }
  }
}
</script>

<style scoped>

</style>
