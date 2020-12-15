function showtc(url, width, height) {

    showtchasbg(url, width, height, "#eff3f7");
}

function showtchasbg(url, width, height, bcolor) {


    if (width > $(window).width())
        width = $(window).width() - 50;

    // var newWindow = window.open(url, "_blank", 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left,false);
    var p = "<div id='tcbox' style='position:absolute;top:" + ($(window).scrollTop() + 30) + "px;z-index:9999;";
    p += "left:" + (($(window).width() - width) / 2) + "px;width:" + (width - 20) + "px;height:" + height + "px;border-radius:10px;padding:10px";
    p += ";background-color:" + bcolor + ";overflow:auto;border:1px solid #000;-webkit-overflow-scrolling:touch'>";
    p += "<Div style='width:100%;height:" + (height - 20) + "px;float:left;position:relative;padding-top:10px;padding-bottom:10px;margin:0'>";
    p += "<div style='text-align:right;height:30px;width:100px;top:0;right:0;position:absolute;cursor:pointer;z-index:9999' onclick='tcboxclose()'><a href='javascript:void(0)' style='color:#666' onclick='tcboxclose()'>[ x ]</a></div>";
    p += "<iframe  src='" + url + "' style='width:100%;height:100%;border:none;'></iframe></div>";
    p += "</Div>";
    $("#productw").remove();
    $("#tcbox").remove();

    $("body").append(p);

    $("#tcbox iframe").load(function () {
        var h = $(this).contents().find("body").height();
        if (h < height)
            h = height;
        if (h > $(window).height() - 100)
            h = $(window).height() - 100;
        h = h + 10;
        $(this).height(h);
        $("#tcbox").css("height", h + "px");
    });

   
}
function tcboxclose() {
    $("#tcbox").remove();
    $("#productw").remove();
}
$(document).keydown(function (e) {
    if (e.keyCode == 27)
        tcboxclose();
})