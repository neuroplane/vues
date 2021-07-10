<template>
  <v-container class="col-xl-8 offset-xl-2">
    <v-data-table
        :headers="headers"
        :items="workingUsers"
        :items-per-page="15"
        class="elevation-1"
        dense
        mobile-breakpoint="300"
        v-if="this.workingUsers.length"
        @click:row="row_click"
    >

    </v-data-table>
    <div class="text-center">
      <v-dialog
          v-model="zp_dialog"
          width="500"
      >
        <v-card>
          <v-card-title
              v-if="this.user_data">
            {{ user_data.surname + " " + user_data.name}}
          </v-card-title>
          <v-card-title
              v-if="!this.user_data">
            Данных нет
          </v-card-title>
          <v-card-text
              v-if="this.user_data">
            <v-simple-table dense>
              <tbody>
              <tr v-if="user_data.month_ru">
                <td>Месяц</td>
                <td>{{ user_data.month_ru}}</td>
              </tr>
              <tr v-if="user_data.role">
                <td>Роль</td>
                <td>{{ user_data.role}}</td>
              </tr>
              <tr v-if="user_data.hours">
                <td>Часы</td>
                <td>{{ user_data.hours}}</td>
              </tr>
              <tr v-if="user_data.shifts">
                <td>Смены</td>
                <td>{{ user_data.shifts}}</td>
              </tr>
              <tr v-if="user_data.change">
                <td>Замещения</td>
                <td>{{ user_data.change}}</td>
              </tr>
              <tr v-if="user_data.ktu">
                <td>КТУ</td>
                <td>{{ user_data.ktu}}</td>
              </tr>
              <tr v-if="user_data.fine">
                <td>Штрафы</td>
                <td>{{ user_data.fine}}</td>
              </tr>
              <tr v-if="user_data.bonus">
                <td>Поощрения</td>
                <td>{{ user_data.bonus}}</td>
              </tr>
              <tr v-if="user_data.ndfl">
                <td>НДФЛ</td>
                <td>{{ user_data.ndfl}}</td>
              </tr>
              <tr v-if="user_data.aliments">
                <td>Алименты</td>
                <td>{{ user_data.aliments}}</td>
              </tr>
              <tr v-if="user_data.bank">
                <td>На карту</td>
                <td>{{ user_data.bank }}</td>
              </tr>
              <tr v-if="user_data.credit">
                <td>Авансы</td>
                <td>{{ user_data.credit}}</td>
              </tr>
              <tr v-if="user_data.extra">
                <td>Надбавки</td>
                <td>{{ user_data.extra }}</td>
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
      this.workingUsers = await this.$api.post('getworkingusers',{"report_date" : this.$storage.state.report_date})
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