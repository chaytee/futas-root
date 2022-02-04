<template>
  <div class="task-form">
    <div class="box input__box">
      <h2 class="section__title">Mission input</h2>
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
            <button class="btn__clear" type="button" @click="remove()">取り消す</button>
            <button class="btn__accent" @click.prevent="submit()">送信</button>
          </div>
        </div>
        <div class="limit">
          <h3 class="sub__title">Limit</h3>
          <div class="limit__box">
            <div class="limit__btn">
              <button class="btn__click" type="button" @click="getToday()">今日</button>
              <button class="btn__click" type="button" @click="getTomorrow()">明日</button>
              <button class="btn__click" type="button" @click="getDayAfterTomorrow()">
                明後日
              </button>
              <button class="btn__click" type="button" @click="getAfterOneWeek()">
                一週間以内
              </button>
            </div>
            <div class="put_limit">
              <!-- <input
                class="input is_medium"
                id="limit_day"
                type="text"
                placeholder="2021-07-14"
                v-model="limit_day"
              /> -->
              <input class="input is-large put_day" type="text" required v-bind:id="datePick" v-model="limit_day">
              <input
                class="input is-large put_time"
                type="time"
                v-model="limit_time"
              />
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
const dayjs = require('dayjs');
dayjs.extend(require('dayjs/plugin/timezone'));
dayjs.extend(require('dayjs/plugin/utc'));
dayjs.tz.setDefault('Asia/Tokyo');
dayjs.extend(require('dayjs/plugin/relativeTime'));

import 'flatpickr/dist/themes/confetti.css';
const flatpickr = require('flatpickr').default;

const now = dayjs();
// const today = now.format("YYYY-MM-DD");
const toNow = dayjs().toNow();

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
  // watch: {
  //   taskId(newValue) {
  //     this.taskId = newValue

  //   }
  // }
  data() {
    return {
      title: "",
      limit_day: "",
      limit_time: "",
      datetime: "",
      datePick: "datePick",
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
    getToday: function() {
      document.getElementById("limit_day").value = today;
      console.log(today)
    },
    getTomorrow: function() {
      const tomorrow = now.add(1, "day").format("YYYY-MM-DD");
      document.getElementById("limit_day").value = tomorrow;
    },
    getDayAfterTomorrow: function() {
      const dayAfterTomorrow = now.add(2, "day").format("YYYY-MM-DD");
      document.getElementById("limit_day").value = dayAfterTomorrow;
    },
    getAfterOneWeek: function() {
      const afterOneWeek = now.add(1, "week").format("YYYY-M-DD");
      document.getElementById("limit_day").value = afterOneWeek;
    },
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
        // .catch((err) => console.log(err));
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
  mounted() {
    flatpickr('#' + this.datePick);

  },
  computed: {

  }

};
</script>
<style lang="scss">

.task-form {
  margin-top: 40px;
  .box {
    padding: 20px;
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

    &__btn {
      margin-bottom: 15px;
    }

    input {
      max-width: 260px;
      box-sizing: border-box;
    }
  }
}
</style>
