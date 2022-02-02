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
dayjs.tz.setDefault('Asia/Tokyo');
dayjs.extend(require('dayjs/plugin/relativeTime'));

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
    taskTime() {
      //InvalidDateになってる null
      console.log(this.task.limit_time);
      console.log('今日です');
      console.log(dayjs().format());
      return dayjs(this.task.limit_time).tz().format("hh:mm") || "";
    },
    testToNow: function() {
      return dayjs().tz().toNow();
    },
    iconWho: function() {
      console.log(this.task);
      if(this.task.gender === 1){
        return this.isHusIcon = !this.isHusIcon
      }
    }
  },
  methods: {
    toEdit() {
      this.$router.push(`/tasks/${this.task.id}`);
    },
    async complete() {
      await this.$axios.$patch(`api/users/tasks/${this.task.id}`, {
        is_done: true,
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
