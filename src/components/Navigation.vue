<template>
      <v-navigation-drawer permanent>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="title">
              Application
            </v-list-item-title>
            <v-list-item-subtitle>
              subtext
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list
            dense
            nav
        >
          <v-list-item
              v-for="item in items"
              :key="item.title"
              link
              :to="item.url"
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
          <v-divider></v-divider>
          <v-list-item
              v-for="item in exit_item"
              :key="item.title"
              link
              :to="item.url"
              @click="doLogout()"
          >
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>
                <a class="m-1" href="/" @click.prevent="doLogout()"> Выйти </a>
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
        { title: 'Home', icon: 'mdi-view-dashboard', url: 'home' },
        { title: 'Main', icon: 'mdi-image', url: 'main' },
        { title: 'None', icon: 'mdi-help-box', url: '' }
      ],
      exit_item:[
        { title: 'Exit', icon: 'mdi-exit-to-app', url: 'main' }
      ],
      right: null,
      show_reg: false,
      token: null,
      user: null,
      role: null,
      role_parent: null,
      role_child: null
    }
  },
name: "Navigation",
  methods:{
    doLogout() {
      this.$cookie.delete('token')
      this.user = null
      this.token = null
      this.$router.push({ name: 'Main' })
    },
  }
}
</script>

<style scoped>

</style>