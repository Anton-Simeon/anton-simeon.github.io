<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="categories" scope="request" value="${menu.categories}" />
<c:set value="${company.companyType eq 'GROCERYPORTAL'}" var="isGrosseryStore"/>
<c:forEach var="thisCategory" items="${categories}">
	<c:if test="${thisCategory.id == currentCategory.id}">
		<c:set var="category" scope="request" value="${thisCategory}" />
	</c:if>
</c:forEach>
<c:if test="${category == null}">
	<c:set var="category" scope="request" value="${categories[0]}" />
</c:if>
<c:if test="${menu.menuPhotoUrl != null and menu.menuPhotoUrl != ''}">
	<div class="menu-img-top" style="background-image: url(${fn:replace(menu.menuPhotoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_2050,c_limit/v')});"></div>	
</c:if>