<template>
  <section class="section-pt">
    <h2 class="section-title">chatroom</h2>
    <ChatWindow
      @connectCable="connectCable"
      :messages="formattedMessages"
      ref="chatWindow"
    />
    <ChatForm @connectCable="connectCable" />
  </section>
</template>

<script>
import ChatWindow from "../components/ChatWindow .vue";
import ChatForm from "../components/ChatForm.vue";
//import ActionCable from "actioncable";
import { formatDistanceToNow } from "date-fns";
import { ja } from "date-fns/locale";

//ssrのため読み込み方法を変更する
let ActionCable = process.browser ? require("actioncable") : undefined;

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
        const res = await this.$axios.get("/api/users/messages", {
          headers: {
            uid: window.localStorage.getItem("uid"),
            "access-token": window.localStorage.getItem("access-token"),
            client: window.localStorage.getItem("client"),
          },
        });
        if (!res) {
          new Error("メッセージ一覧を取得できませんでした");
        }
        console.log(res);
        this.messages = res.data;
      } catch (err) {
        console.log(err);
      }
    },
    connectCable(...args) {
      console.log(args);
      const [message, selected] = args;

      this.messageChannel.perform("receive", {
        message: message,
        priority: selected,
        email: window.localStorage.getItem("uid"),
      });
    },
  },
  computed: {
    formattedMessages() {
      //messeagesがからの場合
      if (!this.messages.length) {
        return [];
      }
      //変換
      return this.messages.map((message) => {
        let time = formatDistanceToNow(new Date(message.created_at), {
          locale: ja,
        });
        return { ...message, created_at: time };
      });
    },
  },
  mounted() {
    const cable = ActionCable.createConsumer("ws://localhost:3000/cable");
    this.messageChannel = cable.subscriptions.create("RoomChannel", {
      connected: () => {
        this.getMessages().then(() => {
          this.$refs.chatWindow.scrollToBottom();
        });
      },
      received: () => {
        this.getMessages().then(() => {
          this.$refs.chatWindow.scrollToBottom();
        });
      },
    });
  },
  beforeUnmount() {
    this.messageChannel.unsubscribe();
  },
};
</script>
