<template>

      <v-navigation-drawer v-model="drawer"
                           absolute
                           temporary app>

        <v-list
            dense
            nav
        >
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
name: "Navigation",
  methods:{
    doLogout() {
      this.Console.log('LOGOUT SIMULATION')
    },
  }
}
</script>

<style scoped>

</style>
