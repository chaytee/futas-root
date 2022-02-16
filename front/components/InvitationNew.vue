<template>
  <div class="invitation-new">
    <h2 class="invitation__title">パートナーが合言葉を発行した場合</h2>
    <p class="error">{{error}}</p>
    <div class="invitation-code-form">
      <form>
        <div class="field">
          <label for="label"
            >パートナーから伝えられた『合言葉』を入力してください。</label
          >
          <div class="control has-icons-left">
            <input
              class="form-label input is-large"
              type="text"
              required
              placeholder="合言葉の入力"
              v-model="paircode"
            />
            <input type="hidden" class="input is-large" v-model="pass_type" />
            <span class="icon is-large is-left">
              <font-awesome-icon icon="key" />
            </span>
          </div>
        </div>
        <div class="field">
          <label for="label">パートナーの登録メールアドレス</label>
          <div class="control has-icons-left">
            <input
              class="form-label input is-large"
              type="email"
              required
              placeholder="パートナーの登録メールアドレス"
              v-model="partner_email"
            />
            <span class="icon is-large is-left">
              <font-awesome-icon icon="envelope" />
            </span>
          </div>
        </div>
        <div class="field">
          <label for="label">あなたの名前（登録するお名前）</label>
          <div class="control has-icons-left">
            <input
              class="form-label input is-large"
              type="text"
              required
              placeholder="あなたの名前"
            />
            <span class="icon is-large is-left">
              <font-awesome-icon icon="user-check" />
            </span>
          </div>
        </div>
        <div class="btn__wrap">
          <button class="btn__grade" @click.prevent="submit()">登録する</button>
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
      pass_type: "2",
      partner_email: "",
      error: null,
    };
  },
  methods: {
    submit() {
      const params = {
        relationship: {
          paircode: this.paircode,
          pass_type: this.pass_type,
          partner_email: this.partner_email,
        },
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
          this.$router.push("/");
        })
        .catch((error) => {
          //console.log(error);
          this.error = "合言葉が違います";
          return;
        });
    },
  },
};
</script>
