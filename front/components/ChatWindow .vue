<template>
  <div class="chat-window">
    <div v-if="messages" class="messages" ref="messages">
      <ul v-for="message in messages" :key="message.id">
        <!--received or sent-->
        <li
          class="talk"
          :class="{
            sent: message.email !== uid,
            received: message.email === uid,
          }"
        >
          <span class="name">{{ message.name }}</span>
          <span
            class="message"
            id="priority"
            v-bind:class="
              message.priority === 2
                ? mediumDanger
                : message.priority === 3
                ? largeDanger
                : ''
            "
            >{{ message.content }}</span
          >
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
      uid: "",
      mediumDanger: {
        "medium-danger": true,
      },
      largeDanger: {
        "large-danger": true,
      },
    };
  },
  methods: {
    scrollToBottom() {
      const element = this.$refs.messages;
      element.scrollTop = element.scrollHeight;
    },
  },
  mounted() {
    if (localStorage.uid) {
      return (this.uid = localStorage.uid);
    }
  },
};
</script>
<style scoped lang="scss">
.chat-window {
  background: white;
  padding: 30px 20px;
  border-bottom: 1px solid #eee;

  @include sm {
    padding: 20px 15px;
  }

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
    position: relative;
    background: #fde6e3;
    &::before {
      content: "";
      position: absolute;
      top: -5px;
      left: 0;
      border-style: solid;
      transform: rotate(-55deg);
      border-width: 0 5px 15px 5px;
      border-color: transparent transparent #fde6e3 transparent;
      z-index: 1;
    }
  }
  .message.medium-danger {
    font-size: 18px;
    color: #eb0000;
  }
  .message.large-danger {
    font-size: 22px;
    color: #fff;
    background: #eb0000;
  }
  .message.large-danger {
    &::before {
      border-color: transparent transparent #eb0000 transparent;
    }
  }
  .talk {
    position: relative;

    &::before {
      content: "";
      width: 40px;
      height: 40px;
      display: flex;
      justify-content: center;
      align-items: center;
      position: absolute;
      z-index: 2;
    }
  }
  //右側
  .talk.received {
    float: left;
    padding-left: 45px;
    &::before {
      content: "";
      top: 0;
      left: 0;
      background: url(/_nuxt/assets/img/icon01.png) no-repeat center/100% auto;
    }
  }
  //左側
  .talk.sent {
    float: right;
    padding-right: 45px;
    &::before {
      content: "";
      top: 0;
      right: 0;
      background: url(/_nuxt/assets/img/icon02.png) no-repeat center/100% auto;
    }

    .message {
      background: #eee;

      &::before {
        left: auto;
        right: 0;
        transform: rotate(55deg);
        border-color: transparent transparent #eee transparent;
      }
    }
    .message.large-danger {
      background: #eb0000;
    }
    .message.large-danger {
      &::before {
        border-color: transparent transparent #eb0000 transparent;
      }
    }
  }
  .name {
    position: relative;
    margin-bottom: 3px;
    display: block;
    font-size: 13px;
  }
  .created-at {
    display: block;
    color: #999;
    font-size: 10px;
    margin-bottom: 20px;
    margin-left: 4px;
  }
  .messages {
    max-height: 400px;
    overflow: auto;
  }
}
.husband {
  .chat-window {
    .message {
      &::before {
        top: -5px;
        left: 0;
        border-style: solid;
        transform: rotate(-55deg);
        border-color: transparent transparent #d9ebe7 transparent;
      }
    }
    .message.large-danger {
      &::before {
        border-color: transparent transparent #eb0000 transparent;
      }
    }

    .talk.received {
      &::before {
        background-image: url(/_nuxt/assets/img/icon02.png);
      }
      .message {
        background: #d9ebe7;
      }
      .message.medium-danger {
        font-size: 18px;
        color: #eb0000;
      }
      .message.large-danger {
        font-size: 22px;
        color: #fff;
        background: #eb0000;
      }
    }
    .talk.sent {
      &::before {
        background-image: url(/_nuxt/assets/img/icon01.png);
      }
    }
  }
}
</style>
