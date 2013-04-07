
$(function () {
    if ($("#projectChooser").length == 0)
        $("<div id='projectChooser' style='display:none'/>").appendTo("body");

});
function openProject(func, sign,clear, one) {
        $("#projectChooser").dialog({//645,510
            height:510,
            width:720,
            modal:true,
            title:"选择项目",
            create:function () {
                var param = "";
                if(sign && sign!="" )
                    param = "?sign="+sign;
                $(this).load(URL_PREFIX + "/pages/zjimis/project/project/selector/selector.jsp"+param);//sign=1就是本人的项目,默认是全部项目
                if(!$.browser.msie)
                {
                    $(this).addClass("container-height");
                }
            },
            open:function () {
                if($.browser.msie && $.browser.version<8)
                {
                    var param = "";
                    if(sign && sign!="" )
                        param = "?sign="+sign;
                    $(this).load(URL_PREFIX + "/pages/zjimis/project/project/selector/selector.jsp"+param);
                }
            }

        });


    //保存
    this.saveProject = function (project) {
        try{
            func(project);
        }
        catch(e){}
        $("#projectChooser").dialog("close");
    }

    //直接关闭
    this.closeProject = function () {
        $("#projectChooser").dialog("close");
    }
}

//快捷调用
if(typeof openSelector ==="undefined"){
openSelector = function(sign,projectName){
    //$('#projectName').attr("disabled", true);
    openProject(function (project) {
        if (project) {
            $('#projectId').val(project.id);
            if(projectName)
                projectName.value = project.name;
            else
            $('#projectName').val(project.name);
        }
        else{
            //清除输入,如果是自定义的函数,还是需要自己
            $("#projectId").val("");
            if(projectName)
                $(projectName).val("");
            else
                $('#projectName').val("");
        }
    },sign);
    //$('#projectName').attr("disabled", false);
}
}





