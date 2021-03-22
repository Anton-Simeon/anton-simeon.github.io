<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle"><fmt:message key='page.title.storesignup' /></c:set>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title>${pageTitle} | ${company.name}</title>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/headerincludes.jsp" />
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>
  	<body>
  		<div class="mainWrapp_scroll">
	  		<div class="mainWrapp">
				<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp" />
				<div class="containerWrapp container">
					<jsp:include page="/aaa_general/responsivelayout/restaurant-signup.jsp">
						<jsp:param value="${pageTitle}" name="pageTitle"/>
						<jsp:param value="${storeSignUpToEmail}" name="emailTo"/>					
					</jsp:include>
				</div>
			</div>
			<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
			<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
			<jsp:include page="/aaa_general/global-helper.jsp" />
		</div>
  	</body>
</html>