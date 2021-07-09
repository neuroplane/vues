<template>
  <v-container v-if="$storage.state.user" >
    <v-btn @click="get_tables()">ОБНОВИТЬ</v-btn>
    <div v-bind:key="name" v-for="(value, name) in tableStats">
      <p >{{ name }}: {{ value }}</p>
    </div>
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
      this.tableStats = await this.$api.post('checktables',{"month":this.$storage.state.month_date, "year" : this.$storage.state.year_date})
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
