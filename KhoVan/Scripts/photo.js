function PhotoManagement() {
   

    var url = "/admin/PhotoManagement?id=ThumbImage";
    var h = 460;
    var w = 600;
    if (w > $(window).width())
        w = $(window).width() - 50;

    showtchasbg(url, w, h, "#FFF");

}
