<template>
  <v-container v-if="$storage.state.user" >
    <v-row justify="center">
      <v-date-picker
          v-model="picker"
          type="month"
      ></v-date-picker>
    </v-row>
  </v-container>
</template>
<script>
export default {
  name: "About",
  data() {
    return {
      picker: new Date().toISOString().substr(0, 10),
    }
  }
}
</script>
