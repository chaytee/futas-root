<template>
  <div id="task__form" class="wife">
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
            <button class="btn__clear" @click="remove()">取り消す</button>
            <button class="btn__accent" @click.prevent="submit()">送信</button>
          </div>
        </div>
        <div class="limit">
          <h3 class="sub__title">Limit</h3>
          <div class="limit__box">
            <div class="limit__btn">
              <button class="btn__click" @click="getToday()">今日</button>
              <button class="btn__click" @click="getTomorrow()">明日</button>
              <button class="btn__click" @click="getDayAfterTomorrow()">
                明後日
              </button>
              <button class="btn__click" @click="getAfterOneWeek()">
                一週間以内
              </button>
              <button class="btn__click">日付指定</button>
            </div>
            <div class="put_limit">
              <input
                class="input is_medium"
                type="text"
                placeholder="2021-07-14"
                v-model="limit_day"
              />
              <input
                class="input is_medium"
                type="text"
                placeholder="11:00:00"
                v-model="limit_time"
              />
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
import dayjs from "dayjs";

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
    };
  },
  async created() {
    if (this.taskId) {
      await this.$axios.$get(`/tasks/${this.taskId}`).then((res) => {
        this.title = res.title;
        this.limit_day = res.limit_day;
        this.limit_time = res.limit_time;
      });
    }
  },
  methods: {
    submit() {
      const params = {
        title: this.title,
        limit_day: this.limit_day,
        limit_time: this.limit_time,
      };
      //新規であれば新規フォームへ既にtask-idのあるものは編集フォームへ
      //this.create(params);
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
            タイトル: ${params.title}
            日付: ${params.limit_day}
            時間: ${params.limit_time}
          `;
            window.alert(errorMessage);
          }
          window.location.reload();
          //this.$router.push("/tasks");
        })
        .catch((err) => console.error(err));
    },
    update(params, id) {
      this.$axios.patch(`/api/users/tasks/${id}`, params).then((res) => {
        if (res.data.taks) {
          const errorMessage = `
            下記の部分を確認してください. \n
            タイトル: ${params.title}
            日付: ${params.limit_day}
            時間: ${params.limit_time}
          `;
          window.alert(errorMessage);
        }
        this.$router.push("/tasks");
      });
    },
    getToday() {
      const now = dayjs();
      console.log(now.format("YYYY/M/D"));
    },
    getTomorrow() {
      const tomorrowData = dayjs().add(1, "day");
      const tomorrow = tomorrowData.format("YYYY/M/D");
      this.limit_day = tomorrow;
    },
    getDayAfterTomorrow() {
      const DayAfterTomorrowData = dayjs().add(2, "day");
      const DayAfterTomorrow = DayAfterTomorrowData.format("YYYY/M/D");
      console.log(DayAfterTomorrow);
    },
    getAfterOneWeek() {
      const AfterOneWeekData = dayjs().add(1, "week");
      const AfterOneWeek = AfterOneWeekData.format("YYYY/M/D");
      console.log(AfterOneWeek);
    },
  },
};
</script>
<style lang="scss">
#task__form {
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
      margin-bottom: 20px;
    }
    .btn__click + .btn__click {
      margin-left: 15px;
    }
  }
}
.wife {
  .input__box {
    background-color: #f7b4ab;
  }
}
</style>
