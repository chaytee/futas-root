<template>
<no-ssr>
  <section class="container">
    <p>chatroom</p>
    <ChatWindow @connectCable="connectCable" :messages="formattedMessages" ref="chatWindow" />
    <ChatForm @connectCable="connectCable" />
  </section>
</no-ssr>
</template>

<script>
import ChatWindow from "../components/ChatWindow .vue";
import ChatForm from "../components/ChatForm.vue";
import ActionCable from "actioncable";
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'

export default {
  components: { ChatWindow, ChatForm },

  data() {
    return {
      messages: [],
    };
  },
  methods: {
    async getMessages() {
      try {
        const res = await this.$axios.get("/messages", {
          headers: {
            uid: window.localStorage.getItem("uid"),
            "access-token": window.localStorage.getItem("access-token"),
            client: window.localStorage.getItem("client"),
          },
        });
        if (!res) {
          new Error("メッセージ一覧を取得できませんでした");
        }
        console.log({ res });
        this.messages = res.data;
      } catch (err) {
        console.log(err);
      }
    },
    connectCable (message) {
      this.messageChannel.perform('receive', {
        message: message,
        email: window.localStorage.getItem('uid')
      })
    }
  },
  computed: {
    formattedMessages () {
      //messeagesがからの場合
      if (!this.messages.length) { return [] }
      //変換
      return this.messages.map(message => {
        let time = formatDistanceToNow(new Date(message.created_at), { locale: ja })
        return { ...message, created_at: time }
      })
    }
  },
  mounted() {
    const cable = ActionCable.createConsumer("ws://localhost:3000/cable");
    this.messageChannel = cable.subscriptions.create("RoomChannel", {
      connected: () => {
        this.getMessages().then(() => {
          this.$refs.chatWindow.scrollToBottom()
        })
      },
      received: () => {
        this.getMessages().then(() => {
          this.$refs.chatWindow.scrollToBottom()
        })

      },
    });
  },
  beforeUnmount() {
    this.messageChannel.unsubscribe();
  },
};
</script>
