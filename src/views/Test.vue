<template>
  <v-container class="col-xl-4 offset-xl-4">
    <p>TEST</p>
  </v-container>
</template>

<script>
export default {
  name: "Test.vue",
  data() {
    return {
      foo: false,
      editZpDialog: false,
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