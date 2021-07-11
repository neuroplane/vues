<template>
  <v-container>
    <v-textarea
        clearable
        dense
        auto-grow
        v-model="tsvdata"
        :value="tsvdata">
    </v-textarea>
    <v-btn @click="report_tsv()">REPORT TSV</v-btn>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      tsvdata: null,
      tsv_res: null
    }
  },
  computed: {

  },
  beforeMount() {

  },
  created() {

  },
  methods: {
    tsvJSON(tsv) {
      console.log('OK')
      const lines = tsv.split('\n');
      console.log(lines)
      const headers = lines.slice(0, 1)[0].split('\t');
      return lines.slice(1, lines.length).map(line => {
        const data = line.split('\t');
        return headers.reduce((obj, nextKey, index) => {
          obj[nextKey] = data[index];
          return obj;
        }, {});
      });

    },
    report_tsv() {
      console.log(this.tsvdata)
      this.tsv_res = this.tsvJSON(this.tsvdata)
      alert(JSON.stringify(this.tsv_res))
    },
  },

  name: "Inputdata"
}
</script>

<style scoped>

</style>