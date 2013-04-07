<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>已发信息列表</title>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" style="color: maroon;">已经发送的短消息</div>
<div class="x-toolbar">
  <form action="sendIndex.do" method="post" id="pageQueryForm"> 
  <table width="99%">
    <tr>
      <td> 
		&nbsp;&nbsp;
		&nbsp;接收人：<s:textfield name="model.receiver.name" />
		&nbsp;从：<input type="text" name="startDate" readonly="readonly" value='<s:date name="startDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
		&nbsp;至：<input type="text" name="endDate" readonly="readonly" value='<s:date name="endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" value="查询" class="button">
		<s:hidden name="ec_p" id="ec_p"/>
      </td>
      <td align="right">
	  	<a href="#" onclick="onRemove()">
	  	  <img src="${ctx}/images/icons/delete.gif">&nbsp;删除
	  	</a>
      </td>
    </tr>
  </table>
  </form>
</div>
<div class="x-panel-body">
<form id="ec">
<table id="fineTable" width="800" style="margin-left: 0px;margin-top: 0px">
				<tr>
					<th>序号</th>
                    <th>接收人</th>
					<th>内容</th>
					<th>发送时间</th>
					<th>状态</th>
				</tr>
				<s:iterator value="#attr.items"  var="item" status="st">
					<tr onmousemove="this.className='trOver';"
						onmouseout="this.className='trOut';">
						<td>${(page.pageNo-1)*20 + st.index+1}</td>
	                    <td align="center"><s:if test="#attr.item.sender != null">
				${item.receiver.name}
			</s:if>
			<s:elseif test="#attr.item.msgType == @com.systop.scos.communicate.smsg.MsgConstants@IS_SYS">
				系统消息
			</s:elseif></td>
						<td align="center">${item.title}</td>
						<td align="center"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
						<td align="center"><s:if test="#attr.item.isRead == 1"><div style="color:#339933;font-weight:bold;">已读</div></s:if>
			<s:else><div style="color:red;font-weight:bold;">未读</div></s:else></td>
					</tr>
				</s:iterator>
				<tr>
					<td colspan="13" style="border: 0px; padding-top: 10px;"
						align="right"><%@include file="/pages/common/page.jsp"%>
					</td>
				</tr>
			</table>
			</form>
</div>
</div>
<script type="text/javascript">
  function remove(id) {
    Ext.MessageBox.confirm('提示','确认要删除这条信息吗？删除后不能恢复！', function(btn){
        if (btn == 'yes') {
          window.location = "${ctx}/msg/sendDel.do?model.id=" + id;
        }
    });
  }
  function onRemove(){
		 var sels = document.getElementsByName("selectedItems");
		    var checked = false;;
		    for(i = 0; i < sels.length; i++) {
		        if(sels[i].checked) {
		           checked = true;
		           break;
		        }
		    } 
		    if(!checked) {
		    	alert("请选择要删除的消息!");
		    	return;
		    }
		    if (confirm("确定要删除所选择的消息吗？删除后不能恢复!")){
		        	var from = document.getElementById("ec");
		    		from.action="sendRemove.do";
		    		from.submit();
		    }
	}
</script>
 <script type="text/javascript">
 function view(id){
		window.location.href="view.do?model.id=" + id + "&updateState=N";
	}
 </script>
</body>
</html>