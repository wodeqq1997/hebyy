/**
 * 选择物资
 */
function showAsset() {
	if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
		var asset = window.showModalDialog(
				URL_PREFIX+"/pages/scos/asset/selector.jsp", null,
				"dialogWidth=725px;dialogHeight=340px;resizable: Yes;");
		if (asset != null) {
			var tab = $('#name');
			tab.val(asset.name);
			var tab1 = $('#assetId');			
			tab1.val(asset.id);
		}
	} else {
		window.open(URL_PREFIX+"/pages/scos/asset/selector.jsp",
					"",
					"width=700px,height=420,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
		this.returnAction = function(asset) {
			if (asset != null) {
				var tab = $('#name');
				tab.val(asset.name);
				var tab1 = $('#assetId');			
				tab1.val(asset.id);
			}
		};
	}
}