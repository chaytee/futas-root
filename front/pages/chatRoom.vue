<template>
  <section class="container">
    <p>chatroom</p>
      <ChatWindow :messages="messages" />
      <ChatForm />
  </section>
</template>

<script>
import ChatWindow from '../components/ChatWindow .vue';
import ChatForm from '../components/ChatForm.vue';


export default {
  components: { ChatWindow, ChatForm },

  data () {
    return {
      messages: [],
    }
  },
  methods: {
    async getMessages () {
      try {
        const res = await this.$axios.$get('/messages', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client:window.localStorage.getItem('client')
          }
        })
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.messages = res.data
      } catch (err) {
        console.log(err)
      }
    },
  },
  mounted() {
    this.getMessages()
  },

}
</script>
