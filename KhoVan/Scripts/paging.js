$(document).ready(function () {
   
  
});
function fixpagingcontent(cpage) {
    if (cpage == "")
        cpage = 1;

    var lastpage = 1;
    var l = $(".page:last").attr("href") + "";
    var p = l.indexOf("page=");
    lastpage = l.substring(p + 5);
    if (cpage != lastpage && cpage != "") {

        var link = l.substring(0, p) + "page=" + (parseInt(cpage) + 1);
        var html = "<a title='Tiếp theo' style='margin-right:5px' class='page' href='" + link + "'>></a>";
        $(html).insertBefore($(".page:last"));
    }
    if (cpage >1) {

        var link = l.substring(0, p) + "page=" + (parseInt(cpage) - 1);
        var html = "<a title='Về trước' style='margin-left:5px' class='page' href='" + link + "'><</a>";
        $(html).insertAfter($(".page:first"));
    }

}