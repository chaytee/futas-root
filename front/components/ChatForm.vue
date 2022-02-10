<template>
  <div class="chat-form wife">
    <div class="chat-form__in">
      <form class="chat-form__form">
        <div class="priority-box">
          <p class="nm priority-box__txt">
            メッセージの緊急レベルを選んでください。
          </p>
          <div class="control has-icons-left">
            <div class="select is-large is-danger">
              <select v-model="selected">
                <option
                  v-for="(option, key) in options"
                  v-bind:value="option.value"
                  :key="key"
                >
                  {{ option.text }}
                </option>
              </select>
            </div>
            <span class="icon is-medium is-left">
              <font-awesome-icon icon="skull-crossbones" />
            </span>
          </div>
        </div>
        <textarea
          class="textarea is-large"
          rows="2"
          placeholder="メッセージ"
          v-model="message"
        ></textarea>
        <div class="btn__area">
          <button
            class="btn__grade"
            type="submit"
            @click.prevent="handleSubmit"
          >
            送信
          </button>
          <button class="btn__clear" type="submit" @click.prevent="inputCrea">
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
      selected: "1",
      options: [
        { text: "レベル1", value: 1 },
        { text: "レベル２", value: 2 },
        { text: "レベル３", value: 3 },
      ],
    };
  },
  methods: {
    handleSubmit() {
      this.$emit("connectCable", this.message, this.selected);

      this.message = "";
      this.selected = "";
    },
    inputCrea() {
      this.message = "";
      return;
    },
  },
};
</script>
<style scoped lang="scss">
.chat-form {
  padding: 20px 0;
  box-sizing: border-box;
  @include ta {
    padding: 15px 0;
  }
  @include sm {
    min-height: 226px;
  }

  &__in {
    padding: 20px;
    background-color: #fff;
    box-sizing: border-box;

    @include sm {
      width: 100%;
      height: 226px;
      position: fixed;
      bottom: 0;
      left: 0;
      z-index: 9;
    }
  }

  .priority-box {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    margin-bottom: 10px;

    @include sm {
      display: block;
    }

    &__txt {
      margin-right: 20px;

      @include sm {
        font-size: 12px;
        margin-right: 0;
        margin-bottom: 5px;
      }
    }
  }
  &__form {
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
      border: 1px solid #ddd;
    }
  }

  .select.is-large {
    @include sm {
      font-size: 12px;
    }
  }
  .control.has-icons-left .icon {
    @include sm {
      max-height: 27px;
    }
  }
  .btn__area {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px;

    @include sm {
      margin-top: 10px;
    }

    .btn__grade {
      margin-right: 25px;

      @include sm {
        margin-right: 15px;
      }
    }
  }
}
</style>
