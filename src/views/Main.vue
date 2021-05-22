<template>
  <v-container >
    <v-btn v-if="!this.ktu_items.length" @click="get_ktu()">Click me</v-btn>
    <v-data-table
        :headers="headers"
        :items="ktu_items"
        :items-per-page="15"
        class="elevation-1"
        dense
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
        { text: 'Сумма', value: 'ktu_sum' },
        { text: 'Штуки', value: 'ktu_amount' },
        { text: 'Строки', value: 'ktu_lines' },
        { text: 'Чеки', value: 'ktu_documents' }
      ]
    }
  },
  methods: {
    async get_ktu() {
      this.ktu_items = await this.$api.post('overallktu',{"month" : 4})
      console.log(this.ktu_items)
    }
  }
}

</script>

<style scoped>

</style>