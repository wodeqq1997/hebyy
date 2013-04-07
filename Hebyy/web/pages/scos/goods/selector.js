/**
 * 选择办公用品
 */
function showGoods() {
	if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
		var project = window.showModalDialog(
				URL_PREFIX+"/pages/scos/goods/selector.jsp", null,
				"dialogWidth=765px;dialogHeight=330px;resizable: Yes;");
		if (project != null) {
			var tab = $('#goodsName');
			tab.val(project.name);
			var tab1 = $('#goodsId');			
			tab1.val(project.id);
			var tab2 = $('#count');
			if(tab2 != null){
				tab2.val(project.stockCounts);	
			}
		}
	} else {
		window.open(URL_PREFIX+"/pages/scos/goods/selector.jsp",
					"",
					"width=770px,height=320,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
		this.returnAction = function(project) {
			if (project != null) {
				var tab = $('#goodsName');
				tab.val(project.name);
				var tab1 = $('#goodsId');			
				tab1.val(project.id);
				var tab2 = $('#count');
				if(tab2 != null){
					tab2.val(project.stockCounts);	
				}
			}
		};
	}
}