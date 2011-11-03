var htmlEscape = function(txt) {
  return txt.replace(/&/g,'&amp;').                                         
    replace(/>/g,'&gt;').                                           
    replace(/</g,'&lt;').                                           
    replace(/"/g,'&quot;')              
}

var scrollToBottom = function() {
  $(window).scrollTop($(document).height());
}