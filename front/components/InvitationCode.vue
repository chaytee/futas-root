<template>
  <div class="invitation-code">
    <p>合言葉が何も入ってない場合</p>
    <p>1. パートナーと繋がるために『合言葉』を発行してください。</p>
    <p>2. 発行した『合言葉』は忘れないように、パートナーへ伝えてください。</p>
    <div class="invitation-code-display">
      <!--ここはapiからaxiosで接続するのか？-->
      <form action="">
        <input class="form-control" type="text" v-model="paircode" />
        <!-- <input class="form-control" type="text" v-model="user_id" /> -->
        <!-- <input class="form-control" id="copyTarget" type="text" readonly /> -->
        <button class="btn mb-3" type="button" @click="submit()">発行する</button>
      </form>
    </div>
    <div>
    </div>
  </div>
</template>
 <script>
export default {
  data() {

    return {
      paircode: '',
    }

  },
  methods: {
    submit() {
      const params = {
        paircode: this.paircode,
        aaa: this.aaa
      };
      this.create(params);
    },
    create(params) {
      this.$axios.post("/relationships", params).then((res) => {
        if (res.data) {
          const errorMessage = `
            こちらをパートナーに伝えてください \n
            合言葉: ${res.data.paircode}
          `;
          console.log(params)
          return window.alert(errorMessage);
        }
        //this.$router.push("/");
      });
    },
  },
};
</script>
