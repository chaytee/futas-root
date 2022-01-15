<template>
<div id="login">
  <div class="btn__wrap"><button class="btn__link modal-show" @click="modalShow">ログイン</button></div>
  <transition name="modal">
    <div class="modal is-active" v-if="isShow">
      <div class="modal-background" @click="modalClose"></div>
      <div class="modal-content">
        <div class="box p-4">
          <h2 class="welcome_title cen mb-5">ログイン</h2>
          <form @submit.prevent="login">
            <input class="input mb-4" type="email" required placeholder="メールアドレス" v-model="email">
            <input class="input mb-4" type="password" required placeholder="パスワード" v-model="password">
            <input type="password" required placeholder="パスワード（確認用）" v-model="passwordConfirmation">
            <div class="error">{{ error }}</div>
            <div class="btn__wrap"><button class="btn__link" type="submit">ログインする</button></div>
          </form>
        </div>
      </div>
      <button class="modal-close" @click="modalClose">×</button>
    </div>
  </transition>
</div>
</template>
<script>
  export default {
    emits: ['redirectToRelationship'],

    data () {
      return {
        email: '',
        password: '',
        isShow: false,
        passwordConfirmation: '',
        error: null
      }
    },
    methods: {
        modalShow() {
          this.isShow = true
        },
        modalClose() {
          this.isShow = false
        },
        async login() {
            try {
              this.error = null

              const res = await this.$axios.post('/auth/sign_in', {
                email: this.email,
                password: this.password,
                }
              )
              if (!res) {
                throw new Error('メールアドレスかパスワードが違います')
              }

              if (!this.error) {
                this.$emit('redirectToRelationship')
              }

              return res
            } catch (error) {
              console.log({ error })
              this.error = 'メールアドレスかパスワードが違います'
            }
        },
    }
  }
</script>
