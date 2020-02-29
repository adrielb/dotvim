javascript:(function(){
    var e='http://127.0.0.1:4999/NewNote?url='+encodeURIComponent(location.href)+
        '&title='+encodeURIComponent(document.title);
    xhr=new XMLHttpRequest();
    xhr.open("POST",e);
    xhr.send()
})() 
