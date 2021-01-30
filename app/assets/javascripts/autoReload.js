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
    let last_chat_id = $('.ChatBox:last').data("chat-id") || 0;
    let chat_id = window.location.pathname.split("/")[2]
    $.ajax({
      url: `/api/chats/${chat_id}`,
      type: 'get',
      dataType: 'json',
      data: {last_chat_id: last_chat_id }
    })
    .done(function(chats) {
      if (chats.length !== 0) {
        let insertHTML = '';
        $.each(chats, function(i, chat) {
          insertHTML += buildHTML(chat)
        });
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