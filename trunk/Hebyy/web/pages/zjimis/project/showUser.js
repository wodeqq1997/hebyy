document.write('\
<script type="text/javascript" src="'+URL_PREFIX+'/scripts/select.user.js"></script>\
');

if(typeof jQuery.ui==="undefined"){
document.write('\
<script type="text/javascript" src="'+URL_PREFIX+'/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>\
<link href="'+URL_PREFIX+'/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>');
}
/**
 * 选择显示审核用户 
 * obj:输入框对象
 * clear:是否清楚之前选项（true清楚）
 * authoritys:人力资源--职位管理--职位权限。
 */
function showAuditUser(obj,clear,authoritys) {
    openSel(function (users) {
        var selectNames = "";
        var selectIds = "";
        var ids = document.getElementById("auditor");
        if (users.length > 0) {
            if (users.length > 1) {
                alert("审核人只能选择一个，默认为第一个选项！");
            }
            selectNames = users[0].name;
            selectIds = users[0].id;
        }
        ids.value = selectIds;
        obj.value = selectNames;
        // 单选多选
    },clear,true,authoritys);
}

/**
 * 选择显示负责用户
 */
function showPresideUser(obj,clear){
    openSel(function(users){
        var selectNames = "";
       	var selectIds = "";
       	var ids = document.getElementById("userId");
        if (users != null){
      			if(users.length > 0){
      				if(users.length > 1){
      					alert("审核人只能选择一个，默认为第一个选项！");
      				}
      				selectNames = users[0].name;
      				selectIds = users[0].id;
      			}
      		}
      		ids.value = selectIds;
      		obj.value = selectNames;
    },clear,true);
}