<template>
  <div id="chat" class="wife">
    <div class="box pt-3 chat__box">
      <form class="chat__form">
        <textarea
          class="textarea is-large"
          rows="3"
          placeholder="メッセージ"
          v-model="message"
        ></textarea>
        <div class="btn__area">
          <button class="btn__link" type="submit" @click.prevent="handleSubmit">
            送信
          </button>
          <button
            class="btn__link btn__clea"
            type="submit"
            @click.prevent="inputCrea"
          >
            クリア
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
export default {
  emits: ["connectCable"],

  data() {
    return {
      message: "",
    };
  },
  methods: {
    handleSubmit() {
      this.$emit("connectCable", this.message);
      this.message = "";
    },
    inputCrea() {
      this.message = "";
      return;
    },
  },
};
</script>
<style scoped lang="scss">
#chat {
  &__form {
    max-width: 500px;
    box-sizing: border-box;
    padding: 20px;
    margin: auto;

    textarea {
      width: 100%;
      max-width: 100%;
      margin-bottom: 6px;
      padding: 10px;
      box-sizing: border-box;
      border: 0;
      border-radius: 20px;
      font-family: inherit;
      outline: none;
    }
  }
  .btn__area {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;

    .btn__clea {
      background-color: #ccc;
    }
    .btn__link + .btn__link {
      margin-left: 30px;
    }
  }
  .wife .chat__box {

  }
}
</style>
