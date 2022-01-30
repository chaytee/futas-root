<template>
  <div class="total-score">
    <dl class="score_box">
      <dt class="score_box_title"> total score</dt>
      <dd class="score_box_contents">
        <div class="score_box_item">
          <p class="item__in"><span class="item__txt">点</span></p>
        </div>
        <div class="score_box_item">
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
    padding-bottom: 20px;

    .score_box {
      max-width: 386px;
      box-sizing: border-box;
      padding: 15px 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 3px rgba(0,0,0,0.1);
      display: flex;
      justify-content: center;
      align-items: center;

      &_title {
        margin-right: 25px;
      }
      &_contents {
          display: flex;
          justify-content: center;
          align-items: center;
      }
      &_item + .score_box_item {
        margin-left: 20px;
      }
    }
  }
</style>
