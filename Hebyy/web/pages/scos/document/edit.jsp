<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglibs.jsp" %>
<html>
<head>
    <%@include file="/common/meta.jsp" %>
    <%@include file="/common/extjs.jsp" %>
    <%@include file="/common/validator.jsp" %>
    <%@include file="/common/kindeditor.jsp" %>
    <%@include file="/common/uploadify.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/ec/ecside_style.css"/>
    <script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
    <title>文档信息编辑</title>
    <style type="text/css">
        .x-panel-body{
            border:none !important;
        }
    </style>
</head>
<body>
<div class="x-panel">
    <div class="x-header">
        &nbsp;添加文档
        <s:if test='model.isPublic == "1"'>.
            <span style="color: green;">(公共)</span>
        </s:if>
        <s:else>
            <span style="color: blue;">(个人)</span>
        </s:else>
    </div>
    <div class="x-panel-body">
        <form action="save.do" id="save" method="post" style="margin: 0px;">
            <s:hidden name="model.id"/>
            <s:hidden name="model.isPublic"/>
            <table width="850" border="0" align="center" style="line-height: 30px;">
                <tr>
                    <td width="100" align="right">标　题：</td>
                    <td width="750">
                        <s:textfield name="model.title" id="title"  maxlength="255" cssClass="required"/><font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td align="right">关键字：</td>
                    <td>
                        <s:textfield name="model.keyWord" id="keyWord"  maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">所属类别：</td>
                    <td>
                        <div id='comboxWithTree' style="display: inline-block;"></div>
                        <input type="text" name="model.docType.id" id="docTypeId" class="checkDocType" style="visibility: hidden;width: 0;">
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">描　述：</td>
                    <td>
                        <s:textarea name="model.descn" id="descn"
                                    cssStyle="margin:3px 0px; width: 635px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">上传文件：</td>
                    <td>
                        <table>
                            <tr>
                                <td><input type="file" id="systop_upload"/>&nbsp;</td>
                                <td><span style="color: #EB2A03">附件大小在100M以内!</span></td>
                            </tr>
                        </table>
                        <div id="custom">
                            <div id="systop-file-queue"></div>
                        </div>
                        <div id="systop-uploaded-files" style="width: 635px; border-bottom: 1px solid #C3C3C3;">
                            <input type="hidden" id="fileAttchIds" name="fileAttchIds"/>
                        </div>
                        <div id="systop_file_list"></div>
                    </td>
                </tr>

            </table>
            <div align="center">
                <input type="submit" value="保存" class="button">　<input type="reset" value="重置" class="button">
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#save").validate();
    });

    $(function () {
        $.validator.addMethod("checkDocType", function (value, element) {
            if (value == '' || value == '0') {
                return false;
            } else {
                return true;
            }
        }, "必选项");
    });

    //渲染上传组件
    renderUploader(true);
    var editor;
    KindEditor.ready(function (K) {
        editor = K.create('#descn', {
            resizeType:1,
            allowFileManager:true,
            uploadJson:'${ctx}/fileManager/upload_json.jsp',
            fileManagerJson:'${ctx}/fileManager/file_manager_json.jsp',
            width:650,
            height:250
        });
    });

</script>
<s:if test="model.id != null">
    <script type="text/javascript">
        viewFileAttchList('${model.fileattchIds}', true);
    </script>
</s:if>
<script type="text/javascript"
        src="${ctx}/pages/scos/document/type/docTypeCombox.js"></script>
<script type="text/javascript">
    Ext.onReady(function () {
        var pstree = new ProsortTree({
            el:'comboxWithTree',
            target:'docTypeId',
            //emptyText : '选择商品类型',
            url:'${ctx}/document/type/docTypeTree.do?model.isPublic=${model.isPublic}'
        });
        pstree.init();
    });
</script>
</body>
</html>