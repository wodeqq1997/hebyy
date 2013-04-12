<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/taglibs.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/extjs.jsp"%>

<%@include file="/common/validator.jsp"%>
<%@include file="/common/uploadify.jsp"%>

<script type="text/javascript" src="${ctx}/pages/admin/dept/edit.js"></script>
<link href="${ctx}/styles/treeSelect.css" type='text/css' rel='stylesheet'>

<script type="text/javascript" src="${ctx}/pages/admin/fileattch/fileattch.js"></script>
<LINK href="${ctx}/pages/admin/fileattch/fileattch.css" type='text/css' rel='stylesheet'>

<script type="text/javascript" src="${ctx}/scripts/my97/WdatePicker.js"></script>

    <script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
    <link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
    <style>
   	.dept-ol .ui-selecting { background: #FECA40; }
   	.dept-ol .ui-selected { background: #F39814; color: white; }
   	.dept-ol { list-style-type: none; margin: 0; padding: 0; }
    .dept-ol ol { list-style-type: none; margin: 0; padding-left:20px; }
   	.dept-ol li { margin: 3px; padding: 0.4em; height: 18px; }
   	</style>

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
				getPosition(nodeId);
			}
		});
		dtree.init();
	});
	
	function changePassword(){
		var url = "${ctx}/password/modifyPassword.do";
		var config = "dialogWidth=500px;dialogHeight=250px;status=no;help=no;scrollbars=no";
		window.showModalDialog(url,"",config);
	}
	function getPosition(id){
		$.ajax({
			url : URL_PREFIX + "/position/queryPosition.do",
			dataType : "json",
			cache : false,
			data : {
				"deptId" : id
			},
			success : function(positionMap) {
			   $('#positionId').empty();
			   jQuery("#positionId").append("<option value=''>请选择</option>");   
			   for(var key in positionMap){   
				  if('${model.position.id}'==key){
					jQuery("#positionId").append("<option value='"+key+"' selected>"+positionMap[key]+"</option>");
				  }else{
				  	jQuery("#positionId").append("<option value='"+key+"'>"+positionMap[key]+"</option>");
				  }
			   }
			}
		});
	}
	
	window.onload=select;
	function select(){
		var deptId= document.getElementById("deptId");
		getPosition(deptId.value);
	}
</script>

<style type="text/css">
.warn {
	color: red;
}

