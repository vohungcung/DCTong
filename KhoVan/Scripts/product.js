function addtocart(itemid) {

    $.post('/home/add_product', { ItemID: $.trim(itemid) }, function (result) {
        if (result.success) {
            alert('Đã thêm thành công vào giỏ hàng');

        } else {

            alert(result.errorMsg);
        }
    }, 'json');
}
function addtocartmore(itemid) {

    openitem(itemid, "ZOC", MemberID);

}
function openitem(itemid, type, MemberID) {
    var url = "/home/ChooseItem?id=" + itemid + "&type=" + type + "&c=" + MemberID;
    var h = 400;
    var w = 600;
    showtc(url, w, h);

}
function closeparent() {
    location = "/Home/AddOrder?type=ZOC";
}


$(window).load(function () {

    $(".addtocart1").click(function () {
        var p = $(this).parent();
        var itemid = $(p).attr("itemid");
        var size = $(p).attr("size");
        var color = $(p).attr("color");

        if (size == "" || size == null) {
            alert("bạn chưa chọn size");
            return;
        }
        if (color == "" || color == null) {
            alert("bạn chưa chọn màu");

            return;
        }
        if (itemid == "" || itemid == null) {
            alert("bạn chưa chọn mã");

            return;
        }

        addtocart(itemid + color + size);
    });

    $(".addtocart2").click(function () {
        var p = $(this).parent();
        var itemid = $(p).attr("itemid");
        var size = $(p).attr("size");
        var color = $(p).attr("color");


        if (itemid == "" || itemid == null) {
            alert("bạn chưa chọn mã");

            return;
        }

        addtocartmore(itemid);
    });





    arr = $(".products").find(".iteminfo").get();

    for (var i = 0; i < arr.length; i++) {
        fixiteminfo($(arr[i]));
    }
    arr = $(".products").find(".iteminfo").get();
    for (var i = 0; i < arr.length; i++) {
        var id = $(arr[i]).attr("id");
        $("#" + id + " .itemcolor:first").addClass("colorselect");
        $("#name" + id).html($("#" + id + " .itemcolor:first").attr("itemname"));

        $("#" + id + " .itemsizeframe:first").show();
        $("#" + id).parent().attr("color", $("#" + id + " .itemcolor:first").attr("color"));
    }


    $(".itemcolor").click(function () {
        var thumbimage = $(this).attr("thumbimage");
        var itemname = $(this).attr("itemname");

        var itemid = $(this).attr("itemid");
        var color = $(this).attr("color");
        var r = itemid + color;
        $("#" + itemid + " .itemsizeframe").hide();
        $("#" + r).fadeIn(1000, function () {

        });
        $("#" + itemid + " .itemcolor").removeClass("colorselect");
        $(this).addClass("colorselect");
        $("#" + itemid + " .itemsize").removeClass("itemsizechoose");
        $("#" + itemid).parent().attr("size", null);
        if (thumbimage != null && thumbimage != "")
            $("#detail" + itemid).attr("src", thumbimage.replace("~/", "/"));
        if (itemname != null && itemname != "")
            $("#name" + itemid).html(itemname);

    })
    fixproduct();
    $(".itemsize").click(function () {
        var itemid = $(this).attr("itemid");
        var size = $(this).attr("size");
        var color = $(this).attr("color");
        var itemname = $(this).attr("itemname");
        var price = $(this).attr("price");

        var p = $("#" + itemid).parent();

        p.attr({ "size": size });
        p.attr({ "color": color });
        $("#" + itemid + " .itemsize").removeClass("sizechoose");
        $(this).addClass("sizechoose");
        if (itemname != null && itemname != "")
            $("#name" + itemid).html(itemname);
        if (price != null && price != "")
            $("#price" + itemid).html(price);

    })
})

function fixproduct() {
    var arr = $(".products").find(".producte").get();
    $(".producte").removeClass("clear");
    var ww = $(".products").width();
    var w = 0;
    var ii = 0;
    var aii = new Array();
    $(".iteminfo").removeAttr("style");
    for (var i = 0; i < arr.length; i++) {

        w += $(arr[i]).width() + 30;
        if (w > ww) {
            w = $(arr[i]).width() + 30;
            $(arr[i]).addClass("clear");
            fixarr(aii);

            aii = new Array();
            aii[aii.length] = $(arr[i]);


        } else {
            aii[aii.length] = $(arr[i]);

        }


    }
    fixarr(aii);

    //arr = $(".products").find(".iteminfo").get();
    //var max = 0;
    //$(".iteminfo").removeAttr("style");
    //for (var i = 0; i < arr.length; i++) {
    //    if (max < $(arr[i]).height())
    //        max = $(arr[i]).height();
    //}
    //if ($(window).width() > 600)
    //    $(".iteminfo").css({ "min-height": max + "px" });
    if ($(window).width() < 600)
        $(".iteminfo").removeAttr("style");
}
function fixarr(arr) {

    var max = 0;
    for (var i = 0; i < arr.length; i++) {
        var ii = $(arr[i]).find(".iteminfo").get();
        $(ii[0]).removeAttr("style");

    }

    for (var i = 0; i < arr.length; i++) {
        var ii = $(arr[i]).find(".iteminfo").get();
        if ($(ii[0]).height() > max) {
            max = $(ii[0]).height();

        }
    }
    for (var i = 0; i < arr.length; i++) {
        var ii = $(arr[i]).find(".iteminfo").get();
        $(ii[0]).css({ "min-height": max + "px" });

    }

}
$(window).resize(function () {
    fixproduct();
})
function fixiteminfo(iteminfo) {
    var a = $(iteminfo).find(".sizelist").get();

    var sizelist = $(a[0]);
    var arr = $(iteminfo).find(".itemsizeframe").get();
    for (var i = 0; i < arr.length; i++) {
        $(sizelist).append($(arr[i]));
    }
}