<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title><fmt:message key='page.title.updatepassword' /></title>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/headerincludes.jsp" />
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>  	
	<body>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp" />
		<div class="wrapper">
			<div class="row">
				<jsp:include page="/aaa_general/responsivelayout/myaccountlinks.jsp">
					<jsp:param value="updatepassword" name="selected" />
				</jsp:include>
				<div class="col-md-9">
					<jsp:include page="/aaa_general/responsivelayout/myaccountlinkssmall.jsp">
						<jsp:param value="updatepassword" name="selected" />
					</jsp:include>
					<jsp:include page="/aaa_general/responsivelayout/updatepassword.jsp">
						<jsp:param value="yes" name="custombuttons" />
						<jsp:param value="yes" name="hoverbuttons" />
					</jsp:include>
				</div>
			</div>
		</div>
		<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
		<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
		<jsp:include page="/aaa_general/global-helper.jsp" />
	</body>
</html>