.title {
	border-bottom: 1px solid #99BBE8;
	font-size: 14px;
	font-weight: bold;
	color: #15428b;
}
</style>
<title>编辑用户</title>
</head>
<body>
<div class="x-panel">
<div class="x-toolbar" style="padding: 5px; font-weight: bold;">用户信息</div>
<div style="width: 99%; margin: 0 auto;"><%@ include file="/common/messages.jsp"%></div>
<br>
<s:form action="saveEmployee.do" id="save" validate="true" method="post" onsubmit="disable1001()">
	<table width="800" align="center" border="0" style="border-bottom: 1px solid #99BBE8;">
		<tr>
			<td colspan="2" class="title">
				<span>员工基本信息</span>&nbsp;
			</td>
		</tr>
		<tr>
			<td width="50%" valign="top">
			<table width="400" style="line-height: 25px;">
				<tr>
					<td width="100" align="right">员工姓名：</td>
					<td width="300">
						<s:textfield name="model.name" cssStyle="width:200px" maxlength="20" cssClass="required" />
						<span class="warn">*</span></td>
				</tr>
				<tr>
					<td align="right">员工性别：</td>
					<td>
						<s:radio list="%{@com.systop.common.modules.security.user.UserConstants@SEX_MAP}" name="model.sex" cssStyle="border:0px;" onclick="defaultUserPhoto(this.value)"/></td>
				</tr>
				<tr>
					<td width="100" align="right">所属部门：</td>
					<td width="300">
						<s:hidden name="model.id" id="uid"/>
						<s:hidden name="editSelf" />
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div id='comboxWithTree'></div>
									<input type="hidden" id="deptId" name="deptId" class="dept" value="${model.dept.id}" />
								</td>
								<td>
									<span id="deptmsg" class="warn"></span>&nbsp; 
									<span class="warn">*</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
                    <tr>
                        <td width="100" align="right">公司职位：</td>
                        <td width="300">
                            <c:if test="${editSelf eq '1'}">
                                ${model.position.name}
                                <s:hidden name="model.position.id"/>
                            </c:if>
                            <c:if test="${editSelf ne '1'}">
                                <s:select list="#{'':'请选择'}" name="model.position.id" id="positionId"
                                          cssStyle="width:200px;" cssClass="checkPositionId"/>
                                <span class="warn">*</span>
                            </c:if>
                        </td>
                    </tr>
				<tr>
					<td align="right">身份证号：</td>
					<td>
						<s:textfield name="model.idCard" id="idCard" cssStyle="width:200px"/>
					</td>
				</tr>
				<tr>
					<td align="right">出生日期：</td>
					<td>
						<input type="text" name="model.birthDay" style="width: 200px;" readonly="readonly" 
							   value='<s:date name="model.birthDay" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
					</td>
				</tr>
				<tr>
					<td align="right">移动电话：</td>
					<td>
						<s:textfield name="model.mobile" id="mobile" cssStyle="width:200px" maxlength="18" cssClass="required number" />
                        <span class="warn">*</span></td>
				</tr>
				<tr>
					<td align="right">办公电话：</td>
					<td>
						<s:textfield name="model.phone" id="phone" cssStyle="width:200px" cssClass="number"  maxLength="40" /></td>
				</tr>
				<tr>
					<td align="right">传真号码：</td>
					<td><s:textfield name="model.fox" id="fox"
						cssStyle="width:200px" maxLength="40"  cssClass="number" /></td>
				</tr>
				<tr>
					<td align="right">紧急联系方式：</td>
					<td>
						<s:textfield name="model.emergencyPhone" id="emergencyPhone" cssStyle="width:200px" maxlength="100" /></td>
				</tr>
				<tr>
					<td align="right">电子邮件：</td>
					<td>
						<s:textfield name="model.email" id="email" cssStyle="width:200px" maxLength="255" cssClass="email"/></td>
				</tr>
				<tr>
					<td align="right">QQ：</td>
					<td>
						<s:textfield name="model.oicq" id="oicq" cssStyle="width:200px" cssClass="number"  maxLength="255" /></td>
				</tr>
				<tr>
					<td align="right">最高学历：</td>
					<td>
						<s:textfield name="model.degree" id="degree" cssStyle="width:200px" maxlength="100" /></td>
				</tr>
				<tr>
					<td align="right">毕业院校：</td>
					<td>
						<s:textfield name="model.college" id="college" cssStyle="width:200px" maxlength="100" /></td>
				</tr>
				<tr>
					<td align="right">毕业时间：</td>
					<td>
						<input type="text" name="model.graduationTime" style="width: 200px;" readonly="readonly" 
							   value='<s:date name="model.graduationTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" /></td>
				</tr>
			</table>
			</td>
			<td width="50%" valign="top">
			<table width="400" border="0" style="line-height: 25px; ">
				<tr>
					<td width="100" align="right">
						<span>员工照片：</span>
						
						<div>小于200KB</div>
					</td>
					<td width="300" height="300" valign="top">
						<div style="width: 200px; height: 250px; border: 1px solid #CCC;overflow-x: hidden;text-align: center;padding:2px;">
						  <img id="photo" src="${ctx}${model.photo.path}" height="250"/></div>
						<s:if test="model.photoId == null || model.photoId==''">
							<input type="file" id="systop_upload" />
							<div id="custom">
								<div id="systop-file-queue"></div>
							</div>
							<div id="systop-uploaded-files">
								<s:hidden id="fileAttchIds" name="model.photoId" onpropertychange="updateUserPhoto();"/>
							</div>
							<div id="systop_file_list"></div>
						</s:if>
						<s:else>
							<a href="javascript:removeUserPhoto('${model.id}')"><img src="${ctx}/images/icons/remove.gif">删除用户照片</a>
						</s:else>
				</tr>
				<tr>
					<td align="right">所学专业：</td>
					<td>
						<s:textfield name="model.major" id="major" cssStyle="width:200px" maxlength="100" /></td>
				</tr>
				<tr>
					<td align="right">入职时间：</td>
					<td>
						<input type="text" name="model.joinTime" style="width: 200px;" readonly="readonly" 
							   value='<s:date name="model.joinTime" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
					</td>
				</tr>
				<tr>
					<td align="right">转正时间：</td>
					<td>
						<input type="text" name="model.formalDate" style="width: 200px;" readonly="readonly" 
							   value='<s:date name="model.formalDate" format="yyyy-MM-dd"/>'
							   onClick="WdatePicker({skin:'blueFresh'})" class="Wdate" />
					</td>
				</tr>
				<tr>
					<td align="right">家庭住址：</td>
					<td>
						<s:textfield name="model.address" id="address" cssStyle="width:200px" maxlength="255" />
					</td>
				</tr>
				<tr>
					<td align="right">籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯：</td>
					<td>
						<s:textfield name="model.hometown" id="hometown" cssStyle="width:200px" maxlength="255" />
					</td>
				</tr>
				<tr>
					<td align="right">邮政编码：</td>
					<td>
						<s:textfield name="model.zip" id="zip" cssStyle="width:200px" cssClass="number"  maxlength="255" maxLength="6"/>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<div align="center" style="margin-top: 5px;">
		<input type="submit" value="保存" class="button">&nbsp;&nbsp;&nbsp;&nbsp; 
		<input type="reset" value="重置" class="button">
	</div>
