<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title><fmt:message key='page.title.sessiontimeout' /></title>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/headerincludes.jsp" />
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>  	
  	<body>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp" />			
		<div class="wrapper">
			<h2><fmt:message key='page.title.sessiontimeout' /></h2>
			<p><fmt:message key='label.sessionhastimedout' /></p>
		</div>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
		<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
		<jsp:include page="/aaa_general/global-helper.jsp" />	
  	</body>
</html>