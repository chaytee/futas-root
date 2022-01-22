<template>
  <div id="signup">
    <div class="btn__wrap"><button class="btn__grade modal-show" @click="modalShow">アカウントを登録する</button></div>
    <transition name="modal">
      <div class="modal is-active" v-if="isShow">
        <div class="modal-background" @click="modalClose"></div>
        <div class="modal-content">
          <div class="box p-4">
            <h2 class="welcome__title cen mb-5">アカウントを登録する</h2>
            <div class="error cen">{{ error }}</div>
            <form @submit.prevent="signUp" class="form__box">
              <input class="input mb-4 is-medium" type="text" required placeholder="名前" v-model="name">
              <div class="control gender mb-3">
                <label class="radio">
                  <input type="radio" name="gender" value="1" v-model="gender" required >
                  <span class="gender__title ml-2">夫</span>
                </label>
                <label class="radio">
                  <input type="radio" name="gender" value="2" v-model="gender">
                  <span class="gender__title ml-2">妻</span>
                </label>
              </div>
              <input class="input mb-4 is-medium" type="email" required placeholder="メールアドレス" v-model="email">
              <input class="input mb-4 is-medium" type="password" required placeholder="パスワード" v-model="password">
              <input class="input mb-4 is-medium" type="password" required placeholder="パスワード（確認用）" v-model="passwordConfirmation">
              <div class="btn__wrap"><button class="btn__grade" type="submit">登録する</button></div>
            </form>
          </div>
        </div>
        <div class="error">{{ error }}</div>
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
        name: '',
        email: '',
        password: '',
        gender: '',
        passwordConfirmation: '',
        isShow: false,
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

        async signUp () {
          this.error = null

          try{
            //axiosでアクセス
            const res = await this.$axios.post('api/auth',{
                name: this.name,
                email: this.email,
                gender: this.gender,
                password: this.password,
                password_confirmation: this.password_confirmation
            })
            //ローカルストレージへ
            await this.$auth.loginWith('local', {
              data: {
                password: this.password,
                email: this.email
              },
            })
            if (!res) {
              throw new Error('アカウントを登録できませんでした')
            }

            this.$router.push("/relationship");

          }catch(error){
            console.log(error.response.data.errors.full_messages);
            //this.error = e.response.data.errors.full_messages;
            this.error = 'アカウントを登録できませんでした'
            return
          }


        // try {
        //     const res = await this.$axios.post('/auth/', {
        //       name: this.name,
        //       email: this.email,
        //       gender: this.gender,
        //       password: this.password,
        //       password_confirmation: this.passwordConfirmation
        //       }
        //     )
        //     if (!res) {
        //       throw new Error('アカウントを登録できませんでした')
        //     }
        //     if (!this.error) {
        //       setItem(res.headers, res.data.data.name)

        //       this.$emit('redirectToRelationship')
        //     }
        //     return res
        //   }
        //   catch (error) {
        //     this.error = 'アカウントを登録できませんでした'
        //     return
        //   }
        }
    }
}
</script>
<style lang="scss">
  #signup {
    .gender {
        display: flex;
        justify-content: flex-start;
      .radio {
        display: flex;
        justify-content: flex-start;
        align-items: center;}
    }
    .radio+.radio {
      margin-left: 15px;
    }
  }
</style>
