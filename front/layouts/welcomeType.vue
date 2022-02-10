<template>
  <div class="wrap">
    <div id="container" class="welcome-type">
      <nuxt />
    </div>
    <Footer />
  </div>
</template>
<script>
//import '@/assets/css/common.css'
import Footer from '../components/Footer.vue'

export default {
  components: {
    Footer,
  }
}
</script>
<style lang="scss">
  // #container.welcome-type {
  //   padding-top: 0;
  // }
</style>
