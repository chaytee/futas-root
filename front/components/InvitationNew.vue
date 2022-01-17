<template>
  <div class="invitation-new">
      <p>相互フォロー実行のフォーム</p>
      <div class="invitation-code-form">
            <form>
              <div class="field">
                <label for="label">パートナーの招待コード</label>
                <div class="controle">
                  <input class="form-label" type="text" required placeholder="パートナーの招待コード">
                </div>
              </div>
              <div class="field">
                <label for="label">パートナーの登録メールアドレス</label>
                <div class="controle">
                  <input class="form-label" type="email" required placeholder="パートナーの登録メールアドレス">
                </div>
              </div>
              <div class="field">
                <label for="label">登録する家族の名前</label>
                <div class="controle">
                  <input class="form-label" type="text" required placeholder="登録する家族の名前">
                </div>
              </div>
              <div class="control">
                <button class="button is-primary">登録</button>
              </div>
            </form>
        </div>
    </div>
</template>
