//审批相关JS

/**
 * 添加审批人(第一审批人)
 * field 字段名
 * id 
 */
function setAuditor(url, field, id){
	//审批人ID
	var auditor = $("#auditor").val();
	if(!auditor ){
		alert("请选择审批人！");
		return;
	}
	$.ajax({
		url : URL_PREFIX+"/flow/saveFlow.do",
		type : "POST",
		data : {
			"field" : field,
			"fieldId" : id,
			"auditorId" : auditor	
		},
		dataType : "json",
		success : function(result) {
			//如果执行成功
			if(result.success){
				//alert('完成');
				window.location.href = url;
			}else{
				alert('发生异常,保存失败');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
			return false;
		}
	});
}

/**
* 提交审批
* @param url 提交成功跳转的URL
* @param field 字段名
*/
function submitAudit(url, field){
	var status = $("input[name='status']:checked").val();;
	var auditor = $("#auditor").val();
	var descn = $('#descn').val();
	var id = $('#nodeId').val();
	if(!field){
		field ="";
	}
	if(!status){
		alert('请选择审批状态');
		return;
	}
	if(!auditor && status == 'pass'){
		if(!confirm("无下级审批，确定要提交审批结果？")){
			return;
		}	
	}
	$.ajax({
		url : URL_PREFIX+"/flow/node/auditFlowNode.do",
		type : "POST",
		data : {
			"model.id" : id,
			"model.status" : status,
			"auditorId" : auditor,		
			"model.descn" : descn,
			"field" : field
		},
		dataType : "json",
		success : function(result) {
			//如果执行成功
			if(result.success){
				//alert('审批完成');
				window.location.href = url;
			}else{
				alert('审批失败');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(XMLHttpRequest + "@@" + textStatus + "@@@" + errorThrown);//"发生异常，请与管理员联系！",
			return false;
		}
	});
}

/**
* 选择审批状态
* 如果通过选择下一个审批人
*/
function updateStatus(status){
	var value = status.value;
	if(value == 'pass'){
		$('#auditorDiv').show();
	}else{
		$('#auditor').val('');
		$('#auditorName').val('');
		$('#auditorDiv').hide();
	}
}	