<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/pages/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript">
	var URL_CTX = '${ctx}';
</script>
 
 
<%@include file="/pages/common/meta.jsp"%>
<%@include file="/pages/common/validator.jsp"%>
<%@include file="/common/kindeditor.jsp"%>
    <%@include file="/common/uploadify.jsp"%>
    <script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
    <link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
    
<style type="text/css">
td {
	padding: 4px 2px 2px 3px;
}

select {
	border: 1px solid #CCC;
}

textarea {
	padding: 5px;
	width: 520px;
	height: 70px;
}

.td1 {
	text-align: right;
}
</style>
<title>会议编辑页面</title>
</head>
<body>
	<div class="x-header" style="border-bottom: 1px solid #99bbe8;" >
		当前位置： <span class="r_nav_item">会议信息记录</span> <span
			class="r_nav_item">会议编辑页面</span>
	</div>


		<s:form id="bmxxForm" method="post" validate="true">
 <fieldset>
			    <legend>基本信息</legend>
				<table border="0" align="center" style="line-height: 30px;width:100%">
		


				<tr>
					<th colspan="6" align="left">基本信息</th>
				</tr>
				
				<tr>

					<td width="125" align="right"><span class="warn">*</span>会议文件名称:</td>
					<td width="575"><input id="pnanme" name="model.hyMc"
						value="${model.hyMc}" maxlength="255"  style="width: 260px;" > <s:hidden name="model.id" /></td>
						
				</tr>
				
			<tr>

					<td width="125" align="right"><span class="warn">*</span>会议纪要类别:</td>
					<td width="575">
					<s:if test='#attr.model.hytype == "董事会议纪要"'>
							<s:select name="model.hytype"
								cssStyle="width:260px; height:22px;" list="{'董事会议纪要','党委会议纪要','总经理会议纪要','经理会议纪要'}"
								headerKey="董事会议纪要" headerValue="董事会议纪要"
								 />
						</s:if> 
						
						<s:if test='#attr.model.hytype == "党委会议纪要"'>
							<s:select name="model.hytype"
								cssStyle="width:260px; height:22px;" list="{'董事会议纪要','党委会议纪要','总经理会议纪要','经理会议纪要'}"
								headerKey="党委会议纪要" headerValue="党委会议纪要" />			
						</s:if>
						
						 <s:if test='#attr.model.hytype == "总经理会议纪要"'>
							<s:select name="model.hytype"
								cssStyle="width:260px; height:22px;" list="{'董事会议纪要','党委会议纪要','总经理会议纪要','经理会议纪要'}"
								headerKey="总经理会议纪要" headerValue="总经理会议纪要"  />
						</s:if> 
						 <s:if test='#attr.model.hytype == "经理会议纪要"'>
							<s:select name="model.hytype"
								cssStyle="width:260px; height:22px;" list="{'董事会议纪要','党委会议纪要','总经理会议纪要','经理会议纪要'}"
								headerKey="经理会议纪要" headerValue="经理会议纪要" />
						</s:if> 
						
						<s:if test='#attr.model.hytype != "董事会议纪要"&&#attr.model.hytype != "党委会议纪要"&&#attr.model.hytype != "总经理会议纪要"&&#attr.model.hytype != "经理会议纪要"'>
							<s:select name="model.hytype" maxLength="18"
								cssStyle="width:260px; height:22px;" list="{'董事会议纪要','党委会议纪要','总经理会议纪要','经理会议纪要'}"
								headerKey="" headerValue="请选择"  />
						</s:if>
					
					</td>
				</tr>
				<tr>

					<td width="125" align="right"><span class="warn">*</span>文件号:</td>
					<td width="575"><input id="wjh" name="model.wjh"
						value="${model.wjh}" maxlength="255"  style="width: 260px;" > </td>

				</tr>
				<tr>

					<td width="125" align="right"><span class="warn">*</span>文件页/份数:</td>
					<td width="575"><input id="wjNum" name="model.pageNum"
						value="${model.pageNum}" maxlength="255"  style="width: 260px;" > </td>

				</tr>
				
				<tr>
					<td  align="right">参 与 人:</td>
					<td><input id="szxx" name="model.hycyr" value="${model.hycyr}" style="width: 260px;" ></td>

				</tr>
				<tr>
					<td  align="right"><span class="warn">*</span> 会议时间:</td>
					<td>
					<input id="hytime" type="text" name="model.hyTime" style="width: 260px;" readonly="readonly" 
							   value='<s:date name="model.hyTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" /></td>

				</tr>
				<tr>
					<td  align="right">备注:</td>
					<td>
					<s:textarea id="content"  name="model.hyContent"  cssStyle="width:260px;height: 45px;"/>
					</td>
				</tr>
				 <tr>
                        <td align="right">上传会议记录：</td>
                        <td>
                            <table>
                                <tr>
                                    <td><input type="file" id="systop_upload" />&nbsp;</td>
                                    <td><span style="color: #EB2A03">附件大小在30M以内!</span></td>
                                </tr>
                            </table>
                            <div id="custom">
                                <div id="systop-file-queue"></div>
                            </div>
                            <div id="systop-uploaded-files" style="width: 650px; border-bottom: 1px solid #C3C3C3;">
                                <s:hidden id="fileAttchIds" name="model.fileAttachIds" />
                            </div>
                            <div id="systop_file_list"></div>
                        </td>
                    </tr>
				<tr>
					<td colspan="6" style="border: 0px;" align="center"><%@include
							file="/pages/common/messages.jsp"%> <input
						type="button" onclick="jkjsSave()" class="button" value=" 保 存 ">&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<input type="button"
						onclick="javascript:window.location.href='${ctx}/hybl/queryxx.do';"
						class="button" value=" 返 回 "></td>

				</tr>
			</table>
 </fieldset>
		</s:form>


	<script type="text/javascript">
		function jkjsSave() {
			var strEnrollID = $("#pnanme").val();
			if (strEnrollID == null || strEnrollID.length == 0) {
				alert("请填写会议名称！");
				return;
			}
			var hytime = $("#hytime").val();
			if (hytime == null || hytime.length == 0) {
				alert("请填写会议时间！");
				return;
			}
			

			$('#bmxxForm').attr("action", "${ctx}/hybl/jkjsSave.do");
			$('#bmxxForm').submit();
		}
	</script>


<script type="text/javascript">
    //渲染上传组件
    renderUploader(true, fileType, fileDesc, 30240000);
    viewFileAttchList('${model.fileAttachIds}', true);
    function isChangeVisaBox(){
        if($('#isChangeVisaBox').attr("checked")){
            $('#isChangeVisa').val('1');
            $('#isChangeVisaTr').show();
        }else{
            $('#isChangeVisa').val('');
            $('#isChangeVisaTr').hide();
        }
    }
</script>
</body>
</html>