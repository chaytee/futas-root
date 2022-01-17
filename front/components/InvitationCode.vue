<template>
  <div class="invitation-code">
      <p>コード発行</p>
      <div class="invitation-code-display">
        <input class="form-control" id="copyTarget" type="text" value="<%= current_user.invitation_token %>" readonly>
        <i class="btn btn-outline-secondary far fa-copy copy-btn" type="button" onclick="copyToClipboard()"></i>
      </div>
      <div>
        <p>こちらの招待コードをパートナーの方の招待コード入力欄に入力してください。</p>
        <p>招待コードはこのURLに訪問したり、再読み込みをするたびに変わります。<br>忘れずにコピーをしてください。</p>
      </div>
    </div>
</template>
 <script>
    function copyToClipboard() {
      var copyTarget = document.getElementById("copyTarget");
      copyTarget.select();
      navigator.clipboard.writeText("Copy");
      alert('コピーしました');
    }
  </script>
