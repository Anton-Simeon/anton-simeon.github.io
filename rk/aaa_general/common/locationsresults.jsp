<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title><fmt:message key='page.title.locations' /></title>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/headerincludes.jsp" />
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>
	<body class="business-page no-sidebar-business-page">
    <div class="mainWrapp_scroll">
		<div class="mainWrapp">
			<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp">
				<jsp:param value="index" name="selected" />
			</jsp:include>
			<div class="containerWrapp container">
				<jsp:include page="/aaa_general/responsivelayout/locationresultssidebar-business.jsp" />
				<jsp:include page="/aaa_general/responsivelayout/locationresults_new.jsp" />
			</div>
		</div>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
		<script src="/static/aaa_general/js/ajax_plugin.js"></script>
		<jsp:include page="/aaa_general/js/locationsresults-general.jsp" />
		<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
		<jsp:include page="/aaa_general/global-helper.jsp" />
	</div>
	</body>
</html>