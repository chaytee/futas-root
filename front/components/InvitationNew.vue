<template>
  <div class="invitation-new">
    <p>パートナーが合言葉を発行した場合</p>
    <div class="invitation-code-form">
      <form>
        <div class="field">
          <label for="label"
            >パートナーから伝えられた『合言葉』を入力してください。</label
          >
          <div class="controle">
            <input
              class="form-label"
              type="text"
              required
              placeholder="合言葉の入力"
              v-model="paircode"
            />
            <input type="hidden" v-model="pass_type" />
          </div>
        </div>
        <div class="field">
          <label for="label">パートナーの登録メールアドレス</label>
          <div class="controle">
            <input
              class="form-label"
              type="email"
              required
              placeholder="パートナーの登録メールアドレス"
              v-model="partner_email"
            />
          </div>
        </div>
        <div class="field">
          <label for="label">あなたの名前（登録するお名前）</label>
          <div class="controle">
            <input
              class="form-label"
              type="text"
              required
              placeholder="あなたの名前"
            />
          </div>
        </div>
        <div class="control">
          <button class="button is-primary" @click.prevent="submit()">登録する</button>
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
    };
  },
  methods: {
    submit() {
      const params = {
        relationship: {
          paircode: this.paircode,
          pass_type: this.pass_type,
          partner_email: this.partner_email
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

        //   const errorMessage = `
        //     ${error.errors}
        //   `;
        //   console.log(errorMessage);
        console.log(error);
        });

    },
  },
};
</script>
