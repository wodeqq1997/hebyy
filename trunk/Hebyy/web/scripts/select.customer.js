$(function () {
    if ($("#customerChooser").length == 0)
        $("<div id='customerChooser' style='display:none;'/>").appendTo("body");
});
function openCustomer(func) {
    $("#customerChooser").dialog({
        height:510,
        width:623,
        modal:true,
        title:"选择客户",
        open:function () {
            if(typeof batchSelectMode==="undefined")
                $(this).load(URL_PREFIX + "/pages/zjimis/customer/selector/selector.jsp");
            else
                $(this).load(URL_PREFIX + "/pages/zjimis/customer/selector/selector2.jsp");
        }
    });

    //保存
    this.saveCustomer = function (object) {
        func(object);
        $("#customerChooser").dialog("close");
    }

    //直接关闭
    this.closeCustomer = function () {
        $("#customerChooser").dialog("close");
    }
}
