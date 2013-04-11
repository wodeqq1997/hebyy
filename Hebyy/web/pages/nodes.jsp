<%@ page import="com.systop.common.modules.security.user.UserUtil"%>
<%@ page import="com.systop.common.modules.dept.model.Dept"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<script src="${ctx}/scripts/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="${ctx}/scripts/ztree/js/jquery.ztree.core-3.3.min.js"></script>
<script type="text/javascript"
	src="${ctx}/scripts/ztree/js/jquery.ztree.exhide-3.3.min.js"></script>
<link href="${ctx}/scripts/ztree/css/zTreeStyle/zTreeStyle.css"
	rel="stylesheet" type="text/css" />
<style>
html,body {
	padding: 0;
	margin: 0;
}

.nodes-container {
	
}

.ztree li span.button.root_open {
	background-position: -92px -54px;
	width: 30px;
	height: 30px;
}

.ztree li a span {
	font-size: 13px !important;
}

.ztree li a {
	height: 20px;
	line-height: 20px;
}

.ztree li a.level0 {
	height: 25px;
	line-height: 25px;
	font-weight: bold;
	width: 80%;
}
</style>

<script type="text/javascript">
var nodes = [
    {name:"我的桌面", open:true, icon:"${ctx}/images/computer_on_min.png", children:[
        {name:"修改个人资料", url:"${ctx}/security/user/editSelf.do", target:"main", icon:"${ctx}/images/icons/user.gif"},
        {name:"我的待办事项", url:"${ctx}/flow/node/myIndex.do", target:"main", icon:"${ctx}/images/icons/myplan.png"}
        <%--{name:"我的邮件", url:"${ctx}/pages/scos/mail/mailLayout.jsp", target:"main", icon:"${ctx}/images/icons/mail.png"},--%>
       
    ]},
    {name:"公共事物", icon:"${ctx}/images/icons/erp.gif", children:[
        {name:"通知公告", url:"${ctx}/notice/index.do", target:"main", icon:"${ctx}/images/icons/class.gif"},
        {name:"新闻管理", url:"${ctx}/article/index.do", target:"main", icon:"${ctx}/images/icons/article.gif"},
        {name:"",isHidden:true}
    ]},
    {name:"系统管理", icon:"${ctx}/images/bmsz.gif", children:[
		{name:"职位管理", url:"${ctx}/position/index.do", target:"main", icon:"${ctx}/images/icons/folder.gif"},
        {name:"部门管理", url:"${ctx}/admin/dept/index.do", target:"main", icon:"${ctx}/images/icons/folder.gif"},
        {name:"用户管理", url:"${ctx}/security/user/index.do", target:"main", icon:"${ctx}/images/icons/user.gif"},
        {name:"角色管理", url:"${ctx}/security/role/index.do", target:"main", icon:"${ctx}/images/icons/role.gif"},
        {name:"权限管理", url:"${ctx}/security/permission/index.do", target:"main", icon:"${ctx}/images/icons/authority.gif"},
        {name:"资源管理", url:"${ctx}/security/resource/index.do", target:"main", icon:"${ctx}/images/icons/news.gif"},
        {name:"登录记录", url:"${ctx}/userHistory/userHistoryList.do", target:"main", icon:"${ctx}/images/icons/application.gif"}
    ]},
    {name:"个人办公", icon:"${ctx}/images/bmsz.gif", children:[
	{name:"短消息", icon:"${ctx}/images/icons/message.png", children:[
	    {name:"发送短消息", url:"${ctx}/msg/newMsg.do", target:"main", icon:"${ctx}/images/icons/modify.gif"},
	    {name:"接收的个人消息", url:"${ctx}/msg/receiveIndex.do?model.msgType=personal", target:"main", icon:"${ctx}/images/icons/user_go.gif"},
	    {name:"接收的系统消息", url:"${ctx}/msg/receiveIndex.do?model.msgType=sys", target:"main", icon:"${ctx}/images/icons/sms.gif"},
	    {name:"已发的短消息", url:"${ctx}/msg/sendIndex.do", target:"main", icon:"${ctx}/images/icons/diary.png"}
	]},
	{name:"文件传送", icon:"${ctx}/images/icons/mail.png", children:[
	    {name:"发送文件", url:"${ctx}/mail/newMail.do", target:"main", icon:"${ctx}/images/icons/mail_3.gif"},
	    {name:"已收文件", url:"${ctx}/mail/index.do?mailIndexType=receive", target:"main", icon:"${ctx}/images/icons/folder-in.gif"},
	    {name:"已发文件", url:"${ctx}/mail/index.do", target:"main", icon:"${ctx}/images/icons/folder_go.gif"},
	    {name:"草稿箱", url:"${ctx}/mail/indexDraft.do", target:"main", icon:"${ctx}/images/icons/folder_edit.gif"}
	]},                                                  
      	{name:"个人文件柜", icon:"${ctx}/images/forum/bbs.gif", children:[
 		{name:"我的文档", url:"${ctx}/document/index.do?model.isPublic=0", target:"main", icon:"${ctx}/images/icons/file_folder.gif"},                                                         
 		{name:"公共文档", url:"${ctx}/document/index.do?model.isPublic=1", target:"main", icon:"${ctx}/images/icons/folder_table.gif"}                                                                
       ]},
       {name:"下属管理", icon:"${ctx}/images/icons/users.png", children:[
            {name:"我的下属", url:"${ctx}/subuser/index.do", target:"main", icon:"${ctx}/images/icons/users.png"},
            {name:"下属工作日志", url:"${ctx}/diary/subUserDiaryIndex.do", target:"main", icon:"${ctx}/images/icons/diary_sub.gif"}
        ]},
       {name:"工作日志", url:"${ctx}/diary/index.do", target:"main", icon:"${ctx}/images/icons/diary.png"},
       {name:"个人考勤", url:"${ctx}/peopleAtt/edit.do", target:"main", icon:"${ctx}/images/icons/user.gif"},
       {name:"考勤时间", url:"${ctx}/time/edit.do", target:"main", icon:"${ctx}/images/icons/user.gif"},
       {name:"通讯录", url:"${ctx}/security/user/show.do", target:"main", icon:"${ctx}/images/proj/flow_chart.png"}
       ]}    
       ,
       {name:"",isHidden:true},
    {name:"综合行政", icon:"${ctx}/images/bmsz.gif", children:[                                                   
        {name:"会议管理", url:"${ctx}/hybl/queryxx.do", target:"main", icon:"${ctx}/images/icons/erp_min.gif"},
        {name:"会议历史查询", url:"${ctx}/hybl/queryxx1.do", target:"main", icon:"${ctx}/images/icons/erp_min.gif"},
        {name:"规章制度管理", url:"${ctx}/gzzd/queryxx.do", target:"main", icon:"${ctx}/images/icons/visit_p.gif"},
        {name:"图书管理", icon:"${ctx}/images/forum/bbs.gif", children:[
        {name:"图书维护", url:"${ctx}/tsgl/queryxx.do", target:"main", icon:"${ctx}/images/forum/bbs.gif"},
        {name:"图书借还管理", url:"${ctx}/tsgl/queryxx1.do", target:"main", icon:"${ctx}/images/forum/bbs.gif"},
        {name:"图书信息查询", url:"${ctx}/tsgl/queryxx2.do", target:"main", icon:"${ctx}/images/forum/bbs.gif"}
        ]},
         
        {name:"办公用品", icon:"${ctx}/images/icons/office-tackle.png", children:[
            {name:"办公用品管理", url:"${ctx}/goods/index.do", target:"main", icon:"${ctx}/images/icons/office-tackle.png"},
            {name:"物品供应商管理", url:"${ctx}/goods/supplier/index.do", target:"main", icon:"${ctx}/images/icons/office-tackle.png"},
            {name:"办公用品领取", url:"${ctx}/goods/instock/indexDraw.do", target:"main", icon:"${ctx}/images/icons/office-tackle.png"}
        ]},
        {name:"固定资产", icon:"${ctx}/images/icons/a_list.gif", children:[
            {name:"设备物资管理", url:"${ctx}/asset/index.do", target:"main", icon:"${ctx}/images/icons/a_list.gif"},
            {name:"设备物资维修记录", url:"${ctx}/asset/repair/index.do", target:"main", icon:"${ctx}/images/icons/a_list.gif"},
            {name:"设备物资检测记录", icon:"${ctx}/images/icons/a_list.gif", target:"main", url:"${ctx}/asset/check/index.do"},
            {name:"设备进出场记录", url:"${ctx}/asset/storage/index.do", target:"main", icon:"${ctx}/images/icons/a_list.gif"}
        ]}
        ,{name:"考勤管理", url:"${ctx}/attendance/index.do", target:"main", icon:"${ctx}/images/icons/attendance.gif"}
        ,{name:"车辆", icon:"${ctx}/images/icons/car.png", children:[
         {name:"车辆管理", url:"${ctx}/car/index.do", target:"main", icon:"${ctx}/images/icons/car.png"},
         {name:"车辆使用申请", url:"${ctx}/car/apply/myIndex.do", target:"main", icon:"${ctx}/images/icons/car.png"},
         {name:"车辆申请管理", url:"${ctx}/car/apply/index.do", target:"main", icon:"${ctx}/images/icons/car.png"},
         {name:"汽车使用记录", url:"${ctx}/car/record/index.do", target:"main", icon:"${ctx}/images/icons/car.png"},
         {name:"车辆交接记录", url:"${ctx}/car/transfer/index.do", target:"main", icon:"${ctx}/images/icons/car.png"},
         {name:"车辆维护记录", url:"${ctx}/car/repair/index.do", target:"main", icon:"${ctx}/images/icons/car.png"}
     ]}
        ]},
        {name:"网上交流", icon:"${ctx}/images/forum/comm.gif", children:[
   		{name:"信息交流", url:"${ctx}/pages/admin/security/user/skype/index.jsp", target:"main", icon:"${ctx}/images/icons/skype.gif"},
        {name:"视频会议", url:"${ctx}/pages/video/videoClientSystopCms.jsp", target:"main", icon:"${ctx}/images/icons/vido.png"},
        {name:"讨论区", url:"${ctx}/forum/board/index.do", target:"main", icon:"${ctx}/images/icons/down.gif"},
        {name:"论坛管理", icon:"${ctx}/images/forum/bbs.gif", children:[
            {name:"论坛.板块", url:"${ctx}/forum/board/adminIndex.do", target:"main", icon:"${ctx}/images/icons/more2.gif"},
            {name:"论坛.帖子", url:"${ctx}/forum/topic/index.do", target:"main", icon:"${ctx}/images/icons/a_list.gif"}
        ]},
        {name:"投票管理", url:"${ctx}/survey/index.do", target:"main", icon:"${ctx}/images/icons/ask.gif"}
        ,
        {name:"投票", url:"${ctx}/survey/view.do", target:"main", icon:"${ctx}/images/icons/ask.gif"},
        
        {name:"",isHidden:true}
       ]},
       {name:"实用工具", icon:"${ctx}/images/forum/comm.gif", children:[
    	{name:"火车时刻", url:"http://www.huoche.com.cn/", target:"_blank", icon:"${ctx}/images/icons/skype.gif"},
        {name:"飞机航班", url:"http://flight.qunar.com/status/alphlet_order.jsp?ex_track=bd_aladding_flightsk_title", target:"_blank", icon:"${ctx}/images/icons/vido.png"},
        {name:"邮编/区号", url:"http://post.tao123.com/", target:"_blank", icon:"${ctx}/images/icons/down.gif"},
        {name:"国际时间", url:"http://www.china.org.cn/worldclock/worldclock.htm", target:"_blank", icon:"${ctx}/images/icons/down.gif"},
        {name:"",isHidden:true}
        ]}
       ,
       {name:"人力资源", icon:"${ctx}/images/hrm/hr.jpg", children:[
       	{name:"",isHidden:true}
           ,{name:"考勤", icon:"${ctx}/images/icons/attendance.gif", children:[
               {name:"部门考勤上报", url:"${ctx}/reportedAtte/index.do", target:"main", icon:"${ctx}/images/icons/attendance.gif"}
           ]},
           {name:"员工", icon:"${ctx}/images/hrm/training.gif", children:[
           {name:"员工信息", url:"${ctx}/enterpriseext/showUsers.do", target:"main", icon:"${ctx}/images/hrm/training.gif"},
           {name:"员工合同", url:"${ctx}/empcontract/showUsers.do", target:"main", icon:"${ctx}/images/hrm/training.gif"},
           {name:"简历管理", url:"${ctx}/resume/index.do", target:"main", icon:"${ctx}/images/icons/curriculum_vitae.png"}
             
          ]}
       ] }
       ,
        {name:"档案管理", icon:"${ctx}/images/icons/roll_manage.gif", children:[
        {name:"案卷管理", target:"main", url:"${ctx}/archive/index.do",icon:"${ctx}/images/icons/roll_manage.gif"},
        {name:"文件管理", target:"main", url:"${ctx}/archive/file/index.do",icon:"${ctx}/images/icons/roll_manage.gif"},
        {name:"案卷借阅", url:"${ctx}/archive/file/lend/index.do", target:"main", icon:"${ctx}/images/icons/roll_manage.gif"},
        {name:"案卷借阅记录", target:"main", url:"${ctx}/archive/file/lend/allIndex.do",icon:"${ctx}/images/icons/roll_manage.gif"}

     ]}

];
var setting = {
    view:{
        dblClickExpand:false,
        showLine:false
    },
    callback:{
        beforeExpand:beforeExpand,
        onExpand:onExpand,
        onClick:onClick
    }
};

