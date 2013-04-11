<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%@include file="/pages/common/taglibs.jsp"%>
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>
<script type="text/javascript"
	src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css'
	rel='stylesheet'>

<title>图书信息编辑页面</title>
</head>
<body>
<div class="x-panel-header">
<div style="float: left;">图书信息编辑页面</div>
</div>
<div id="content"><s:form id="save" method="post" validate="true">
	<fieldset><legend>基本信息</legend>
	<table border="0" align="center" style="line-height: 30px; width: 750">

		<tr>
			<td width="150" align="right"> 图书名称：</td>
			<td width="300">
			<s:textfield name="model.tsMc"   style="width: 260px;"  cssClass="required"  maxlength="255"/>
						<font color="red">*</font>
				</td>
			<td width="300" rowspan="6" align="center">
			<div style="border: 1px solid #ccc; width: 250px; height: 270px;">
			<s:if
				test="model.id != null && model.bookPhoto != null && model.bookPhoto != ''">
				<img id="photo" src="${ctx}${model.fileAttch.path}" width="250px"
					height="270px" />
			</s:if> <s:else>
				<img id="photo" src="${ctx}/images/scos/defaultcarpic.gif"
					width="250px" height="270px" />
			</s:else></div>
			</td>

		</tr>
		<tr>
			<td align="right"> 图书作者：</td>
			<td>
			<s:textfield name="model.author"   style="width: 260px;"  cssClass="required"  maxlength="255"/>
						<font color="red">*</font>
				</td>

		</tr>
		<tr>
			<td align="right">图书类别：</td>
			<td><s:select name="model.lbmc" list='names'
				cssStyle="width:256px;height:22px; " cssClass="typeCheck"  headerKey="" headerValue="请选择" />
				<span id="typeDescn"></span>
				<font color="red">*</font>
				</td>
		</tr>
		<tr>
			<td align="right">图书照片：</td>
			<td><s:if
				test="model.bookPhoto == null || model.bookPhoto == ''">
				<div id="file_buttom">
				<table>
					<tr>
						<td><input type="file" id="systop_upload" />&nbsp;</td>
						<td><span style="color: #EB2A03">照片大小在5M以内!</span></td>
					</tr>
				</table>
				</div>
				<div id="systop-uploaded-files"><s:hidden id="fileAttchIds"
					name="model.bookPhoto" onpropertychange="updateCarPhoto();" /></div>
				<div id="systop_file_list"></div>
			</s:if> <s:else>
				<a href="${ctx}/tsgl/removeBookPhoto.do?id=${model.id}"><font
					color="red">删除照片</font></a>
			</s:else></td>
		</tr>

		<tr>
			<td align="right">入库数量：</td>
			<td>
			<s:textfield name="model.totalNum"   style="width: 260px;"  cssClass="required number"  maxlength="255"/>
						<font color="red">*</font>
		</tr>

		<tr>
			<td align="right"> 入库时间：</td>
			<td><input type="text" id="rktime" name="model.rkTime"
				style="width: 256px;" readonly="readonly"
				value='<s:date name="model.rkTime" format="yyyy-MM-dd"/>'
				onClick="WdatePicker({skin:'blueFresh'})" class="Wdate"/ >
				<span id="dateDescn"></span>
				<font color="red">*</font>
			</td>

		</tr>




		<tr>
			<td align="right">图书描述：</td>
			<td colspan="2"><s:textarea id="ms" name="model.descn"
				cssStyle="width:580px;height: 80px;" /> <s:hidden name="model.id" />
			</td>
		</tr>

		<tr>
			<td colspan="6" style="border: 0px;" align="center"><%@include
				file="/pages/common/messages.jsp"%> <input
				type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;<input type="button"
				onclick="javascript:window.location.href='${ctx}/tsgl/queryxx.do';"
				class="button" value=" 返 回 "></td>

		</tr>
	</table>
	</fieldset>

</s:form></div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").validate();
	});
	
	$(function() {
		$.validator.addMethod("typeCheck", function(value, element) {
			if (value == null || value.length == 0) {
				return false;
			} else {
				$("#typeDescn").html("");
				return true;
			}
		}, "必填");
		
		$.validator.addMethod("Wdate", function(value, element) {
			var res = "";
			if (value == null || value.length == 0) {
				res = "err";
				$("#dateDescn").html("<font color='red'>日期不允许为空</font>");
			}else {
				$("#dateDescn").html("");
				var d = new Date();   // 获得当前日期
				var vYear = d.getFullYear();
				var vMon = d.getMonth() + 1;
				var vDay = d.getDate();
				var dd = vYear+"-"+vMon+"-"+vDay;
				
				var stdt=new Date(value.replace("-","/"));
				var etdt=new Date(dd.replace("-","/"));
				if(stdt > etdt){
					res = "err";
					$("#dateDescn").html("<font color='red'>日期不允许大于当前日期</font>");
				}else{
					$("#dateDescn").html("");			
				}
			}
			return res != "err";
		}, "");
	});
	
	function jkjsSave() {
		$('#save').attr("action", "${ctx}/tsgl/jkjsSave.do");
		$('#save').submit();
	}

	//渲染上传组件
	renderUploader(false, '*.jpg; *.gif; *.png', '图片(JPG; GIF; PNG)', 5000000);
	function updateCarPhoto() {
		var fileAttchId = $('#fileAttchIds').val();
		if (fileAttchId == null || fileAttchId == "") {
			$("#photo").attr("src",
					URL_PREFIX + "/images/scos/defaultcarpic.gif");
		} else {
			showCarPhoto(fileAttchId);
		}
	}
	/**
	 * 显示图片
	 * 
	 * @param fileIds
	 */
	function showCarPhoto(fileIds) {
		if (fileIds == null || fileIds.length == 0) {
			return;
		}
		$.ajax({
			url : URL_PREFIX + '/fileattch/findFiles.do?fileIds=' + fileIds,
			type : 'get',
			dataType : 'json',
			error : function() {
				alert('get file list error');
			},
			success : function(data, textStatus) {
				if (data != null && data.files != null) {
					for ( var i = 0; i < data.files.length; i++) {
						// 文件信息
						$("#photo")
								.attr("src", URL_PREFIX + data.files[i].path);
					}
				}
			}
		});
	}
</script>

<s:if test="model.id != null">
	<script type="text/javascript">
	viewFileAttchList('${model.bookPhoto}', true);
</script>
</s:if>
</body>
</html>