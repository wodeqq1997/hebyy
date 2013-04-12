/*
 *  登录后首页异步加载的数据模块：
 * .通知公告：/notice/indexNotices.do
 * .待办事项：/flow/node/indexNodes.do
 * .新闻栏目: /article/type/indexTypes.do
 * .新闻列表：/article/indexArticles.do
 * .内部邮件：/email/indexEmails.do
 * .最新项目：/project/indexProjects.do
 * .内部讨论：/forum/topic/indexTopics.do
 * .短消息：/msg/msg.do
 */

/**
 * 加载通知公告
 * @param divId
 */
function loadNotices(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/notice/indexNotices.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':5},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无通知公告...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					var newStyle = data[i].noticeIsNew ? "liNew" : "liNormal";
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/notice/view.do?model.id="+data[i].id+"' title='" + data[i].title + "' target='_blank'><span class='" + newStyle + "'>" + data[i].createDate + "</span>&nbsp;&nbsp;" + data[i].title +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}

/**
 * 加载待办事项
 * @param divId
 */
function loadMyNodes(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/flow/node/indexPendingNodes.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':5},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无待办事项...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/flow/node/view.do?model.id="+data[i].id+"' title='" + data[i].flowTitle + "'>" + data[i].createDate + "&nbsp;&nbsp;" + data[i].flowTitle +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}

/**
 * 加载新闻类别
 * @param divId
 */
function loadArticleTypes(typeDivId){
	var divContent = $('#'+ typeDivId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/article/type/indexTypes.do',
		type: 'post',
		dataType: 'json',
		success: function(data, textStatus){
			if (data != null || data.length > 0){
				htmlStr = "<div class='ellipsis' style='width:" + width + "; margin:0px 5px;'>";
				for(var i = 0; i < data.length; i++){
					htmlStr += "<a href='javascript:loadArticles(" + data[i].id + ", \"articles\")'>" + data[i].name + "</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
				}
				htmlStr += "</div>";
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}

/**
 * 根据类别ID加在新闻
 * @param typeId
 * @param articleDivId
 */
function loadArticles(typeId, articleDivId){
	var divContent = $('#'+ articleDivId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/article/indexArticles.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':4, 'model.articleType.id':typeId},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无新闻内容...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/article/index.do?model.articleType.id="+data[i].id+"'>【" + data[i].articleType + "】</a>&nbsp;&nbsp;";
					htmlStr += "<a href='" + URL_PREFIX + "/article/view.do?model.id="+data[i].id+"' title='" + data[i].title + "' target='_blank'>" + data[i].createDate + "&nbsp;&nbsp;" + data[i].title +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//alert("e");
			//nothing...
		}
	});
}

/**
 * 加载内部讨论区
 * @param divId
 */
function loadTopics(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/forum/topic/indexTopics.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':5},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无最新讨论...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/forum/topic/view.do?model.id="+data[i].id+"' title='" + data[i].title + "' target='_blank'>" + data[i].createDate + "&nbsp;&nbsp;" + data[i].title +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}

/**
 * 加载内部邮件信息
 * @param divId
 */
function loadMails(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/mail/indexMails.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':5},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>邮箱内没有邮件...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					var readStr = (data[i].isRead == 1) ? "<span style='color:green'>【已读】</span>" : "<span style='color:red'>【未读】</span>";
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/mail/view.do?mailId="+data[i].id+"' title='" + data[i].subject + "' target='_blank'>" + readStr + "<span style='color: blue;'>【" + data[i].sendTime + "】</span>" +data[i].subject +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}

/**
 * 加载规章制度
 * @param divId
 */
function loadUsefulLink(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/zcxx/indexZcxxs.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':10},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无发布规章制度...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/gzzd/queryxx3.do?id="+data[i].id+"'>"+data[i].zcMc+"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			
		}
	});
}


/**
 * 加载图片新闻信息
 * @param divId
 */
function loadArticlePhotos(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/article/indexArticlePhotos.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':4},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂无图片新闻...</div>";	    		
			}else{
				//htmlStr += "<marquee direction='left' height='110' scrollamount='2' onmouseover='this.stop()' onmouseout='this.start()'>";
				for(var i = 0; i < data.length; i++){
					htmlStr += "<a href='" + URL_PREFIX + "/article/view.do?model.id="+data[i].id+"' title='" + data[i].title + "' target='_blank'>";
					htmlStr += "<img style='border:#999999 1px solid;margin:2px;height:125px;max-width: 190px;' alt='" + data[i].title + "' src='" + URL_PREFIX + data[i].articlePhoto + "' />";
					htmlStr += "</a>";
				}
				//htmlStr += "</marquee>";
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}




/**
 * 加载短消息
 * @param divId
 */
function loadMsg(divId){
	var divContent = $('#'+ divId);
	var width = divContent.width() - 20;
	var htmlStr = "";
	$.ajax({
		url: URL_PREFIX + '/msg/ajaxReadReceiveMsgs.do',
		type: 'post',
		dataType: 'json',
		data:{'viewCount':5},
		success: function(data, textStatus){
			if (data == null || data.length == 0){
				htmlStr = "<div style='margin:5px;'>暂时没有未读短消息...</div>";	    		
			}else{
				for(var i = 0; i < data.length; i++){
					var readStr = (data[i].isRead == 1) ? "<span style='color:green'>【已读】</span>" : "<span style='color:red'>【未读】</span>";
					htmlStr += "<div style='width:" + width + "' class='item'>";
					htmlStr += "<a href='" + URL_PREFIX + "/mail/view.do?mailId="+data[i].id+"' title='" + data[i].subject + "' target='_blank'>" + readStr + "<span style='color: blue;'>【" + data[i].sendTime + "】</span>" +data[i].subject +"</a>";
					htmlStr += "</div>";
				}
			}
			divContent.html(htmlStr);
		},
		error: function(){
			//nothing...
		}
	});
}