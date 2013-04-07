
$(function(){
    if ($("#billChooser").length == 0)
        $('<div id="billChooser"><iframe src="" frameborder="0" scrolling="no" name="billWindow" style="width: 100%;height: 500px;"></iframe></div>').appendTo("body");
});

function openSelBill(func)
{
    //var url = URL_PREFIX+"/pages/zjimis/finance/bill/selector.jsp";
    $("#billChooser").dialog({
        title:"选择票据",
        height:605,
        width:810,
        modal:true,
        create:function(){
            //$(this).load(url,{});
        },
        open:function()
        {
            //clear input
            //$(".selector-div form").trigger("reset");
            window.frames["billWindow"].location.href = URL_PREFIX+"/bill/selectorIndex.do";
        },
        buttons:{
            "确定":function(){
                var result = window.frames[0].pressOK();
                if(result==null)return;
                if(func!=null)func(result);
                $(this).dialog("close");
            },
            "取消":function(){
                $(this).dialog("close");
            }
        }
    });
}