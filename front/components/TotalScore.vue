<template>
  <div class="total-score">
    <dl class="score__box">
      <dt class="score__title"> total score</dt>
      <dd class="score__contents">
        <div class="score__item">
          <p class="score__icon"><img src="~/assets/img/icon01.png" alt=""></p>
          <p class="item__in"><span class="item__txt">点</span></p>
        </div>
        <div class="score__item">
          <p class="score__icon"><img src="~/assets/img/icon02.png" alt=""></p>
          <p class="item__in"><span class="item__txt">点</span></p>
        </div>
      </dd>
    </dl>
  </div>
</template>
<style lang="scss">
  .total-score {
    display: flex;
    justify-content: flex-end;
    padding-bottom: 10px;

    .score__box {
      width: 420px;
      box-sizing: border-box;
      padding: 15px 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 3px rgba(0,0,0,0.1);
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
