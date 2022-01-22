<template>
  <div class="invitation-new">
      <p>パートナーが合言葉を発行した場合</p>
      <div class="invitation-code-form">
            <form>
              <div class="field">
                <label for="label">パートナーから伝えられた『合言葉』を入力してください。</label>
                <div class="controle">
                  <input class="form-label" type="text" required placeholder="合言葉の入力">
                </div>
              </div>
              <div class="field">
                <label for="label">パートナーの登録メールアドレス</label>
                <div class="controle">
                  <input class="form-label" type="email" required placeholder="パートナーの登録メールアドレス">
                </div>
              </div>
              <div class="field">
                <label for="label">あなたの名前（登録するお名前）</label>
                <div class="controle">
                  <input class="form-label" type="text" required placeholder="あなたの名前">
                </div>
              </div>
              <div class="control">
                <button class="button is-primary">登録する</button>
              </div>
            </form>
        </div>
    </div>
</template>
