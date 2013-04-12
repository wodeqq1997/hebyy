<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp" %>
<html>
<head>
<title></title>
<%@include file="/common/meta.jsp" %>
<%@include file="/common/validator.jsp"%>
<title>批量导入供应商数据</title>
<style type="text/css">
.overlay{
	position:fixed;
	top:0;
	right:0;
	bottom:0;
	left:0;
	z-index:99998;
	width:100%;
	height:100%;
	_padding:0 20px 0 0;
	background:#f6f4f5;
	display: none;
	}
.showbox{
	filter:Alpha(Opacity="0");
	position:fixed;
	top:0;
	left:30%;
	z-index:99999;
	opacity:0;
	margin-top:200px;
	}
#AjaxLoading{
	border:1px solid #8CBEDA;
	color:#37a;
	font-size:12px;
	font-weight:bold;
	}
#AjaxLoading div.loadingWord{
	width:300px;text-align:center;
	height:50px;
	line-height:50px;
	border:2px solid #D6E7F2;
	background:#fff;}
#AjaxLoading img{
	margin:10px 15px;
	float:left;
	display:inline;
	}
</style>
</head>
<body>
<div class="x-panel">
<div class="overlay">
</div>
<div id="AjaxLoading" class="showbox" style="display: none">
	<div class="loadingWord"><img src="${ctx}/images/hrm/waiting.gif">正在执行后续操作，请稍候...</div>
</div>
<div><%@ include file="/common/messages.jsp"%></div>
<div id="importEmployee" class="showImport">
<s:form action="importSupplier" id="save" method="post" theme="simple" validate="true"
 namespace="/employee" enctype="multipart/form-data">

	<s:hidden id="model.id" name="model.id"/>
	<table width="600px" align="center"> 
	     <tr>
			<td align="center">
			<fieldset style="margin:10px;">
              <legend>批量导入供应商数据</legend>
                <table>
                  <tr>
                     <td align="right" width="150">选择文件：</td>
                     <td><s:file name="upload" cssClass="FileText" cssStyle="width:400px"  id="upload"/></td>
                  </tr>
                </table> 
              </fieldset>
              <table width="100%" style="margin-bottom:10px;">
				<tr>
					<td style="text-align:center;">
						<s:submit value="上传" cssClass="button" onclick="noSubAgain()" />
						<s:reset value="重置" cssClass="button"/>
                    </td>
              	</tr>
              </table>
			</td>
		</tr>
	</table>
	</s:form>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
	$("#save").validate();
});
	
	function noSubAgain(){
				alert("dddddddd");
		$(".showbox").css('display','inline');
		$(".showImport").css('display','none');
		$(".showbox").css('display','block');
		$(".loadingWord").css('display','block');
		$(".overlay").css('display','block');
		$(".overlay").css('opacity','0.8');
		$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
	}
</script>
</body>

</html>