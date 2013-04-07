/**
 * 选择车辆
 */
function showCar() {
	if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
		var car = window.showModalDialog(
				URL_PREFIX+"/pages/scos/car/selector.jsp", null,
				"dialogWidth=725px;dialogHeight=340px;resizable: Yes;");
		if (car != null) {
			var tab = $('#carNo');
			tab.val(car.carNo);
			var tab1 = $('#carId');			
			tab1.val(car.id);
		}
	} else {
		window.open(URL_PREFIX+"/pages/scos/car/selector.jsp",
					"",
					"width=700px,height=420,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
		this.returnAction = function(car) {
			if (car != null) {
				var tab = $('#carNo');
				tab.val(car.carNo);
				var tab1 = $('#carId');			
				tab1.val(car.id);
			}
		};
	}
}