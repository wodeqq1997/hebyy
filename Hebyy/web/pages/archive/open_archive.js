/**
 * 根据案卷ID打开案卷详细信息
 */
function openArchive(id)
{
	var URL=URL_PREFIX+"/archive/view.do?model.id=" + id;
	myleft=(screen.availWidth-800)/2;
	mytop=100;
	mywidth=800;
	myheight=400;
	window.open(URL,null,"height="+myheight+",width="+mywidth+",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top="+mytop+",left="+myleft+",resizable=yes");
}
/**
 * 根据案卷文件ID打开案卷详细信息
 */
function openArchiveFile(id,sign)
{
	var URL=URL_PREFIX;		
	if(!sign){
		URL += "/archive/file/view.do?model.id=" + id;
	}else{
		URL += "/archive/file/view.do?model.id=" + id + "&sign=" + sign;
	}
	myleft=(screen.availWidth-750)/2;
	mytop=100;
	mywidth=750;
	myheight=350;
	window.open(URL,null,"height="+myheight+",width="+mywidth+",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top="+mytop+",left="+myleft+",resizable=yes");
}
/**
 * 选择案卷
 */
function showArchive() {
	url = "/pages/archive/selector.jsp";
	if (navigator.userAgent.indexOf("MSIE") > 0) {//IE判断
		var archives = window.showModalDialog(
				URL_PREFIX + url, null,
				"dialogWidth=745px;dialogHeight=430px;resizable: Yes;");
		if (archives != null) {
			$('#archiveName').val(archives.name);
			//tab.val(archives.name);
			$('#archiveId').val(archives.id);			
			//tab1.val(archives.id);
			$('#fileNO').val(archives.archiveNO);
		}
	} else {
		window.open(URL_PREFIX + url,
					"",
					"width=745px,height=430px,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes");
		this.returnAction = function(archives) {
			if (archives != null) {
				$('#archiveName').val(archives.name);
				$('#archiveId').val(archives.id);
				$('#fileNO').val(archives.archiveNO);
			}
			return;
		};
	}
}
/**
 * 审核选项 
 */
function openAuditSelectByInfo(info){
	var url = URL_PREFIX;
	if(info == '1'){
		url += '/archive/file/lend/auditIndex.do';
	}
	if(info == '2'){
		url += '/archive/file/lend/historyAuditIndex.do';
	}
	location.href = url;
}
/**
 * 清空案卷选项 
 */
function clearArchive(){
	$('#archiveName').val('');
	$('#archiveId').val('');
}