<template>
  <div v-if="this.$storage.state.token && this.$storage.state.token" class="home">
    <h4 align="center">HOME TEMPLATE</h4>

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
