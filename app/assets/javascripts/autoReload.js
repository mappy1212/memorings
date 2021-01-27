$(function(){
  function buildHTML(chat){
    if ( chat.user_id == chat.current_user_id ) {
      let html =
        `<div class="ChatBox" data-chat-id=${chat.id}>
          <div class="mycomment">
            <p>
              ${chat.sentence}
            </p>
          </div>
        </div>`
      return html;
    } else {
      let html =
      `<div class="ChatBox" data-chat-id=${chat.id}>
        <div class="fukidasi">
          <div class="faceicon">
            <img class="icon-photo" src="${chat.image}">
          </div>
          <div class="chatting">
            <div class="says">
              <p>
                ${chat.sentence}
              </p>
            </div>
          </div>
          </div>
          </div>
      </div>`
      return html;
    };
  }
  let reloadChats = function() {
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    let last_chat_id = $('.ChatBox:last').data("chat-id") || 0;
    let chat_id = window.location.pathname.split("/")[2]
    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      url: `/api/chats/${chat_id}`,
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {last_chat_id: last_chat_id }
    })
    .done(function(chats) {
      // 更新するメッセージがなかった場合は.doneの後の処理が動かないようにする
      if (chats.length !== 0) {
        //追加するHTMLの入れ物を作る
        let insertHTML = '';
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(chats, function(i, chat) {
          insertHTML += buildHTML(chat)
        });
        //メッセージが入ったHTMLに、入れ物ごと追加
        $('#chats').append(insertHTML);
        $('#chats').animate({ scrollTop: $('#chats')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert('リロードのところ');
    });
  };
  setInterval(reloadChats, 7000);
});