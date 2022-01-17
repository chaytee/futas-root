<template>
  <div class="wrap">
    <div id="container">
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

</style>
