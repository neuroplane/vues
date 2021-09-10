<template>
  <v-container class="col-sm-4 offset-sm-4 col-md-4 offset-md-4 col-lg-4 offset-lg-4" v-if="$storage.state.user" >


    <v-list dense v-bind:key="name" v-for="(value, name) in tableStats">
      <v-list-item>
        <v-list-item-icon><v-icon color="green darken-2" v-if="value">mdi-check</v-icon></v-list-item-icon>
        <v-list-item-content>{{ name }}</v-list-item-content>
      </v-list-item>
    </v-list>
    <v-btn plain block tile @click="get_tables()">ОБНОВИТЬ</v-btn>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    tableStats: null,
  }),

  computed: {

  },

  methods: {
    async get_tables() {
      this.tableStats = await this.$api.post('checktables',{"month":this.$storage.state.calMonth, "year" : this.$storage.state.calYear})
      console.log(this.tableStats)
    },

  },
  initialize () {

  },
  mounted() {

  },
  beforeMount() {
    //this.get_tables()
  },
  name: "About"
}
</script>
