<template>
  <div class="invitation-code">
    <p>コード発行</p>
    <div class="invitation-code-display">
      <!--ここはapiからaxiosで接続するのか？-->
      <input class="form-control" id="copyTarget" type="text" readonly />‹
      <button class="btn mb-3" type="button" @click="getInvitationCode">
        発行する
      </button>
      <p>{{msgs}}</p>
    </div>
    <div>
      <p>
        こちらの招待コードをパートナーの方の招待コード入力欄に入力してください。
      </p>
      <p>
        招待コードはこのURLに訪問したり、再読み込みをするたびに変わります。<br />忘れずにコピーをしてください。
      </p>
    </div>
  </div>
</template>
 <script>
export default {
  data() {

    return {
      msg: ''
    }

  },
  methods: {
    getInvitationCode() {
      this.$axios.$get("/relationships/invitation_code").then((res) => this.msgs.push(res));
    },
  },
};
</script>
