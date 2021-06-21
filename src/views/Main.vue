<template>
  <v-container >
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
              v-if="this.user_data.length">
            {{ user_data[0].surname }}
          </v-card-title>

          <v-card-text
              v-if="this.user_data.length">
            <v-simple-table dense>
              <tbody>
              <tr v-if="user_data[0].hours">
                <td>Часы</td>
                <td>{{ user_data[0].hours}}</td>
              </tr>
              <tr v-if="user_data[0].ktu">
                <td>КТУ</td>
                <td>{{ user_data[0].ktu}}</td>
              </tr>
              <tr v-if="user_data[0].ndfl">
                <td>НДФЛ</td>
                <td>{{ user_data[0].ndfl}}</td>
              </tr>
              <tr v-if="user_data[0].credit">
                <td>Авансы</td>
                <td>{{ user_data[0].credit}}</td>
              </tr>
              <tr v-if="user_data[0].extra">
                <td>Надбавки</td>
                <td>{{ user_data[0].extra}}</td>
              </tr>
              </tbody>
            </v-simple-table>
          </v-card-text>
          <v-card-text
            v-if="!this.user_data.length">
            Данных нет
          </v-card-text>

          <v-divider></v-divider>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
                color="primary"
                text
                @click="zp_dialog = false"
            >
              I accept
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
        { text: 'ФИО', value: 'fio' },
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
      this.workingUsers = await this.$api.post('getworkingusers',{"report_date" : "2021-05-01"})
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