<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="addItemUrl"><fmt:message key='url.path.ajaxadditem' /></c:set>
<div role="tablist" aria-multiselectable="true">
	<c:forEach var="thisMenuCategory" items="${menu.categories}" varStatus = "status">
		<div class="panel" id="${thisMenuCategory.id}">
			<div class="panel-heading" role="tab">
				<h4 class="panel-title">
					<a ${status.first ? '' : 'class="collapsed"'} data-toggle="collapse" data-parent="#accordion" href="#${thisMenuCategory.id}ab" aria-expanded="true" aria-controls="collapseOne">
						<c:choose>
							<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
								${thisMenuCategory.name2}								
							</c:when>
							<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
								${thisMenuCategory.name3}</a></li>
							</c:when>
							<c:otherwise>
								${thisMenuCategory.name}
							</c:otherwise>
						</c:choose>
					</a>
				</h4>
			</div>
			<div id="${thisMenuCategory.id}ab" class="panel-collapse collapse ${status.first ? 'in' : ''}" role="tabpanel" aria-labelledby="headingOne">
				<div class="panel-body">
					<c:if test="${thisMenuCategory.description != null and thisMenuCategory.description != ''}">
						<ul class="event-list-desc">
							<li>
								<c:choose>
									<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
										${thisMenuCategory.description2}								
									</c:when>
									<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
										${thisMenuCategory.description3}</a></li>
									</c:when>
									<c:otherwise>
										${thisMenuCategory.description}
									</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</c:if>
					<ul class="event-list">
						<c:forEach var="thisProduct" items="${thisMenuCategory.products}" varStatus="loop">
							<li>
								<c:if test="${thisProduct.productPhotoUrl != null and thisProduct.productPhotoUrl != ''}">
									<div class="on-hover-content" style="display: none;">
										<img class="lazyload" data-src="${fn:replace(photo.productPhotoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_200,c_limit/v')}" />
									</div>
									<img class="lazyload prodimage" data-src="${fn:replace(photo.productPhotoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_200,c_limit/v')}" />
								</c:if>
								<div class="info">

									<h2 class="title">
										<c:choose>
											<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
												${thisProduct.name2}								
											</c:when>
											<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
												${thisProduct.name3}</a></li>
											</c:when>
											<c:otherwise>
												${thisProduct.name}
											</c:otherwise>
										</c:choose>
									</h2>
									<p class="desc">
										<c:choose>
											<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
												${thisProduct.description2}								
											</c:when>
											<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
												${thisProduct.description3}</a></li>
											</c:when>
											<c:otherwise>
												${thisProduct.description}
											</c:otherwise>
										</c:choose>
									</p>
								</div>
								<div class="social">
									<p class="text-right price">
										<plastocart:gtz value="${thisProduct.price}">
											<plastocart:fmcn locale="${currencyLocale}" value="${thisProduct.price}" />
										</plastocart:gtz>
									</p>
									<button type="button" class="btn cart-button pull-right" onclick="this.blur(); addItemCart(${thisMenuCategory.id},${thisProduct.id},${thisProduct.categoryId});"><fmt:message key='label.add' /></button>										
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</c:forEach>
</div>