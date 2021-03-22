<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<meta charset="utf-8" />
<fmt:requestEncoding value="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="robots" content="index,follow" />
<link rel="apple-touch-icon" sizes="76x76" href="/apple-icon-76x76.png" />

<script src="/static/aaa_general/js/jquery.min.js"></script>
<script src="https://js.stripe.com/v3/"></script>
<jsp:include page="${website.standardFolderPath}/jsp/include/meta-tags.jsp" />
<c:choose>
	<c:when test="${refRootStaticUrl != null}">
		<link href="${refRootStaticUrl}/css/style.css" rel="stylesheet" />
	</c:when>
	<c:otherwise>
		<link href="${website.rootStaticUrl}/css/style.css" rel="stylesheet" type="text/css" />
	</c:otherwise>
</c:choose>
<c:if test="${company.salesCompanyName == 'i-host'}">
<link href="https://www.i-host.gr/content/orders/company-${company.id}.css" rel="stylesheet" type="text/css" />
</c:if>
<script type="text/javascript" src="/static/aaa_general/js/intl-tel-input/prism.js"></script>
<script type="text/javascript" src="/static/aaa_general/js/intl-tel-input/intlTelInput.js"></script>
