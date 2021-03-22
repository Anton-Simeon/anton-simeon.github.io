<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="col-xs-4">
	<div class="nav-side-menu movable-div" style="margin-top: 0px;">
		<c:if test="${param.addSearchBar == true}">
			<div class="rest-search-wrap">
				<div class="rest-search">
					<input type="text" class="form-control" placeholder="<fmt:message key='label.restsearch.searchstorebyname'/>" name="restname" id="restname" value="${restaurantname}" />
					<span class="search-icn"> </span>
				</div>
			</div>
		</c:if>
		<div class="brand"><fmt:message key='label.categories' /></div>
		<ul id="menu-content" class="menu-content">
			<c:forEach var="thisCategory" items="${menu.categories}" varStatus="status">
				<li data-target="#${thisCategory.id}"><a href="#">
				<c:choose>
					<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${thisCategory.name2}								
					</c:when>
					<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${thisCategory.name3}</a></li>
					</c:when>
					<c:otherwise>
						${thisCategory.name}
					</c:otherwise>
				</c:choose>
				</a></li>
			</c:forEach>
		</ul>
	</div>
</div>