
function openitem(itemid, type, MemberID) {
    var url = "/admin/ChooseItem?id=" + itemid + "&type=" + type + "&c=" + MemberID;
    var h = 400;
    var w = 600;
    showtc(url, w, h);
}
