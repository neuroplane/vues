<template>
  <v-container class="col-xl-4 offset-xl-4">
    <v-dialog
        v-model="testDialog"
        width="400"
        overlay-opacity="0.95"
        overlay-color="#111111"
    >
      <v-card>
        <v-card-title>
          Card title
        </v-card-title>
        <v-form>
          <v-container>
          <v-row>
            <v-col cols="6" xs="6" sm="6" md="6">
              <v-text-field clearable label="Дополнительно"></v-text-field>
            </v-col>
            <v-col cols="6" xs="6" sm="6" md="6">
              <v-text-field clearable label="Дополнительно"></v-text-field>
            </v-col>
          </v-row>
          </v-container>
        </v-form>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
export default {
  name: "Test.vue",
  data() {
    return {
      foo: false,
      testDialog: true,
      bar: []
    }
  },
  methods: {
    async updateExtra(userid, dop, correction, month, year){
      //user_data.id, user_data.dop, user_data.period_month, user_data.period_year
      console.log("UPDATING ITEMS: USER ID:" + userid + ", DOP: " + dop + ", CORRECTION: " + correction)
      await this.$api.post('updatecorrection', {'selected_user': userid, 'dop': dop, 'correction': correction, 'month': month, 'year': year})
      this.editZpDialog = false
    }
    ,
    async func() {
      console.log('func')
      this.foo = await this.$api.post('bar',{})
      console.log(this.foo)
    }
  },
  mounted() {
    this.func()
  },
  beforeMount(){

  },
}
</script>

<style scoped>

</style>