var supplierChooser = new function () {
    var name = 'supplierChooser';
    var url = '/supplier/selectorIndex.do';
    var height = 660;//500
    var width = 675;
    var title = '选择供应商';

    var self = this;
    //存储选择的结果,可能会有临时的变化,所以最好还是传递值
    this.selMap = [];
    this.tempSelMap = [];

    $(function () {
        if ($("#" + name).length == 0)
            $('<div id="' + name + '"><iframe frameborder="0" scrolling="no" name="' + name + '" style="width: 100%;height:100%;"></iframe></div>').appendTo("body");
    });

    this.open = function (func) {
        var iframe = $("iframe","#"+name)[0];
        $("#" + name).dialog({
            title:title,
            height:height,
            width:width,
            modal:true,
            open:function () {
                //clear input
                //$(".selector-div form").trigger("reset");
                exchange(false);
                iframe.contentWindow.location.href = URL_PREFIX + url;
            },
            buttons:{
                "全部选择":function(){
                    iframe.contentWindow.selectAll();
                },
                "取消选择":function(){
                    iframe.contentWindow.selectNone();
                },
                "确定":function () {
                    exchange(true);
                    if (func != null)func();
                    $(this).dialog("close");
                }
            }
        });
    }

    function exchange(presist){
        if(presist){
            self.selMap = [];
            $.extend(self.selMap,self.tempSelMap);
        }
        else{
            self.tempSelMap = [];
            $.extend(self.tempSelMap,self.selMap);
        }

    }
}