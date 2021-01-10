$(function(){
  function buildHTML(chat){
    let html =
      `<div class="ChatBox" data-chat-id=${chat.id}>
        <div class="mycomment">
          <p>
            ${chat.sentence}
          </p>
        </div>
      </div>`
    return html;
  }
  $('.form').on('submit', function(e){
    e.preventDefault()
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('#chats').append(html);      
      $('form')[0].reset();
      $('#chats').animate({ scrollTop: $('#chats')[0].scrollHeight});
      $('.send').prop("disabled", false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.send').prop("disabled", false);
    });
  });
});