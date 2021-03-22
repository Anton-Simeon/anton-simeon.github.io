<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title><fmt:message key='page.title.orderconfirmation' /></title>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/headerincludes.jsp">
			<jsp:param value="true" name="trackOrderConversion" />
		</jsp:include>
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>
  	<body>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp">
			<jsp:param value="true" name="hideMyOrderButton"/>
		</jsp:include>
		<div class="wrapper">
			<jsp:include page="/aaa_general/responsivelayout/orderconfirmation.jsp" />
		</div>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
		<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
		<jsp:include page="/aaa_general/global-helper.jsp" />
  	</body>
</html>