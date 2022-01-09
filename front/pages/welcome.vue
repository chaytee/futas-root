<template>
  <section class="welcome">
    <div class="box">
      <p>ようこそ！</p>
      <LoginForm />
    </div>
  </section>
</template>

<script>
import LoginForm from '../components/LoginForm.vue'
export default {
  layout: 'welcomeType',
  components: { LoginForm },
}
</script>

<style lang="scss">

</style>
