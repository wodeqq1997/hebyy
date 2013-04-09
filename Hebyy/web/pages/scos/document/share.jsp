<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="/common/taglibs.jsp" %>
<html>
<head>
    <%@include file="/common/meta.jsp" %>
    <%@include file="/common/extjs.jsp" %>
    <%@include file="/common/validator.jsp" %>
    <title>分享文档信息编辑</title>
    <style type="text/css">
        .x-panel-body{
            border:none !important;
        }
    </style>
</head>
<body>
<div class="x-panel">
    <div class="x-header">
      			分享文档信息编辑
    </div>
    <div class="x-panel-body">
        <s:form action="share.do" id="save" method="post" style="margin: 0px;">
            <s:hidden name="model.id"/>
            <table width="850" border="0" align="center" style="line-height: 30px;">
                <tr>
                    <td align="right">所属类别：</td>
                    <td>
                        <div id='comboxWithTree'></div>
                        <s:textfield name="docTypeId" id="docTypeId" class="checkDocType" style="visibility: hidden;width: 0;" />
                    </td>
                </tr>
            </table>
            <div align="center">
                <input type="submit" value="保存" class="button">　<input type="reset" value="重置" class="button">
            </div>
       </s:form>
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

</script>

<script type="text/javascript"
        src="${ctx}/pages/scos/document/type/docTypeCombox.js"></script>
<script type="text/javascript">
    Ext.onReady(function () {
        var pstree = new ProsortTree({
            el:'comboxWithTree',
            target:'docTypeId',
            //emptyText : '选择商品类型',
            url:'${ctx}/document/type/docTypeTree.do?model.isPublic=1'
        });
        pstree.init();
    });
</script>
</body>
</html>