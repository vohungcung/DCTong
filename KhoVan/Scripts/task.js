function InitGroup() {
    var id = "";
    var arr = $(document).find(".txtquantity").get();
    for (var i = arr.length - 1; i >= 0; i--) {
        var itemid = $(arr[i]).attr("itemid");
        itemid = itemid.substr(0, 9);
        if (id != itemid) {
            id = itemid;

            var currentrow = $(arr[i]).parent().parent();
            var html = "<tr id='" + id + "' style='background-color:navy;color:#fff;font-weight:bold'>";

            html += "<td class='forhideinmobile' >" + id + "</td>";
            html += "<td ><span class='forshowinmobile' >" + id + "</span> <a title='xóa mã 9' class='forshowinmobile' href='javascript:void(0)' style='color:#FFF;font-weight:bold' itemid='" + itemid + "'  onclick='DeleteItem(this)'><br/>X</a></td>";
            html += "<td class='forhideinmobile'></td>";
            html += "<td class='forhideinmobile'></td>";
            html += "<td class='forhideinmobile'></td>";



            html += "<td style='text-align:right' id='qua" + itemid + "' class='qua'>0</td>";
            html += "<td class='forhideinmobile'></td>";
            html += "<td></td>";
            html += "<td></td>";

            html += "<td  class='forhideinmobile' style='text-align:center'><a title='xóa mã 9' href='javascript:void(0)' style='color:#FFF;font-weight:bold' itemid='" + itemid + "'  onclick='DeleteItem(this)'>X</a></td>";

            html += "</tr>";
            $(html).insertAfter(currentrow);

        }
    }
    updategroup();

}
function updategroup() {

    $(".qua").html("0");
    var arr = $(document).find(".txtquantity").get();
    for (var i = 0; i < arr.length; i++) {
        var itemid = $(arr[i]).attr("itemid");
        itemid = itemid.substr(0, 9);
        var o = $("#qua" + itemid);
        var oldv = $.trim($(o).html());
        var v = $.trim($(arr[i]).val());

        var tt = parseInt(v) + parseInt(oldv);
        $(o).html(tt);

    }
}
