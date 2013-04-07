<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.systop.common.modules.security.user.UserConstants"%>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%
    try {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("urlFrom"))
            {
                String value = cookie.getValue();
                if(value!=null && !value.equals(""))
                {
                    cookie.setMaxAge(0);
                    cookie.setPath("/zjimis");
                    response.addCookie(cookie);
                    response.sendRedirect(URLDecoder.decode(value));
                }
            }
        }
    } catch (Exception e) {
    }
%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>
<%@include file="/common/jqueryUI.jsp"%>

<script type="text/javascript" src="${ctx}/scripts/jquery/jgrowl/jquery.jgrowl_minimized.js"></script>
<script type="text/javascript" src="${ctx}/scripts/sound/soundmanager2-jsmin.js"></script>

<link rel="stylesheet" href="${ctx}/scripts/jquery/jgrowl/jquery.jgrowl.css" type="text/css"/>

<script src="${ctx}/scripts/utils.js"></script>
<link href="${ctx}/pages/layout.css" type='text/css' rel='stylesheet'/>
<title>河北演艺集团综合管理信息系统</title>
<style type="text/css">
    #west
    {
        height: 100%;
    }
    #south{
        display: none;
    }
</style>
</head>
<body>

	<script type="text/javascript">
	Ext.onReady(function() {

		Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

		new Ext.Viewport( {
			layout : 'border',
			items : [ new Ext.BoxComponent( { // raw
						region : 'north',
						el : 'north',
						height : 56,
						margins : '0'
					}),
                {
				region : 'west',
				title : '&nbsp;',
				split : true,
				width : 170,
				minSize : 170,
				maxSize : 400,
				collapsible : true,
				margins : '0',
                contentEl:'west'
			},
			{
				region : 'center',
				contentEl : 'center',
				split : true,
				border : true,
				margins : '0 5 0 0'
			} ,
			{
				region : 'south',
				contentEl : 'south',
				baseCls:'x-plain',
				split : false,
				border : true,
				margins : '5'
			} ]
		});
		//alert($('#west').height());
        $(".menu-iframe").show();

	});
</script>
<div id="west">
    <iframe src="${ctx}/nodes.do" style="border:none;width: 100%;height: 100%;display: none;" frameborder="0" class="menu-iframe"></iframe>
</div>
<div id="north" align="center" style="margin-top: 4px;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="left" width="500">
		  <div  style="margin-top: -5px; width: 450px; height: 55px; background-image: url('${ctx}/images/scos/top.jpg');">&nbsp;</div>
		</td>
		<td align="right" style="padding-right: 10px;">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td rowspan="2" width="80" align="center">
					  <a href="${ctx}/pages/main.jsp" target="main" style="color: #336699">
						<img src="${ctx}/images/computer_on.png" width="30" style="margin-bottom: 2px;"><br>办公桌面</a>
					</td>
					<td rowspan="2" width="100" style="padding-left: 5px;">
						<img src="${ctx}/images/hrm/development.png">&nbsp;${loginUser.dept.name}<br>
						<a href="${ctx}/position/viewUserPosition.do?model.id=${loginUser.position.id}" target="main">
							<img src="${ctx}/images/hrm/hrm-briefcase.png">&nbsp;${loginUser.position.name}</a>
					</td>
					<td height="27">
						<div id=localtime></div>
					</td>
				</tr>
				<tr>
					<td height="27">
						<stc:ifLogin>
							<a href="${ctx}/security/user/editSelf.do" target="main">
								<img src="${ctx}/images/hrm/hireIssue.jpg">&nbsp;${loginUser.name}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:logout()" target="_self" style="color: #336699">
								<img src="${ctx}/images/icons/lock_go.gif">&nbsp;注销 </a>
						</stc:ifLogin>
						<stc:ifNotLogin>
							<a href="${ctx}/login.jsp" target="_self" style="color: #336699">
								<img src="${ctx}/images/icons/user_go.gif">&nbsp;登录 </a>
						</stc:ifNotLogin>
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>
</div>
<div id="center" style="height: 100%">
	<iframe id="main" name="main" src="${ctx}/pages/main.jsp" style="width:100%; height:100%; border:0px;" frameborder="0" scrolling="auto">
	</iframe>
