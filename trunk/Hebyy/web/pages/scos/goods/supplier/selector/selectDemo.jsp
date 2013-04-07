<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	选择供应商：
	<input id="names" type="text" onclick="openSelector(this)">
	<input id="ids" type="text">

	<script type="text/javascript">
		function openSelector(obj) {
			var ids = document.getElementById("ids");
			var conf = "dialogWidth=608px;dialogHeight=438px;status=no;help=no;scrollbars=no";
			var suppliers = window.showModalDialog("selector.jsp", null, conf);
			if (suppliers != null){
				obj.value = suppliers.name;
				ids.value = suppliers.id;
			}
		}
	</script>
	<br>
</body>
</html>