<template>
  <div class="task-form">
    <div class="box input__box">
      <h2 class="section__title">Mission input</h2>
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
import 'flatpickr/dist/flatpickr.min.css';
// import { validationMixin } from 'vuelidate';
// import { required } from 'vuelidate/lib/validators';


const flatpickr = require("flatpickr").default;

export default {
  // mixins: [validationMixin],
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
          //console.log(error.res)
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
    //flatpickrのdefaultDateがなぜか不具合
    defaultDate: function () {

      return this.limit_day = this.$dayjs().tz().format('YYYY-MM-DD');
    }
  },
  mounted() {
    //console.log(this.$dayjs().tz().format('YYYY-MM-DD'));

    flatpickr("#" + this.datePick, {
      minDate: "today", //当日以前を選択不可に
      locale: {
        firstDayOfWeek: 1 // 月曜日を週の始めに設定
      },
      //defaultDate : new Date(),
    });
  },
};
</script>
<style lang="scss">
.task-form {
  margin-top: 40px;
  margin-bottom: 30px;
  .box {
    padding: 30px 20px 50px;
    &__in {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    &__input {
      width: 80%;
      input {
        width: 100%;
        min-height: 45px;
      }
    }
    .btn__wrap {
      width: 20%;
      margin-top: 0;
    }
  }
  .limit {
    margin-top: 15px;

    input {
      max-width: 260px;
      box-sizing: border-box;
    }
  }
}
$red        : #f00;
$blue       : #25bdcf;

.flatpickr-day.selected {
  background-color: #ccc;
  border: none;
}
/* 日曜日：赤 */
.flatpickr-calendar .flatpickr-innerContainer .flatpickr-weekdays .flatpickr-weekday:nth-child(7n),
.flatpickr-calendar .flatpickr-innerContainer .flatpickr-days .flatpickr-day:not(.flatpickr-disabled):not(.prevMonthDay):not(.nextMonthDay):nth-child(7n) {
  color: $red;
}

/* 土曜日：青 */
.flatpickr-calendar .flatpickr-innerContainer .flatpickr-weekdays .flatpickr-weekday:nth-child(6),
.flatpickr-calendar .flatpickr-innerContainer .flatpickr-days .flatpickr-day:not(.flatpickr-disabled):not(.prevMonthDay):not(.nextMonthDay):nth-child(7n - 1) {
  color: $blue;
}

/* 祝日 */
.flatpickr-day.is-holiday{
  background: lighten($red, 40%) !important;
}
</style>
