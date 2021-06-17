<template>
  <v-container >
    <v-data-table
        :headers="headers"
        :items="ktu_items"
        :items-per-page="15"
        class="elevation-1"
        dense
        mobile-breakpoint="300"
        v-if="this.ktu_items.length"
    ></v-data-table>
  </v-container>
</template>

<script>
export default {
  name: "Main.vue",
  data() {
    return {
      ktu_items: [],
      headers: [
        { text: 'ФИО', value: 'surname' },
        { text: 'С', value: 'ktu_sum' },
        { text: 'Ш', value: 'ktu_amount' },
        { text: 'Стр', value: 'ktu_lines' },
        { text: 'Ч', value: 'ktu_documents' }
      ]
    }
  },
  methods: {
    async get_ktu() {
      this.ktu_items = await this.$api.post('overallktu',{"month" : 4})
      console.log(this.ktu_items)
    }
  },
  beforeMount(){
    this.get_ktu()
  },
}

</script>

<style scoped>

</style>