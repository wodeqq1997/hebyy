<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/kindeditor.jsp"%>

    <%@include file="/common/uploadify.jsp"%>
    <script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
    <link href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>
<title>日志信息编辑</title>
</head>
<body >
	<div class="x-panel">
		<div class="x-header">添加日志</div>
		<div><%@ include file="/common/messages.jsp"%></div>
		<div class="x-panel-body">
			<form action="save.do" method="post" style="margin: 0px;">
			  <s:hidden name="model.id"/>
			  <fieldset>
			    <legend>日志信息编辑</legend>
				<table border="0" align="center" style="line-height: 30px;width:100%">
					<tr>
						<td width="65" align="right">标题：</td>
						<td>
							<s:textfield name="model.title" id="title" maxlength="255" cssStyle="width:650"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">内容：</td>
						<td>
							<s:textarea name="model.content" id="content"  cssStyle="margin:3px 2px; width: 596px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
						</td>
					</tr>

                    <tr>
                        <td align="right">附件：</td>
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
				</table>
			  </fieldset>
			  <div align="center">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">
			  </div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		//var editor;
		KindEditor.ready(function(K) {
			K.create('#content', {
				resizeType :1,
				allowPreviewEmoticons : false,
				allowImageUpload : true,
				//<stc:role ifAnyGranted="ROLE_ADMIN">
				allowFileManager : true,
				//</stc:role>
				width:"99%",
				height:350,
				uploadJson : '${ctx}/fileManager/upload_json.jsp',
				fileManagerJson : '${ctx}/fileManager/file_manager_json.jsp'
			});
		});
		//allowFileManager : true,
//			,
//			items : [
//				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
//				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
//				'insertunorderedlist', '|', 'emoticons', 'link']

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