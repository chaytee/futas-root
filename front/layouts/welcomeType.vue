<template>
  <div class="wrap">
    <div id="container" class="welcome-type">
      <nuxt />
    </div>
    <Footer />
  </div>
</template>
<script>
import Footer from '../components/Footer.vue'

export default {
  components: {
    Footer,
  }
}
</script>
