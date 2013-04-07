<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<script type="text/javascript" src="${ctx}/pages/archive/open_archive.js"></script>

<LINK href="${ctx}/styles/zjTable.css" type='text/css' rel='stylesheet'>
<title>文件管理</title>
<script type="text/javascript">
	/**
	 * 判断文件是否已经被订阅
	 * （不包含审核未通过）
	 */
	function isArchiveFile(fid){
		if(!fid){
			fid = $('#fileIds').val();
			if(!fid){
				alert('请选择一个借阅文件！');
				return;
			}
		}
		$.ajax({
			url : URL_PREFIX+"/archive/file/lend/isArchiveFile.do",
			type : "POST",
			data : {
				"fileIds" : fid
			},
			dataType : "json",
			success : function(result) {
				// 已经借阅
				if (result.success) {
					alert('该文件已经借阅');
				}else{
					fileLend(fid);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
				return false;
			}
		});
	}
	/**
	* 文件借阅
	*/
	function fileLend(fid){
		if(!confirm('你确定要借阅该文件？（点击确定后将选择审核人）')){
			return;
		}
        window.fid = fid;
		showAuditUser();
	}
	
	/**
	 * 选择显示审核用户 
	 */
	function showAuditUser() {
        openSel(returnAction,undefined,true);
	}

    function returnAction(users)
    {
        var selectIds = "";
        if (users != null) {
            if (users.length > 0) {
                if (users.length > 1) {
                    alert("审核人只能选择一个，默认为第一个选项！");
                }
                selectNames = users[0].name;
                selectIds = users[0].id;
            }
        }
        if(!selectIds){
      			alert('请选择审批人！');
      			return;
      		}

      	$.ajax({
      			url : URL_PREFIX+"/archive/file/lend/lendSave.do",
      			type : "POST",
      			data : {
      				"fileIds" : fid,
      				'auditor' : selectIds
      			},
      			dataType : "json",
      			success : function(result) {
                    $("#userChooser").dialog("close");
      				//如果执行成功，得到合同额
      				if (result.success) {
      					alert('借阅申请成功');
      				}else{
      					alert('发生异常，借阅失败');
      				}
      			},
      			error : function(XMLHttpRequest, textStatus, errorThrown) {
                    $("#userChooser").dialog("close");
      				alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
      				return false;
      			}
      		});
    }

</script>
</head>
<body>
<div class="x-panel">
<div class="x-panel-header" >
	<div style="float: left;">文件借阅</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div class="x-toolbar">
        <s:form action="fileIndex" theme="simple"id="pageQueryForm">
        <s:hidden name="ec_p" id="ec_p"/>
        	<s:hidden name="model.archive.id"/>
			<table width="99%">
				<tr>
					<td width="70%">
						文件名称：<s:textfield id="name" name="model.name" style="width:200px;" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="查询" class="button" />
					</td>
					<td align="right">
						<a href="${ctx}/archive/archiveIndex.do"><img src="${ctx}/images/icons/rem-all.gif">案卷借阅</a>
						&nbsp;
					</td>
				</tr>
			</table>
		</s:form>
</div>
<input type="hidden" id="fileIds">
<div class="x-panel-body">
<table id="fineTable" width="800" align="left">
	<tr>
		<th>序号</th>
        <th>文件号</th>
		<th>文件名称</th>
		<th>密级</th>
		<th>发文单位</th>
		<th>发文时间</th>
		<th>所属案卷</th>
		<th>操作 </th>
	</tr>
	<s:iterator value="#attr.items"  var="item" status="st">
		<tr onmousemove="this.className='trOver';"
			onmouseout="this.className='trOut';">
			<td align="center" width="50">${(page.pageNo - 1) * 20 + st.index + 1}</td>
            <td><a href="javascript:" onclick="openArchiveFile('${item.id}','')" title="查看文件信息"><font color="blue">${item.fileNO}</font></a></td>
			 <td>${item.name}</td>
			<td align="center">${item.dense}</td>
			<td>${item.sendUnit}</td>
			<td align="center" width="100"><fmt:formatDate value="${item.sendDate}" pattern="yyyy-MM-dd"/></td>
			<td>${item.archive.name }</td>
			<td align="center">
				<a href="#" onclick="isArchiveFile('${item.id}')">借阅</a>
		</td>
		</tr>
	</s:iterator>
	<tr>
		<td colspan="13" style="border: 0px; padding-top: 10px;"
			align="right"><%@include file="/pages/common/page.jsp"%>
		</td>
	</tr>
</table>
</div>
</div>

<script type="text/javascript" src="${ctx}/scripts/select.user.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
</body>
</html>