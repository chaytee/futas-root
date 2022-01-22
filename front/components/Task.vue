<template>
   <div class="task__box wife">
    <div>
      <div class="box">
        <p>{{ taskTitle }}</p>
        <p>{{ taskDate }}</p>
        <p>{{ taskTime }}</p>
        <div>
          <button class="btn__clear" @click="remove()"> 削除する </button>
          <button class="btn__gry" @click="toEdit()"> 編集する </button>
          <button class="btn__accent"
            v-if="!task.is_done"
            @click="complete()"
          >
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
export default {
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
      return this.task.limit_day;
    },
    taskTime() {
      return this.task.limit_time;
    },
  },
  methods: {
    toEdit() {
      this.$router.push(`tasks/${this.task.id}`);
    },
    async complete() {
      await this.$axios.$patch(`/tasks/${this.task.id}`, {
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
        await this.$axios.delete(`/tasks/${this.task.id}`)
        .then(() => {
             //window.location.href = process.env.hostUrl + "/todos";
             window.location.reload();
        })
        .catch((err)=> {
             const message = err.response.data;
             console.log(message);
        })
      }
    },
  },
};
</script>
<style lang="scss">
  .task__box+.task__box {
    margin-top: 20px;
  }
</style>
