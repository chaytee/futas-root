<template>
  <div class="invitation-code">
    <h2 class="invitation__title">合言葉を未設定の場合</h2>
    <p>1. パートナーと繋がるために『合言葉』を発行してください。</p>
    <p>2. 発行した『合言葉』は忘れないように、パートナーへ伝えてください。</p>
    <div class="invitation-code-display">
      <!--ここはapiからaxiosで接続するのか？-->
      <form action="">
        <div class="control has-icons-left">
          <input
            class="form-control input is-large"
            type="text"
            v-model="paircode"
          />
          <span class="icon is-large is-left">
            <font-awesome-icon icon="key" />
          </span>
        </div>
        <input type="hidden" class="input is-large" v-model="pass_type" />
        <!-- <input class="form-control" type="text" v-model="user_id" /> -->
        <!-- <input class="form-control" id="copyTarget" type="text" readonly /> -->
        <div class="btn__wrap">
          <button class="btn__grade" type="button" @click="submit()">
            発行する
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
 <script>
export default {
  data() {
    return {
      paircode: "",
      pass_type: "1",
    };
  },
  methods: {
    submit() {
      const params = {
        //paircode: this.paircode,
        relationship: { paircode: this.paircode, pass_type: this.pass_type },
      };
      this.create(params);
    },
    create(params) {
      this.$axios
        .post("api/users/relationships", params)
        .then((res) => {
          if (params) {
            const errorMessage = `
            こちらをパートナーに伝えてください \n
            合言葉: ${params.relationship.paircode}
          `;

            //return window.alert(errorMessage);
          }
          //this.$router.push("/");
          console.log(params);
        })
        .catch((error) => {
          console.log(error.response);
        });
    },
  },
};
</script>
