<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<title>供应商询价编辑</title>
</head>
<body>
	<div class="x-panel">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">供应商询价信息</div>
		<div style="width: 100%">
			<s:form action="save.do" id="save" method="post">
			<s:hidden name="model.id"/>
			<table width="700"id="fineTable" style="margin-top: 20px;">
				<tr>
					<th colspan="2">供应商询价记录</th>
				</tr>
				<tr>
					<td width="150" align="right">询价科目：</td>
					<td width="550">
						<s:select name="model.goods.id" id="goods" cssClass="required" list="goodsMap" headerKey="" headerValue="选择询价科目" cssStyle="width:332px;"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right"><span style="">供应商：</span></td>
					<td >
						<s:hidden name="model.goodsSupplier.id" id="supplierId"/>
						<s:textfield name="model.goodsSupplier.name" id="supplierName" cssClass="required" cssStyle="width:332px;" onclick="openSupplier(this)" readonly="true"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right">报　　价：</td>
					<td >
						<s:textfield name="model.price" id="price"  cssClass="required supplierCheck" cssStyle="width:332px;"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top" >备　　注：</td>
					<td>
						<s:textarea name="model.notes" id="notes"  cssStyle="margin:2px 1px; width: 332px; height: 100px; overflow: auto; border: 1px solid #C3c3c3;"/>
					</td>
				</tr>
			</table>

            <div style="text-align: center;padding-top: 5px;">
					<s:submit value="保存" cssClass="button" />&nbsp;&nbsp;
					<s:reset value="重置" cssClass="button" />&nbsp;&nbsp;
            </div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		$(function() {
			$.validator.addMethod("supplierCheck", function(value, element) {
				if (value != null && value.length > 0) {
					return Number(value) >= 0;
				}
			}, "价格不能为负数");
		});
		/**
		 * 选择供应商（乙方）
		 */
		function openSupplier(obj) {
			var ids = document.getElementById("supplierId");

			if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
				var conf = "dialogWidth=508px;dialogHeight=338px;status=no;help=no;scrollbars=no";
				var suppliers = window.showModalDialog("${ctx}/pages/scos/goods/supplier/selector/selector.jsp", null, conf);
				if (suppliers != null){
					obj.value = suppliers.name;
					ids.value = suppliers.id;
				}
			} else {
				window.open("${ctx}/pages/scos/goods/supplier/selector/selector.jsp",
							"",
							"width=608px,height=438,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
				this.returnAction = function(suppliers) {
					if (suppliers != null){
						obj.value = suppliers.name;
						ids.value = suppliers.id;
					}
					return;
				};
			}
		}
		

        $(function(){
            $("#save").bind("submit",function(){
                if($("#projectId").val()==""){
                    $("#projectId,#projectName").attr("name","");
                }
            })
        })
	</script>
    <script type="text/javascript" src="${ctx}/scripts/select.project.js"></script>
    <script type="text/javascript"
            src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
    <link href="${ctx}/styles/select.project.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
</body>
</html>