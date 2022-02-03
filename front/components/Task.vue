<template>
  <div class="task-box">
    <div class="box">
      <div class="task-box__icon" v-bind:class="{ hicon: isHusIcon }"></div>
      <div class="task-box__in">
        <div class="task-box__main">
          <div class="task-box__limit mb-3">
            <span class="limit__day">{{ taskDate }}</span>
            <span class="limit__time">{{ taskTime }}</span>
          </div>
          <p>{{ iconWho }}</p>
          <!-- <p>{{ doneDate }}</p> -->
          <p class="task-box__title">{{ taskTitle }}</p>
          <p class="task-box__tonow nm">{{ testToNow }}</p>
        </div>
        <div class="task-box__controller">
          <button class="btn__clear" @click="remove()">削除する</button>
          <button class="btn__gry" @click="toEdit()">編集する</button>
          <button class="btn__accent" v-if="!task.is_done" @click="complete()">
            完了
          </button>
          <!-- <button @click="incomplete()"
            >未完了</button
          > -->
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import dayjs from 'dayjs';
import 'dayjs/locale/ja'
dayjs.extend(require('dayjs/plugin/timezone'));
dayjs.extend(require('dayjs/plugin/utc'));
dayjs.extend(require('dayjs/plugin/relativeTime'));
dayjs.tz.setDefault('Asia/Tokyo');

dayjs.locale('ja');
const toNow = dayjs().toNow();

export default {
  data(){
    return {
      isHusIcon: false,
    };

  },
  props: {
    task: {
      type: Object,
      required: true,
      default: () => [],
    },
  },
  computed: {
    taskTitle() {
      return this.task.title;
    },
    taskDate() {
      return dayjs(this.task.limit_day).tz().format("YYYY/MM/DD");
    },
    // doneDate: function () {
    //   console.log(this.task.is_done);
    // },
    taskTime() {
      if(this.task.limit_time === null || this.task.limit_time === undefined ) {
        return this.task.limit_time = ""
      }
      return dayjs(this.task.limit_time).tz().format("HH:MM") || "";
    },
    testToNow: function() {
      return dayjs().tz().toNow();
    },
    iconWho: function() {
      console.log(this.task);
      if(this.task.user.gender === 1){
        return this.isHusIcon = !this.isHusIcon
      }
    },
    husbandTaskCount: function () {

    },
    wifeTaskCount: function () {

    },
  },
  methods: {
    toEdit() {
      this.$router.push(`/tasks/${this.task.id}`);
    },
    async complete() {
      await this.$axios.$patch(`api/users/tasks/${this.task.id}`, {
        is_done: 1,
      });
      this.$router.push(`tasks`);
      window.location.reload();
    },
    // async incomplete() {
    //   await this.$axios.$patch(`/tasks/${this.task.id}`, {
    //     is_done: false,
    //   });
    //   window.location.href = process.env.hostUrl + "/tasks";
    // },
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
};
</script>
