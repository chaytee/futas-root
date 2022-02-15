<template>
  <div class="task-box">
    <div class="box" v-bind:class="{ time_over: isTimeOver }">
      <div
        class="task-box__icon"
        v-bind:class="{ hicon: this.task.user.gender === 1 }"
      ></div>
      <div class="task-box__in">
        <div class="task-box__main">
          <div class="task-box__limit mb-3" v-bind:class="{ hurry: isLimit }">
            <span class="limit__day">{{ taskDate }}</span>
            <span class="limit__time">{{ taskTime }}</span>
          </div>
          <!-- <p>{{isTimeOver}}</p> -->
          <!-- <p>{{ iconWho }}</p> -->
          <!-- <p>{{ doneDate }}</p> -->
          <p class="task-box__title">{{ taskTitle }}</p>
          <p class="task-box__tonow nm">{{ testToNow }}</p>
          <div class="mt-5">
            <p>--vuex書き換え--</p>
            <p>{{ allTasks }}</p>
            <ul v-for="vtask in allTasks" :key="vtask.id">
              <li>{{ vtask.title }}</li>
              <li>{{ vtask.limit_day }}</li>
              <li>{{ vtask.limit_time }}</li>
              <li>{{ vtask.created_at }}</li>
              <!-- <li>{{formatTaskDate(vtask.limit_day)}}</li> -->
              <!-- <li>{{taskTime}}</li> -->
            </ul>
            <p>--終わり--</p>
          </div>
        </div>
        <div class="task-box__controller">
          <button class="btn__clear" @click="remove()">削除する</button>
          <button class="btn__gry" @click="toEdit()">編集する</button>
          <button class="btn__accent" v-if="!task.is_done" @click="complete()">
            完了
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapState, mapGetters, mapActions } from "vuex";

import { formatDistanceToNow } from "date-fns";
import { ja } from "date-fns/locale";

export default {
  data() {
    return {
      isHusIcon: false,
      isLimit: false,
      isTimeOver: false,
    };
  },
  props: {
    task: {
      type: Object,
      required: true,
      default: () => [],
    },
  },
  // name: "Tasks",
  computed: {
    ...mapGetters("modules/tasks", ["allTasks"]),
    // ...mapState("modules/tasks", ["vtasks"]),

    taskTitle() {
      return this.task.title;
    },
    taskDate() {
      return this.$dayjs(this.task.limit_day).tz().format("YYYY/MM/DD");
    },
    taskTime() {
      if (this.task.limit_time === null || this.task.limit_time === undefined) {
        return (this.task.limit_time = "");
      }
      return this.$dayjs(this.task.limit_time).tz().format("HH:MM") || "";
    },
    //v-forで回す前に修正したいカラムを取り出し、加工する
    allTasks() {
      const allTasks = this.$store.getters["modules/tasks/allTasks"];

      const useAllTasks = allTasks.map((allTask) => {
        const { title, limit_time, limit_day, created_at } = allTask;

        //??nll合体演算子
        //if (limit_time === null || limit_time === undefined) {
        //   limit_time = ''
        // }
        const useTaskAtmic = {
          title: title,
          limit_time: limit_time ?? "",
          limit_day: limit_day.replaceAll("-", "/"),
          created_at: formatDistanceToNow(new Date(created_at), {
            locale: ja,
          }),
        };
        return useTaskAtmic;
      });
      return useAllTasks;
    },

    testToNow: function () {
      return formatDistanceToNow(new Date(this.task.created_at), {
        locale: ja,
      });
    },

    //v-bind:class="{'hicon': (this.task.user.gender === 1)} "へ書き換え
    // iconWho: function () {
    //   if (this.task.user.gender === 1) {
    //     return (this.isHusIcon = !this.isHusIcon);
    //   }
    // },
  },
  methods: {
    ...mapActions("modules/tasks", ["getTasks"]),

    //vuexで書き換えたいがv-forで回した時に値を渡すのはどうすればよいか
    //関数を作成するパターン。しかし毎回メソッドが回るのであまりよくない
    //<!-- <li>{{formatTaskDate(vtask.limit_day)}}</li> -->
    // formatTaskDate(limit_day){
    //   return limit_day.replaceAll('-', '/')
    // },

    toEdit() {
      this.$router.push(`/tasks/${this.task.id}`);
    },
    async complete() {
      await this.$axios.$patch(`api/users/tasks/${this.task.id}`, {
        //夫だった場合is_done: 1　妻 is_done: 2
        is_done: this.$auth.user.gender === 1 ? 1 : 2,
        //is_done: this.$auth.user.id
        // user.idごとのis_doneの個数
      });
      this.$router.push(`tasks`);
      window.location.reload();
    },
    async remove() {
      const confirmation = window.confirm("本当に削除しますか？");
      if (confirmation) {
        await this.$axios
          .delete(`api/users/tasks/${this.task.id}`)
          .then(() => {
            //window.location.href = process.env.hostUrl + "/todos";
            window.location.reload();
          })
          .catch((err) => {
            const message = err.response.data;
            console.log(message);
          });
      }
    },
  },
  created() {
    this.getTasks();
    // this.setTask(task);
  },
  mounted() {
    const today = this.$dayjs().tz().format("YYYY/MM/DD");
    const yesterday = this.$dayjs().add(-1, "day").format("YYYY/MM/DD");
    //タイムオーバー条件
    if (
      this.$dayjs(this.task.limit_day).tz().format("YYYY/MM/DD") === yesterday
    ) {
      return (this.isTimeOver = !this.isTimeOver);
    }
    //Hurry!条件
    if (this.$dayjs(this.task.limit_day).tz().format("YYYY/MM/DD") === today) {
      return (this.isLimit = !this.isLimit);
    }
  },
};
</script>