</s:form></div>
<script type="text/javascript">


	//===============jquery验证扩展.Start===============
	var uid = $("#uId").val();
	$(function() {
		$.validator.addMethod("dept", function(value, element) {
			if (value == null || value.length == 0 || value == 0) {
				$("#deptmsg").html("选择部门");
				return false;
			} else {
				$("#deptmsg").html("");
				return true;
			}
		}, "");
		$.validator.addMethod("checkPositionId", function(value, element) {
			return value != null && value.length != 0 && value != 0;
		}, "必选");
		//验证用户名
		$.validator.addMethod("loginId", function(value, element) {
			var reg = new RegExp(
					"^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_\.\-])*$");
			return reg.test(value); //首先判断非法字符
		}, "包含非法字符");

		$.validator.addMethod("loginIdUnique", function(value, element) {
			var exist = false;
			$.ajax({
				url : '${ctx}/security/user/checkName.do',
				type : 'post',
				async : false,
				dataType : 'json',
				data : {
					'model.loginId' : value,
					'model.id' : uid
				},
				success : function(rst, textStatus) {
					exist = rst.exist;
				}
			});
			return !exist;
		}, "用户名已存在");

		$.validator.addMethod("pwd", function(value, element) {
			if (value.length < 6) {
				return false;
			}
			return true;
		}, "长度少于6位");

		$.validator.addMethod("repwd", function(value, element) {
			if (value != $('#pwd').val()) {
				return false;
			}
			return true;
		}, "密码不一致");

		$.validator.addMethod("idCard", function(value, element) {
			if (value != null && value.length > 0) {
				if (value.length != 15 && value.length != 18) {
					return false;
				}
			}
			return true;
		}, "长度错误");
	});

	//添加jquery验证
	$(document).ready(function() {
		$("#save").validate();
	});
	//===============jquery验证扩展.End===============
		
	//===============上传组件
	renderUploader(false, '*.jpg; *.gif; *.png', '图片(JPG; GIF; PNG)', 200000);
	
	function updateUserPhoto(){
		var fileAttchId = $('#fileAttchIds').val();
		if(fileAttchId  == null || fileAttchId == ""){
			$("#photo").attr("src", URL_PREFIX+"/images/default_male.png");
		}else{
			showCarPhoto(fileAttchId);
		}
	}
	/**
	 * 显示图片
	 * 
	 * @param fileIds
	 */
	function showCarPhoto(fileIds){
		if (fileIds == null || fileIds.length ==0){
			return;
		}
		$.ajax({
		    url: URL_PREFIX + '/fileattch/findFiles.do?fileIds=' + fileIds,
		    type: 'get',
		    dataType: 'json',
		    error: function(){
		    	alert('get file list error');
		    },
		    success: function(data, textStatus){
		    	if (data != null && data.files != null){
		    		for(var i = 0; i < data.files.length; i++){
		    			// 文件信息
		    			$("#photo").attr("src", URL_PREFIX + data.files[i].path);			    			
		    		}
		    	}
		    }
		});
	}
	
	/**
	 *删除用户照片
	 */
	function removeUserPhoto(modeId){
		if(confirm("您确实要删除用户照片吗?")){
			window.location.href = "removePhoto.do?model.id=" + modeId + "&editSelf=${editSelf}";
		}
	}
	
	var sex = '${model.sex}';
	var photoId = '${model.photoId}';
	function defaultUserPhoto(sex){
		if (photoId == null || photoId.length == 0){
			if (sex == 'M'){
				$("#photo").attr("src", URL_PREFIX+"/images/default_male.png");
			}else{
				$("#photo").attr("src", URL_PREFIX+"/images/default_female.png");
			}
		}
	}
	defaultUserPhoto(sex);
</script>
<div id="deptChooser">
    <ol class="dept-ol">
    </ol>
</div>
</body>
</html>