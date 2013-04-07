
$(function(){
    if ($("#budgetItemChooser").length == 0)
        $("<div id='budgetItemChooser'/>").appendTo("body");
});

function openSel(func,id)
{
    var url = URL_PREFIX+"/budget/listBudgetItems2.do";
        $("#budgetItemChooser").dialog({
            title:"选择预算科目",
            height:480,
            width:640,
            modal:true,
            create:function(){
                $(this).load(url,{"projectId":id});
            },
            open:function()
            {
                //clear input
                 $(".selector-div form").trigger("reset");
            },
            buttons:{
                "确定":function(){
                    var result = pressOK();
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