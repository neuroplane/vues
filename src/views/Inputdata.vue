<template>
  <v-container class="text-center">
    <h4 v-if="!function_name">ВВОД ДАННЫХ</h4>
    <h4 v-if="function_name_rus !=null">{{function_name_rus}}</h4>
    <v-textarea v-if="function_name"
        outlined
        clearable
        dense
        auto-grow
        v-model="tsvdata"
        :value="tsvdata">
    </v-textarea>
    <v-btn block v-if="function_name !=null && tsvdata != null" @click="send_func(function_name)">ОТПРАВИТЬ</v-btn>
    <v-btn block v-if="function_name !=null && tsvdata == null" @click="function_name = null; function_name_rus = null">НАЗАД</v-btn>
    <v-container v-if="!function_name" class="text-center">
      <div :key="button.functionname" class="text-center d-inline-block" v-for="button in buttons">
        <v-btn plain class="mx-1 my-2" @click="insert_func(button.functionname, button.rusname)">{{button.rusname}}</v-btn>
      </div>
    </v-container>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      hidden_els: true,
      tsvdata: null,
      tsv_res: null,
      ktu_data: null,
      function_name: null,
      function_name_rus: null,
      buttons: [
        {functionname: 'ktu', rusname: "КТУ*"},
        {functionname: 'finesbonuses', rusname: "ШИБ*"},
        {functionname: 'taxes', rusname: "НАЛОГИ*"},
        {functionname: 'credit', rusname: "АВАНСЫ*"},
        {functionname: 'extra', rusname: "НАДБАВКИ*"},
        {functionname: 'constants', rusname: "КОНСТАНТЫ"},
        {functionname: 'workhours', rusname: "ТАБЕЛЬ*"}
      ],
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
      const lines = tsv.split('\n');
      const headers = lines.slice(0, 1)[0].split('\t');
      return lines.slice(1, lines.length).map(line => {
        const data = line.split('\t');
        return headers.reduce((obj, nextKey, index) => {
          obj[nextKey] = data[index] == "" ? null : data[index];
          return obj;
        }, {});
      });
    },
    insert_func(fname, fnameru){
      this.function_name = fname
      this.function_name_rus = fnameru
      console.log(fnameru)
    },
    async send_func(func){
      this.tsv_res = this.tsvJSON(this.tsvdata)
      console.log(this.tsv_res.length)
      if (this.tsv_res.length < 1){
        alert("ОШИБКА: ПУСТЫЕ ДАННЫЕ")
      } else {
        //await this.$api.post('input_' + func,{
        await this.$api.post('input'+func,{
          items: this.tsv_res
        })
        console.log('FUNCTION: ' + func)
        this.tsvdata = null
        this.tsv_res = null
        this.function_name = null
        this.function_name_rus = null
      }

    },
  },

  name: "Inputdata"
}
</script>

<style scoped>

</style>