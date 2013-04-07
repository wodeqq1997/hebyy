<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/taglibs.jsp"%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.systop.common.modules.security.user.UserUtil"%>
<%@page import="com.systop.common.modules.security.user.model.User"%><html>
<%@page import="com.systop.video.VideoConstants" %>
    <head>
        <title></title>         
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		        <style type="text/css" media="screen"> 
			html, body	{ height:100%; }
			body { margin:0; padding:0; overflow:auto; text-align:center; 
			       background-color: #ffffff; }   
			#flashContent { display:none; }
        </style>
		
		<!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="history/history.css" />
        <script type="text/javascript" src="history/history.js"></script>
        <!-- END Browser History required section -->  
		    
        <script type="text/javascript" src="swfobject.js"></script>
       
    </head>
    <body>
<%
String role = "NONE";

//得到当前用户,以构建flex程序必须的参数
User user = UserUtil.getPrincipal(request);
if(user != null){
String loginId = user.getLoginId();
Integer id = user.getId();
%>
<stc:role ifAnyGranted="ROLE_ADMIN">
	<%role = "ROLE_CREATE"; %>	
	<%System.out.println(role); %>
</stc:role>
<%
}
String appUrl = request.getRequestURL().toString();

//System.out.print("url-------->"+appUrl+"\n");
String host = appUrl.substring("http://".length());
int index = 0;
if(host.indexOf(":") > 0) {
  host = host.substring(0, host.indexOf(":"));
} else if(host.indexOf("/") > 0 ) {
  host = host.substring(0, host.indexOf("/"));
}
%>

        <div id="flashContent">
        	<p>
	        	To view this page ensure that Adobe Flash Player version 
				10.0.0 or greater is installed. 
			</p>
			<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script> 
        </div>
	   	 <script type="text/javascript">
           // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            //To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "playerProductInstall.swf";
            var flashvars = {
                    			appUrl : '<%=appUrl%>',
                    			appUrl :'<%=appUrl%>',
                    			userId :'<%=user != null?user.getId():""%>',
                    			ctxPath:'<%=VideoConstants.WEBAPP_CONTEXT_PATH%>',
                    			role   :'<%=role%>'
                    		};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "videoClient";
            attributes.name = "videoClient";
            attributes.align = "middle";
            swfobject.embedSWF(
                "videoClient.swf", "flashContent", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			// JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
       	<noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="videoClient">
                <param name="movie" value="videoClient.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="FlashVars" value="appUrl=<%=appUrl%>&userId=<%=user != null?user.getId():""%>&ctxPath=<%=VideoConstants.WEBAPP_CONTEXT_PATH%>&role=<%=role%>"/>
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="videoClient.swf" width="100%" height="100%">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowFullScreen" value="true" />
                <!--<![endif]-->
                <!--[if gte IE 6]>-->
                	<p> 
                		Either scripts and active content are not permitted to run or Adobe Flash Player version
                		10.0.0 or greater is not installed.
                	</p>
                <!--<![endif]-->
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
                    </a>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
	    </noscript>	
   </body>
</html>