</div>
<div id=south>&nbsp;【河北演艺集团】&nbsp;【用户：${loginUser.name}】&nbsp;【部门：${loginUser.dept.name}】&nbsp;【位置：<span id="userLocation"></span>】</div>
<div id="aSound"></div>
<script type="text/javascript">
	soundManager.url = '${ctx}/scripts/sound/swf'; // directory where SM2 .SWFs live
	soundManager.debugMode = false;
	
	function palySound(){
		soundManager.onready(function() {
			var mySound = soundManager.createSound({
				id : 'aSound',
				url : '${ctx}/images/newlist.mp3'
			});
			mySound.play();

		});
	}

	$.jGrowl.defaults.position = "bottom-right";
	$.jGrowl.defaults.life = 13000;
	$.jGrowl.defaults.pool = 5;
	$.jGrowl.defaults.closerTemplate='<div>[全部关闭] &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="readAllMsgs()" style="color: red;">【全部已读】</a></div>';
	
	// 设置消息全部已读
	function readAllMsgs(){
		//if(confirm("确定要将所有未读消息设置为已读？")){
			$.ajax({
				url : '${ctx}/msg/ajaxReadAllMsgs.do',
				type : 'post',
				dataType : 'json',
				error : function() {
					//alert('check new msg error');
				},
				success : function(result) {
					if(!result.success){
						alert('已读设置失败！');
					}
				}
			});
		//}
	}

	function checkNewMsg() {
		$.ajax({
					url : '${ctx}/msg/checkNewMsgs.do',
					type : 'post',
					dataType : 'json',
					error : function() {
						//alert('check new msg error');
					},
					success : function(data, textStatus) {
						if (data == null || data.length == 0) {
							return;
						}
						palySound();
						var htmlStr = null;
						var num = 0;
						for ( var i = 0; i < data.length; i++) {
							num = i + 1;
							htmlStr = "";
							htmlStr += "<div style='width:200px; height:20px; padding:0px;'>";
							htmlStr += "<a href='${ctx}/msg/view.do?model.id="+ data[i][0]
									+ "&updateState=Y' target='main'><b>" + num + "</b>. " 
									+ data[i][1] + "</a>";
							htmlStr += "</div>";
							$.jGrowl(htmlStr);
						}
					}
				});
	}
	window.setInterval("checkNewMsg()", 90000);
	checkNewMsg();

	function showLocale(objD) {
		var str, spanHead, spanFoot;
		var yy = objD.getYear();
		if (yy < 1900)
			yy = yy + 1900;
		var MM = objD.getMonth() + 1;
		if (MM < 10)
			MM = '0' + MM;
		var dd = objD.getDate();
		if (dd < 10)
			dd = '0' + dd;
		var hh = objD.getHours();
		if (hh < 10)
			hh = '0' + hh;
		var mm = objD.getMinutes();
		if (mm < 10)
			mm = '0' + mm;
		var ss = objD.getSeconds();
		if (ss < 10)
			ss = '0' + ss;
		var ww = objD.getDay();
		if (ww == 0)
			ww = "星期日";
		if (ww == 1)
			ww = "星期一";
		if (ww == 2)
			ww = "星期二";
		if (ww == 3)
			ww = "星期三";
		if (ww == 4)
			ww = "星期四";
		if (ww == 5)
			ww = "星期五";
		if (ww == 6)
			ww = "星期六";
		spanHead = "<span style='font-size: 12px; font-weight: bold; padding-right: 15px; color: #D22622; font-family: sans-serif;'>";
		spanFoot = "</span>";
		str = spanHead + yy + "-" + MM + "-" + dd + "&nbsp;" + ww + "&nbsp;"
				+ hh + ":" + mm + ":" + ss + spanFoot;
		return (str);
	}
	function tick() {
		var today;
		today = new Date();
		document.getElementById("localtime").innerHTML = showLocale(today);
		window.setTimeout("tick()", 1000);
	}
	tick();
  $(function(){
    var loc = _getCookie("userLocation");
    $("#userLocation").html(loc);

  });
</script>

    <c:if test="${sessionScope.positioned eq null}">
    <script type="text/javascript">
        $(function () {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    //save location to server
                    var latitude = position.coords.latitude;
                    var longitude = position.coords.longitude;
                    //locationInBaidu(latitude, longitude,$("#userLocation"));
                    $.get("${ctx}/security/user/saveLocation.do",{latitude:latitude,longitude:longitude},function(){
                        //todo
                    });
                });
            }
            else
            {
//                alert("您的浏览器不支持侦测地址");
            }
        });

    </script>
    </c:if>
<script type="text/javascript" src="${ctx}/scripts/cookie.js"></script>
    <!--[if !IE]>-->
    <%--<script type="text/javascript" src="${ctx}/scripts/geo.js"></script>--%>
    <!--<![endif]-->
<script>
    var logoutUrl = "${ctx}/security/user/updateStatus.do";
    var statusTimer;
    $(function(){
        //update online statuss per 5 min
        $.get(logoutUrl);
        statusTimer = setInterval(function(){
            //issue 846 todo
            $.get(logoutUrl,{"time":new Date().getTime()},function(data){
/*                if(data.logout=="true"){
                    $("<div></div>").dialog({
                        buttons:{
                            "取消":function(){
                                clearTimeout(outTimer);
                                $(this).dialog("close");
                            }
                        }
                        ,title:"会话超时，请重新登录！"
                        ,modal:true
                    });
                    outTimer = setTimeout(function(){
                        logout();
                    },15*1000)
                }*/
            });
        },5*60*1000);
    });

    function logout(){
        clearTimeout(statusTimer);
        var redirect = function(){
            location.href = "${ctx}/j_acegi_logout";
        }
        //issue 847
        $.ajax({
            url:logoutUrl,
            data:{"logout":"true"},
            success:redirect,
            error:redirect
        })
    }

</script>
</body>
</html>
