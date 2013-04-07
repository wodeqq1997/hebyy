/**
 * 表单验证
 */
$.validator.addMethod("titlesCheck", function(value, element) {
    var res = "";
    if(value == null || value.length == 0){
    	$("#titlesParmDescn").html('<font color="red">标签不允许为空</font>');
    	res = "err";
    }else{
		$("#titlesParmDescn").html("");
    }
    return res != "err";
},"");
$.validator.addMethod("phoneValidator", function(value, element) {
    var res = "";
    if(value.length == 0){
    	$("#phoneDescn").html("");
    	return true;
    }else{
		if (value.length < 7){
			res = "err";
			$("#phoneDescn").html("<font color='red'>长度应该大于6</font>");
		}else if (value.length > 20){
			res = "err";
			$("#phoneDescn").html("<font color='red'>长度应该小于20</font>");
		}else{
			$("#phoneDescn").html("");
		}
    }
    return res != "err";
},"");

$.validator.addMethod("checkSupplierType", function(value, element) {
	return !(value == null || value.length == 0);
}, "必选");

$.validator.addMethod("emailValidator", function(value, element) {
    var res = "";
    if(value.length == 0){
    	$("#emailDescn").html("");
    	return true;
    }else{
		var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
		if (!emailRegExp.test(value)||value.indexOf('.')==-1){
			res = "err";
			$("#emailDescn").html("<font color='red'>该项非必选项，如果要填，请填入正确的邮箱。</font>");
			return false;
		}else{
			$("#emailDescn").html("");
		}
    }
    return res != "err";
},"");





