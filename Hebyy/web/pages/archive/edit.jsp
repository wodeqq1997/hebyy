<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/validator.jsp"%>
<%@include file="/common/extjs.jsp"%>
<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<script type="text/javascript" src="${ctx}/scripts/select.project.js"></script>
<script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
<link href="${ctx}/styles/select.project.css" rel="stylesheet"/>
<link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
<script type="text/javascript">
var rootName = '河北演艺集团';
	var initValue = '${model.dept.name}';
	if (initValue.length == 0) {
		initValue = rootName;
	}
	Ext.onReady(function() {
		var dtree = new DeptTree({
			url : '/admin/dept/deptTree.do',
			rootName : rootName,
			initValue : initValue,
			el : 'comboxWithTree',
			innerTree : 'inner-tree',
			onclick : function(nodeId) {
				Ext.get('deptId').dom.value = nodeId;
			}
		});
		dtree.init();
	});
</script>
<title>案卷信息编辑</title>
</head>
<body>
	<div class="x-panel" style="width: 100%">
		<div class="x-header" style="border-bottom: 1px solid #99bbe8;">案卷信息</div>
		<div><%@ include file="/common/messages.jsp"%></div>
			<form action="save.do" method="post" id="save" style="margin: 0px;">
			  <s:hidden name="model.id"/>
				<table width="700" style="margin-top: 20px;" id="fineTable" cellpadding="0" cellspacing="0" align="center">
					<tr>
						<td align="center" colspan="4" style="height:25px; line-height: 25px; border:1px solid #99BBE8; background-color: #d0def0;font-weight:800;">
							案卷信息
						</td>
					</tr>
					<tr>
						<td width="100" align="center">案&nbsp;&nbsp;卷&nbsp;&nbsp;号：</td>
						<td width="250">
							<s:textfield name="model.archiveNO" id="archivesNO" maxlength="255" cssStyle="width:200px;" cssClass="required"/>
							<span id="archivesNODescn"></span>
							<font color="red">*</font>
						</td>
						<td width="100" align="center">案卷名称：</td>
						<td width="250">
							<s:textfield name="model.name" id="name" maxlength="255" cssStyle="width:200px;" cssClass="required" />
							<span id="nameDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center">案卷类别：</td>
						<td> 
							<s:select list="archiveTypeMap" cssClass="archiveTypeCheck" name="model.archiveType.id" headerKey="" id="archiveTypeId" headerValue="全部" cssStyle="width:197px;" />
							<span id="archiveTypeDescn"></span>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td align="center">所属部门：</td>
						<td> 
							<table cellpadding="0" cellspacing="0" border="0">
								<tr style="border: 0px;">
									<td style="border: 0px;">
										<div id='comboxWithTree' style="width:200px;"></div>
										<input type="hidden" id="deptId" name="model.dept.id" class="dept" value="${model.dept.id}" />
                                    </td>
								</tr>
							</table>
						</td>
						<td align="center">归档年代：</td>
						<td> 
							<input id="archiveYear" name="model.archiveYear"  style="height:25px;width:200px;" value='<s:date name="model.archiveYear" format="yyyy年"/>' onfocus="WdatePicker({skin:'blueFresh',dateFmt:'yyyy年'})" class="Wdate required" readonly="readonly" />
                            <font color="red">*</font>

                        </td>
					</tr>
					<tr>
						<td align="center">起始日期：</td>
						<td>
							<input id="beginDate" name="model.beginDate"  style="height:25px;width:200px;" value='<s:date name="model.beginDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
                            <font color="red">*</font>

                        </td>
						<td align="center">终止日期：</td>
						<td>
							<input id="endDate" name="model.endDate"  style="height:25px;width:200px;" value='<s:date name="model.endDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',skin:'blueFresh',dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" />
                            <font color="red">*</font>

                        </td>
					</tr>
					<tr>
						<td align="center">保管期限：</td>
						<td> 
							<s:textfield name="model.deadline" id="deadline"  maxlength="255" cssStyle="width:200px;"/>
						</td>
						<td align="center">案卷密级：</td>
						<td> 
							<s:select list="#{'保密':'保密','绝密':'绝密'}" id="dense" name="model.dense" headerKey="" headerValue=""/>
						</td>
					</tr>
					<tr>
						<td align="center">全&nbsp;&nbsp;宗&nbsp;&nbsp;号：</td>
						<td> 
							<s:textfield name="model.categoryNO" id="categoryNO"  maxlength="255" cssStyle="width:200px;"/>
						</td>
						<td align="center">目&nbsp;&nbsp;录&nbsp;&nbsp;号：</td>
						<td> 
							<s:textfield name="model.catalogNO" id="catalogNO"  maxlength="255" cssStyle="width:200px;"/>
						</td>
					</tr>
					<tr>
						<td align="center">档案保管位置：</td>
						<td> 
							<s:select name="model.archiveCabinet.id" list="archiveCabinetMap" headerKey="" headerValue="选择档案柜" cssClass="archiveCabinetCheck" cssStyle="width:197px;" />
							<font color="red">*</font>
						</td>
						<td align="center">微&nbsp;&nbsp;缩&nbsp;&nbsp;号：</td>
						<td> 
							<s:textfield name="model.microNO" id="microNO"  maxlength="255" cssStyle="width:200px;"/>
						</td>
					</tr>
					<tr>
						<td align="center">页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数：</td>
						<td> 
							<s:textfield name="model.archivePage" id="archivePage"  maxlength="255" cssStyle="width:200px;"/>
						</td>
						<td align="center">编制机构：</td>
						<td> 
							<s:textfield name="model.editDept" id="editDept"  maxlength="255" cssStyle="width:200px;"/>
						</td>
					</tr>
                    <tr>
						<td align="center">是否存档：</td>
						<td>
							<%--<s:textfield name="model.submit" id="archivePage"  maxlength="255" cssStyle="width:200px;"/>--%>
                            <select name="model.submit" class="submit-selector">
                                <option value="false">否</option>
                                <option value="true">是</option>
                            </select>
						</td>
						<td align="center"></td>
						<td>
						</td>
					</tr>

					<tr>
						<td align="center">案卷内容：</td>
						<td colspan="3"> 
							<s:textarea name="model.content"  cssStyle="width:600px;height: 125px;"/>
						</td>
					</tr>
                    <tr>
						<td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td colspan="3">
							<s:textfield name="model.remark" id="remark" cssStyle="width:600px;"/>
						</td>
					</tr>
				</table>
			  <div align="center" style="margin-top: 10px;">
				<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" class="button">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </div>
			</form>
		</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#save").validate();
		});
		$(function() {
			$.validator.addMethod("archiveTypeCheck", function(value, element) {
				return value != null && value.length != 0;
			}, "必选");
			$.validator.addMethod("archiveCabinetCheck", function(value, element) {
				return value != null && value.length != 0;
			}, "必选");
		});

        //load submit val
        $(function(){
            $(".submit-selector").val('${model.submit}');
        })
	</script>
</body>
</html>