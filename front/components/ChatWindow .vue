<template>
  <div id="chat__window">
    <div v-if="messages" class="messages" ref="messages">
      <ul v-for="message in messages" :key="message.id">
        <!--received or sent-->
        <li
          :class="{
            received: message.email !== uid,
            sent: message.email === uid,
          }"
        >
          <span class="name">{{ message.name }}</span>
          <span class="message">{{ message.content }}</span>
          <span class="created-at">{{ message.created_at }}前</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  //emits: ['connectCable'],
  props: ["messages"],

  data() {
    return {
      uid: '',
    };
  },
  methods: {
    scrollToBottom() {
      const element = this.$refs.messages;
      element.scrollTop = element.scrollHeight;
    }
  },
  mounted() {
    if (localStorage.uid) {
      this.name = localStorage.uid;
    }
  },
};
</script>
<style scoped lang="scss">
#chat__window {
  background: white;
  padding: 30px 20px;
  border-bottom: 1px solid #eee;

  ul {
    list-style: none;
    margin: 0;
    padding: 0;

    li {
      display: inline-block;
      clear: both;
    }
  }

  .message {
    padding: 10px 20px;
    display: inline-block;
    border-radius: 30px;
    margin-bottom: 2px;
    max-width: 400px;
    font-size: 14px;
  }

  .received {
    float: left;

    .message {
      background: #eee;
    }
  }
  .sent {
    float: right;

    .message {
      background: #677bb4;
      color: white;
    }
  }
  .name {
    position: relative;
    margin-right: 6px;
    display: block;
    font-size: 13px;
  }
  .created-at {
    display: block;
    color: #999;
    font-size: 12px;
    margin-bottom: 20px;
    margin-left: 4px;
  }
  .messages {
    max-height: 400px;
    overflow: auto;
  }
}
</style>
