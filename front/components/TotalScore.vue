<template>
  <div class="total-score">
    <dl class="score-box">
      <dt class="score-box__title mp">total score</dt>
      <dd class="score-box__contents">
        <div class="score-box__item">
          <p class="score-box__icon nm">
            <img src="~/assets/img/icon01.png" alt="" />
          </p>
          <p class="item__in nm mp">
            {{ wifeScore }}<span class="item__txt">点</span>
          </p>
        </div>
        <div class="score-box__item">
          <p class="score-box__icon nm">
            <img src="~/assets/img/icon02.png" alt="" />
          </p>
          <p class="item__in nm mp">
            {{ husbandScore }}<span class="item__txt">点</span>
          </p>
        </div>
      </dd>
    </dl>
  </div>
</template>
<script>
import { mapState, mapGetters, mapActions } from "vuex";

export default {

  computed: {
    husbandScore: function () {
      // return this.husband;
      return this.$store.getters['modules/score/husbandScore']
    },
    wifeScore: function () {
      return this.$store.getters['modules/score/wifeScore']
    },
    ...mapGetters("modules/score/allScores'", ['allScores'])
  },
  mounted (){
    console.log(this.$store)
     console.log(this.$store.getters['modules/score/husbandScore'])
  },

  methods: {
    ...mapActions("modules/score", ["getScore"]),

    },
    created(){
    this.getScore()

  }
};
</script>
<style lang="scss">
.total-score {
  display: flex;
  justify-content: flex-end;

  .score-box {
    width: 420px;
    box-sizing: border-box;
    padding: 15px 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;

    @include ta {
      width: auto;
      padding: 10px;
    }

    &__title {
      margin-right: 25px;
      font-weight: bold;
      @include ta {
        margin-right: 15px;
      }
      @include sm {
        font-size: 13px;
      }
    }
    &__contents {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    &__item {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    &__item + .score-box__item {
      margin-left: 20px;
    }
    &__icon {
      margin-right: 15px;

      @include ta {
        width: 35px;
      }
      @include sm {
        width: 25px;
      }
    }
  }
  .item__in {
    font-size: 20px;
    font-weight: bold;

    @include sm {
      font-size: 16px;
    }
    .item__txt {
      font-size: 14px;

      @include sm {
        font-size: 10px;
      }
    }
  }
}
</style>
