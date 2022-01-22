<template>
  <div>
    <div>
      <button
        type="button"
        name="button"
        @click="getMsg"
      >
        RailsからAPIを取得する
      </button>
      <div
        v-for="(msg, i) in msgs"
        :key="i"
      >
        {{ msg }}
      </div>
  </div>
      <div class="columns">
        <!-- 1列目 -->
        <div class="column" style="background: #fee;">Column1</div>
        <!-- 2列目 -->
        <div class="column" style="background: #efe;">Column2</div>
        <!-- 3列目 -->
        <div class="column" style="background: #eef;">Column3</div>
      </div>
  </div>
</template>

<script>


export default {
  layout: 'default',
    data () {
    return {
      msgs: []
    }
  },
  methods: {
    getMsg () {
      this.$axios.$get('/api/v1/hello')
        .then(res => this.msgs.push(res))
    }
  }
}
</script>
