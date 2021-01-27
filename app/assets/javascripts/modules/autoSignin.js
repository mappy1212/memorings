$(function(){
  if(window.location.pathname.match(/\/guest/)){
    const form=document.getElementById("new_user")
    setTimeout(()=>{
      form.submit()
    },0)
  }
});