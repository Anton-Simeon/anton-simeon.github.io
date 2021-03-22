<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
	<jsp:include page="/aaa_general/language-support.jsp"/>
	<head>
		<title><fmt:message key='page.title.confirmdetails' /></title>
		<jsp:include page="/aaa_general/meta_tag_responsive_no_head.jsp" />
	</head>    
  	<body>
  		<div class="mainWrapp_scroll">
	  		<div class="mainWrapp">
				<jsp:include page="/${website.standardFolderPath}/jsp/include/header.jsp" />
				<div class="containerWrapp container">
					<div class="row">
						<div id="confirmdetailsForm" class="col-sm-8 vertical-form">
							<div class="info_box form_holder">
								<div class="info_inner">
									<div class="info_content">
										<jsp:include page="/aaa_general/responsivelayout/guestconfirmdetails.jsp">
											<jsp:param value="yes" name="custombuttons" />
											<jsp:param value="yes" name="hoverbuttons" />
										</jsp:include>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4 myorderForm hidden-xs">
							<div class="info_box form_holder">
								<div class="info_inner">
									<div class="info_content">
										<jsp:include page="/aaa_general/responsivelayout/shoppingcart.jsp" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="/${website.standardFolderPath}/jsp/include/footer.jsp" />
			<jsp:include page="/${website.standardFolderPath}/jsp/include/analytics.jsp" />
			<jsp:include page="/aaa_general/global-helper.jsp" />
		</div>
  	</body>
</html>