//只允许同时展开一个节点
var curExpandNode = null;
function beforeExpand(treeId, treeNode) {
    var pNode = curExpandNode ? curExpandNode.getParentNode() : null;
    var treeNodeP = treeNode.parentTId ? treeNode.getParentNode() : null;
    var zTree = $.fn.zTree.getZTreeObj("nodes");
    for (var i = 0, l = !treeNodeP ? 0 : treeNodeP.children.length; i < l; i++) {
        if (treeNode !== treeNodeP.children[i]) {
            zTree.expandNode(treeNodeP.children[i], false);
        }
    }
    while (pNode) {
        if (pNode === treeNode) {
            break;
        }
        pNode = pNode.getParentNode();
    }
    if (!pNode) {
        singlePath(treeNode);
    }

}

function singlePath(newNode) {
    if (newNode === curExpandNode) return;
    if (curExpandNode && curExpandNode.open == true) {
        var zTree = $.fn.zTree.getZTreeObj("nodes");
        if (newNode.parentTId === curExpandNode.parentTId) {
            zTree.expandNode(curExpandNode, false);
        } else {
            var newParents = [];
            while (newNode) {
                newNode = newNode.getParentNode();
                if (newNode === curExpandNode) {
                    newParents = null;
                    break;
                } else if (newNode) {
                    newParents.push(newNode);
                }
            }
            if (newParents != null) {
                var oldNode = curExpandNode;
                var oldParents = [];
                while (oldNode) {
                    oldNode = oldNode.getParentNode();
                    if (oldNode) {
                        oldParents.push(oldNode);
                    }
                }
                if (newParents.length > 0) {
                    for (var i = Math.min(newParents.length, oldParents.length) - 1; i >= 0; i--) {
                        if (newParents[i] !== oldParents[i]) {
                            zTree.expandNode(oldParents[i], false);
                            break;
                        }
                    }
                } else {
                    zTree.expandNode(oldParents[oldParents.length - 1], false);
                }
            }
        }
    }
    curExpandNode = newNode;
}

function onExpand(event, treeId, treeNode) {
    curExpandNode = treeNode;
}

function onClick(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("nodes");
    zTree.expandNode(treeNode, null, null, null, true);
}

$(function () {
    $.fn.zTree.init($("#nodes"), setting, nodes);
    var zTree = $.fn.zTree.getZTreeObj("nodes");
    curExpandNode = zTree.getNodeByTId("nodes_1");
})
</script>
</head>
<body>
<div class="nodes-container">
<ul id="nodes" class="ztree"></ul>
</div>
</body>
</html>