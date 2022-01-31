<template>
  <div class="task__box wife">
    <div class="box">
      <div class="box__icon"></div>
      <div class="box__in">
        <div class="box__main">
          <div class="box__limit mb-3">
            <span class="limit__day">{{ taskDate }}</span>
            <span class="limit__time">{{ taskTime }}</span>
          </div>
          <p class="box__title">{{ taskTitle }}</p>
          <p class="box__tonow">{{ testToNow }}</p>
        </div>
        <div class="box_controller">
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
  deta(){
    return {
      testToNow: "",
    }

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
      return dayjs(this.task.limit_day).format("YYYY/MM/DD");
    },
    taskTime() {
      //InvalidDateになってる
      return dayjs(this.task.limit_time).format("hh:mm") || "";
    },
    testToNow: function() {
      return dayjs().toNow();
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
<style lang="scss">
.task__box + .task__box {
  margin-top: 20px;
}
.task__box {
  .box {
    display: flex;
    justify-content: flex-start;
    padding: 15px 20px;
  }
  .box__in {
    width: 100%;
    display: flex;
    justify-content: space-between;
    position: relative;
    align-items: center;
  }

  .box__icon {
    width: 60px;
    height: 60px;
    margin-right: 25px;
  }
}
</style>
