<template>
  <div class="task-form" :class="{ 'input-switch': inputSwitch }">
    <div class="btn__wrap input-btn">
      <button
        class="input-btn__link btn__grade"
        @click="inputSwitch = !inputSwitch"
      >
        {{ !inputSwitch ? "Misshionを入力する" : "閉じる" }}
      </button>
    </div>
    <div class="box input__box">
      <h2 class="section-title">Mission input</h2>
      <div class="error">{{ error }}</div>
      <form class="box__form">
        <div class="box__in">
          <div class="box__input">
            <input
              class="input is-large"
              label="title"
              type="text"
              placeholder="ミッションを入れてください"
              v-model="title"
            />
          </div>
          <div class="btn__wrap">
            <button class="btn__clear" type="button" @click="remove()">
              取り消す
            </button>
            <button class="btn__accent" @click.prevent="submit()">送信</button>
          </div>
        </div>
        <div class="limit">
          <h3 class="sub__title">Limit</h3>
          <div class="limit__box">
            <input
              class="input is-large put_day"
              type="text"
              required
              v-bind:id="datePick"
              v-model="defaultDate"
            />
            <input
              class="input is-large put_time"
              type="time"
              v-model="limit_time"
            />
          </div>
        </div>
      </form>
    </div>
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
import "flatpickr/dist/themes/confetti.css";
import "flatpickr/dist/flatpickr.min.css";

const flatpickr = require("flatpickr").default;

export default {
  //_id.vueからedit()用
  props: {
    //task-id
    taskId: {
      type: String,
      required: false,
      default: "",
    },
  },
  watch: {
    taskId(newValue) {
      this.taskId = newValue;
    },
  },
  data() {
    return {
      title: "",
      limit_day: "",
      limit_time: "",
      datetime: "",
      datePick: "datePick",
      error: null,
      inputSwitch: false,
    };
  },
  async created() {
    if (this.taskId) {
      await this.$axios.$get(`api/users/tasks/${this.taskId}`).then((res) => {
        this.title = res.title;
        this.limit_day = res.limit_day;
        this.limit_time = res.limit_time;
      });
    }
  },
  methods: {
    submit() {
      const params = {
        task: {
          title: this.title,
          limit_day: this.limit_day,
          limit_time: this.limit_time,
        },
      };
      //新規であれば新規フォームへ既にtask-idのあるものは編集フォームへ
      this.taskId ? this.update(params, this.taskId) : this.create(params);
    },
    remove() {
      this.title = "";
      this.limit_day = "";
      this.limit_time = "";
    },
    create(params) {
      this.$axios
        .post("/api/users/tasks", params)
        .then((res) => {
          if (params) {
            const errorMessage = `
            下記の部分を確認してください. \n
            タイトル: ${params.task.title}
            日付: ${params.task.limit_day}
            時間: ${params.task.limit_time}
          `;
            window.confirm(errorMessage);
          }
          window.location.reload();
        })
        .catch((error) => {
          this.error = "登録できませんでした。";
          //  window.location.reload();
        });
    },
    update(params, id) {
      this.$axios.patch(`/api/users/tasks/${id}`, params).then((res) => {
        if (params.task) {
          const errorMessage = `
            下記の部分を確認してください. \n
            タイトル: ${params.task.title}
            日付: ${params.task.limit_day}
            時間: ${params.task.limit_time}
          `;
          window.confirm(errorMessage);
        }
        this.$router.push("/tasks");
      });
    },
  },
  computed: {

    defaultDate: {
      get: function (day) {
        return this.limit_day = this.$dayjs().tz().format("YYYY-MM-DD");
      },
      set: function(day) {
        console.log(day)
        return this.limit_day = this.$dayjs(day).tz().format("YYYY-MM-DD");;
      }
    }
  },
  mounted() {

    flatpickr("#" + this.datePick, {
      minDate: "today", //当日以前を選択不可に
      locale: {
        firstDayOfWeek: 1, // 月曜日を週の始めに設定
      },
    });
  },
};
</script>
<style lang="scss">
.task-form {
  .input-btn {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 50px;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    z-index: 10;
    background-color: #fff;
    display: none;

    &__link {
      display: inline-block;
    }

    @include sm {
      display: block;
    }
  }
  .input__box {
    @include sm {
      display: none;
      width: 100%;
      position: fixed;
      bottom: 0;
      left: 0;
      z-index: 9;

      .section-title {
        display: none;
      }
    }
  }

  .box {
    padding: 30px 20px 50px;

    @include ta {
      padding: 20px;
    }
    @include sm {
      padding: 30px 15px 15px;
      border-radius: 10px 10px 0 0;
    }
    &__in {
      display: flex;
      justify-content: center;
      align-items: center;

      @include ta {
        flex-flow: column;
      }
    }
    &__input {
      width: 75%;
      @include ta {
        width: 100%;
      }
      input {
        width: 100%;
        min-height: 45px;
      }
    }
    .btn__wrap {
      width: 25%;
      margin-top: 0;

      @include ta {
        width: auto;
        margin-top: 10px;

        button + button {
          margin-left: 15px;
        }
      }
      @include sm {
        button {
          min-width: 80px;
          font-size: 13px;
          padding: 10px 15px;
        }
      }
    }
  }
  .limit {
    margin-top: 15px;

    @include sm {
      margin-top: 5px;

      .sub__title {
        font-size: 12px;
      }
    }

    input {
      max-width: 260px;
      box-sizing: border-box;
    }
    &__box {
      @include sm {
        display: flex;
        justify-content: space-between;

        input + input {
          margin-left: 10px;
        }
      }
    }
  }
}
.task-form.input-switch {
  position: relative;
  .input__box {
    @include sm {
      display: block;
    }
  }
  .input-btn {
    position: relative;
    top: auto;
    left: auto;
    height: auto;

    &__link {
      position: absolute;
      top: -120px;
      right: 0;
      z-index: 9;
      min-width: 0;
      padding: 0;
      background: none;
      text-decoration: underline;
      color: #333;
      font-size: 12px;
    }
  }
}
$red: #f00;
$blue: #25bdcf;

.flatpickr-day.selected {
  background-color: #ccc;
  border: none;
}
/* 日曜日：赤 */
.flatpickr-calendar
  .flatpickr-innerContainer
  .flatpickr-weekdays
  .flatpickr-weekday:nth-child(7n),
.flatpickr-calendar
  .flatpickr-innerContainer
  .flatpickr-days
  .flatpickr-day:not(.flatpickr-disabled):not(.prevMonthDay):not(.nextMonthDay):nth-child(7n) {
  color: $red;
}

/* 土曜日：青 */
.flatpickr-calendar
  .flatpickr-innerContainer
  .flatpickr-weekdays
  .flatpickr-weekday:nth-child(6),
.flatpickr-calendar
  .flatpickr-innerContainer
  .flatpickr-days
  .flatpickr-day:not(.flatpickr-disabled):not(.prevMonthDay):not(.nextMonthDay):nth-child(7n
    -
    1) {
  color: $blue;
}

/* 祝日 */
.flatpickr-day.is-holiday {
  background: lighten($red, 40%) !important;
}
</style>
