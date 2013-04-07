//不用了
$(function(){
    if ($("#djclChooser").length == 0)
        $('<div id="djclChooser"><iframe src="" frameborder="0" scrolling="no" name="djclWindow"></iframe></div>').appendTo("body");
});

function openSelDjcl(func,id)
{
    var url = URL_PREFIX+"/pages/zjimis/workload/djcl/selector.jsp";
    $("#djclChooser").dialog({
        title:"选择预算科目",
        height:480,
        width:745,
        modal:true,
        create:function(){
//            $(this).load(url);
        },
        open:function()
        {
            //clear input
            //$(".selector-div form").trigger("reset");
            window.frames["djclWindow"].location.href = "/zjimis/workload/djcl/selectorIndex.do?model.project.id="+id;
        },
        buttons:{
            "确定":function(){
                var result = window.frames["djclWindow"].pressOK();
                if(result==null)return;
                func(result);
                $(this).dialog("close");
            },
            "取消":function(){
                $(this).dialog("close");
            }
        }
    });
}