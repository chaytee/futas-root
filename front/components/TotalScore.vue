<template>
  <div class="total-score mt-3">
    <dl class="score__box">
      <dt class="score__title">total score</dt>
      <dd class="score__contents">
        <div class="score__item">
          <p class="score__icon">
            <img src="~/assets/img/icon01.png" alt="" />
          </p>
          <p class="item__in">{{wifeScore}}<span class="item__txt">点</span></p>
        </div>
        <div class="score__item">
          <p class="score__icon">
            <img src="~/assets/img/icon02.png" alt="" />
          </p>
          <p class="item__in">{{husbandScore}}<span class="item__txt">点</span></p>
        </div>
      </dd>
    </dl>
  </div>
</template>
<script>
export default {
  props: {
    husband: Number,
    wife: Number
  },
  computed: {
    husbandScore: function() {
      return this.husband;
    },
    wifeScore: function() {
      return this.wife;
    },
  }
};
</script>
<style lang="scss">
.total-score {
  display: flex;
  justify-content: flex-end;

  .score__box {
    width: 420px;
    box-sizing: border-box;
    padding: 15px 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;

    .score__title {
      margin-right: 25px;
    }
    .score__contents {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .score__item {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .score__item + .score__item {
      margin-left: 20px;
    }
    .score__icon {
      margin-right: 15px;
    }
  }
}
</style>
