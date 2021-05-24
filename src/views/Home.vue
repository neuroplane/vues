<template>
  <div v-if="!this.$storage.state.user" class="home">
    <img alt="Vue logo" src="../assets/logo.png">

  </div>
</template>

<script>

export default {
  //все переменные сохраняются в $storage.state и вотчаются вью, если что-то поменяется, то сразу перерисуется представление
  name: 'Home',
  components: {

  }
}
</script>
