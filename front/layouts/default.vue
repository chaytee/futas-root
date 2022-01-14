<template>
  <div>
    <Navbar />
    <div class="container" id="container">
      <nuxt />
    </div>
    <Footer />
  </div>
</template>
<script>
//import '@/assets/css/common.css'
import Navbar from '../components/Navbar.vue';
import Footer from '../components/Footer.vue'

export default {
  components: {
    Navbar,
    Footer,
  }
}
</script>
