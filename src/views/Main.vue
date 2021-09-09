<template>
  <v-container class="col-xl-8 offset-xl-2">
    <v-text-field class="mb-5"
        v-model="search"
        append-icon="mdi-magnify"
        label="Поиск"
        single-line
        hide-details
                  dense
                  clearable

    ></v-text-field>
    <v-data-table
        :headers="headers"
        :items="workingUsers"
        :items-per-page="10"
        :search="search"

        hide-default-header
        class="elevation-1"
        dense
        mobile-breakpoint="300"
        v-if="this.workingUsers.length"
        @click:row="row_click"
        :footer-props="{
          disableItemsPerPage: true,
          itemsPerPageAllText: ''}"
    >

    </v-data-table>
    <div class="text-center">
      <v-dialog
          v-if="this.user_data && this.user_data.surname"
          v-model="zp_dialog"
          width="500"
          overlay-opacity="0.95"
          overlay-color="#111111"
      >
        <v-card>
          <v-card-title
              v-if="this.user_data">
            {{ user_data.surname + " " + user_data.name}}
          </v-card-title>
          <v-card-subtitle>{{ user_data.role_id_ru}}, {{user_data.month_ru_small}}, {{user_data.period_year}}</v-card-subtitle>
          <v-card-title
              v-if="!this.user_data">
            Данных нет
          </v-card-title>
          <v-card-text
              v-if="this.user_data">
            <v-simple-table style="font-family: monospace; font-size: 10px" class="mb-5"  dense>
              <tbody>
              <tr v-if="user_data.month_standard">
                <td style="width: 60%">Норма часов</td>
                <td style="text-align: right">{{ user_data.hours}} / {{ user_data.month_standard}}</td>
              </tr>
              <tr v-if="user_data.salary">
                <td>Оклад</td>
                <td style="text-align: right">{{ user_data.salary}}</td>
              </tr>

              </tbody>
            </v-simple-table>
            <v-simple-table style="font-family: monospace; font-size: 10px" class="my-5"  dense>
              <tbody>

              <tr v-if="user_data.ktu">
                <td style="width: 60%">КТУ</td>
                <td style="text-align: right">{{ user_data.ktu}}</td>
              </tr>
              <tr v-if="user_data.nachisleno">
                <td>Начислено</td>
                <td style="text-align: right">{{ user_data.nachisleno}}</td>
              </tr>
              <tr v-if="user_data.accrualbonus">
                <td>Бонус</td>
                <td style="text-align: right">{{ user_data.accrualbonus}}</td>
              </tr>
              <tr v-if="user_data.shifts">
                <td>Смены</td>
                <td style="text-align: right">{{ user_data.shifts}}</td>
              </tr>
              <tr v-if="user_data.change">
                <td>Замещения</td>
                <td style="text-align: right">{{ user_data.change}}</td>
              </tr>
              <tr v-if="user_data.bonus">
                <td>Поощрения</td>
                <td style="text-align: right">{{ user_data.bonus}}</td>
              </tr>
              <tr v-if="user_data.correction">
                <td>Коррекция</td>
                <td style="text-align: right">{{ user_data.correction }}</td>
              </tr>
              <tr v-if="user_data.dop">
                <td>Доп</td>
                <td style="text-align: right">{{ user_data.dop }}</td>
              </tr>
              <tr>
                <td style="width: 60%">ИТОГО</td>
                <td style="text-align: right">{{user_data.nachisleno + user_data.change + user_data.correction + user_data.dop + user_data.accrualbonus + user_data.bonus}}</td>
              </tr>
              </tbody>
            </v-simple-table>
            <!-------------->
            <v-simple-table style="font-family: monospace; font-size: 10px" class="mt-5"  dense>
              <tbody>

              <tr v-if="user_data.fine">
                <td>Штрафы</td>
                <td style="text-align: right">{{ user_data.fine}}</td>
              </tr>

              <tr v-if="user_data.ndfl">
                <td>НДФЛ</td>
                <td style="text-align: right">{{ user_data.ndfl}}</td>
              </tr>
              <tr v-if="user_data.aliments">
                <td>Алименты</td>
                <td style="text-align: right">{{ user_data.aliments}}</td>
              </tr>
              <tr v-if="user_data.bank">
                <td>На карту</td>
                <td style="text-align: right">{{ user_data.bank }}</td>
              </tr>
              <tr>
                <td style="width: 60%">Налоги итого</td>
                <td style="text-align: right">{{user_data.taxes}}</td>
              </tr>
              <tr v-if="user_data.credit">
                <td>Авансы</td>
                <td style="text-align: right">{{ user_data.credit}}</td>
              </tr>

              </tbody>
            </v-simple-table>
          </v-card-text>


          <v-divider></v-divider>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
                color="primary"
                text
                @click="zp_dialog = false
                user_data = []"
            >
              Закрыть
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
    <!------->
  </v-container>
</template>

<script>
export default {
  name: "Main.vue",
  data() {
    return {
      zp_dialog: false,
      user_data: [],
      workingUsers: [],
      search: '',
      headers: [
        { text: 'Сотрудник', value: 'fio' },
        //{ text: 'С', value: 'ktu_sum' },
        //{ text: 'Ш', value: 'ktu_amount' },
        //{ text: 'Стр', value: 'ktu_lines' },
        //{ text: 'Ч', value: 'ktu_documents' }
      ]
    }
  },
  methods: {
    async get_individual_data(selected_user){
      this.user_data = await this.$api.post('individualzp',{
        "report_date" : this.$storage.state.report_date,
        "month": this.$storage.state.month_date,
        "year" : this.$storage.state.year_date,
        "selected_user" : selected_user
      })
      console.log(this.user_data)
    },
    row_click(item){
      this.zp_dialog = true
      this.get_individual_data(item.id)
      //alert(item.fio + " " + item.birthday)
    },
    async get_ktu() {
      console.log('get_ktu func from Main')
      this.workingUsers = await this.$api.post('getworkingusers',{"report_date" : "2021-05-01", "year": this.$storage.state.calYear, "month": this.$storage.state.calMonth})
      console.log(this.workingUsers)
    }
  },
  beforeMount(){
    this.get_ktu()
  },
}

</script>

<style scoped>

</style>