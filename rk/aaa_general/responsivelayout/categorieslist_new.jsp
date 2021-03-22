<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="locationUrl"><fmt:message key='url.path.store' /></c:set>
<c:if test="${company.companyType eq 'PORTAL' or company.companyType eq 'RESTAURANT'}">
	<c:set var="locationUrl"><fmt:message key='url.path.menu' /></c:set>
</c:if>
<c:set var="companyIdParam"></c:set>
<c:if test="${not empty menus}">
	<c:if test="${menus.size() gt 1}">
		<div class="dropdown-select d-md-none">
			<div class="form-select" data-bs-toggle="dropdown" aria-expanded="false">
				<c:choose>
					<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${menu.name2}					
					</c:when>
					<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${menu.name3}
					</c:when>
					<c:otherwise>
						${menu.name1}
					</c:otherwise>
				</c:choose>				
			</div>			
			<ul class="dropdown-menu">
				<c:forEach var="thisMenu" items="${menus}" varStatus="status">
					<c:choose>
						<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
							<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name2}</a></li>
						</c:when>
						<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
							<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name3}</a></li>
						</c:when>
						<c:otherwise>
							<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name1}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
	</c:if>
</c:if>

<div class="menu-nav-static-js">
	<div class="menu-nav-wrap">
		<div class="wrap-menu-scroll">
			<div class="menu-scroll">
				<ul class="menu-nav">
					<c:forEach var="thisCategory" items="${menu.categories}" varStatus="status">
						<li class="${status.first ? 'active' : ''}" data-target="${thisCategory.id}">
						<c:choose>
							<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
								${thisCategory.name2}								
							</c:when>
							<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
								${thisCategory.name3}
							</c:when>
							<c:otherwise>
								${thisCategory.name}
							</c:otherwise>
						</c:choose>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="menu-scroll__track">
				<div class="menu-scroll__bar"></div>
			</div>
		</div>
	</div>
</div>

<div class="search-product">
	<input type="text" class="form-control" placeholder="<fmt:message key='label.search.products' />" name="productname" id="productname" />
</div>