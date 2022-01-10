<template>
  <div id="signup">
    <div class="btn__wrap"><button class="btn__link modal-show" @click="modalShow">アカウントを登録する</button></div>
    <transition name="modal">
      <div class="modal is-active" v-if="isShow">
        <div class="modal-background" @click="modalClose"></div>
        <div class="modal-content">
          <div class="box p-4">
            <h2 class="welcome__title cen mb-5">アカウントを登録する</h2>
            <form>
              <input class="input mb-4" type="email" required placeholder="メールアドレス" v-model="email">
              <input class="input mb-4" type="email" required placeholder="メールアドレス" v-model="email">
              <input class="input mb-4" type="password" required placeholder="パスワード" v-model="password">
            </form>
            <div class="btn__wrap"><button class="btn__link">登録する</button></div>
          </div>
        </div>
        <button class="modal-close" @click="modalClose">×</button>
      </div>
    </transition>
  </div>
</template>
<script>
  export default {
    data () {
      return {
        email: '',
        password: '',
        isShow: false,
      }
    },
    methods: {
        modalShow() {
      this.isShow = true
    },
    modalClose() {
      this.isShow = false
    }
  }
}
</script>
