<template>
  <div class="wrap default-type">
    <Navbar />
    <div class="container" id="container" v-bind:class="{ husband: isHusbandIcon }">
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
  },
  data() {
    return {
      isHusbandIcon: false,
    };
  },
  async mounted() {
    //this.$api.getGender();
    await this.$axios.$get("/api/user/?id").then((res)=> {
      this.genderData = res.gender;
      //性別が男だったらhusbandをつける
      if(this.genderData === 1 ) {
         return this.isHusbandIcon = !this.isHusbandIcon;
      }
    });
  },
}
</script>
<style lang="scss">
  .default-type #footer {
    @include sm {
      display: none;
    }
  }
</style>
