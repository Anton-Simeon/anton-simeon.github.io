<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${widgetSite != 'true'}">
	<div id="gst_info">
	<c:choose>
		<c:when test="${branch.taxes != null and branch.taxes.size() > 0}">
			<p><fmt:message key='label.without.gst' /></p>
		</c:when>
		<c:otherwise>
			<p><fmt:message key='label.with.gst' /></p>
		</c:otherwise>
	</c:choose>
	</div>
</c:if>