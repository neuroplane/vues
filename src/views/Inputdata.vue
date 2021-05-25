<template>
  <div>
  <v-card v-for="item in got_users" :key="item.userid"
      class="mx-auto"
      max-width="344"
  >

    <v-card-title>
      {{ item.surname }}
    </v-card-title>

    <v-card-subtitle>
      {{ item.name }}
    </v-card-subtitle>

    <v-card-actions>
      <v-btn
          color="orange lighten-2"
          text
      >
        Раскрыть
      </v-btn>

      <v-spacer></v-spacer>

      <v-btn
          icon
          @click="show = !show"
      >
        <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
      </v-btn>
    </v-card-actions>

    <v-expand-transition>
      <div v-show="show">
        <v-divider></v-divider>

        <v-card-text>
          {{item.birthday}}
        </v-card-text>
      </div>
    </v-expand-transition>
  </v-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      got_users: [],
      show: false
    }
  },
  computed: {

  },
  beforeMount() {
    this.get_users()
  },
  methods: {
    async get_users() {
      this.got_users = await this.$api.post('getusers',{"month" : 4})
      console.log(this.got_users)
    },
  },

  name: "Inputdata"
}
</script>

<style scoped>

</style>