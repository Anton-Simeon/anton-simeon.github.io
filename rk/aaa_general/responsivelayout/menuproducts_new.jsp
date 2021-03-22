<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.blueplustechnologies.plastocart.util.Constants" %>
<c:set var="addItemUrl"><fmt:message key='url.path.ajaxadditem' /></c:set>
<div class="section-menu-wrap">
<c:forEach var="thisMenuCategory" items="${menu.categories}" varStatus = "status">
	<div class="section-menu" data-idproduct="${thisMenuCategory.id}">
		<div class="description-menu">
			<c:choose>
				<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
					<h3>${thisMenuCategory.name2}</h3>
				</c:when>
				<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
					<h3>${thisMenuCategory.name3}</h3>
				</c:when>
				<c:otherwise>
					<h3>${thisMenuCategory.name}</h3>
				</c:otherwise>
			</c:choose>
			<c:if test="${thisMenuCategory.description != null and thisMenuCategory.description != ''}">
				<c:choose>
					<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${thisMenuCategory.description2}								
					</c:when>
					<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						${thisMenuCategory.description3}
					</c:when>
					<c:otherwise>
						${thisMenuCategory.description}
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
		<div role="tablist" aria-multiselectable="true">
			<ul class="products-list">
				<c:forEach var="thisProduct" items="${thisMenuCategory.products}" varStatus="loop">
					<li>
						<div class="one-product" onclick="this.blur(); addItemCart(${thisMenuCategory.id},${thisProduct.id},${thisProduct.categoryId});">
							<c:if test="${thisProduct.productPhotoUrl != null and thisProduct.productPhotoUrl != ''}">
							    <c:set var='photoUrl' value="${fn:replace(thisProduct.productPhotoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_200,c_limit/v')}" />
								<c:set var='photoUrl' value="${fn:replace(photoUrl, 'f_auto,q_auto,dpr_auto,w_640,c_limit', 'f_auto,q_auto,dpr_auto,w_200,c_limit')}" />

								<div class="product-img-wrap lazyload" data-src="${photoUrl}"></div>
							</c:if>
							<div class="product-info">
<%-- 								<c:if test="${thisProduct.allergies != null and not empty thisProduct.allergies }">							 --%>
<!-- 									<div class="allergy-tooltip-position"> -->
<!-- 										<div class="allergy-tooltip-dots"> -->
<!-- 											<div style="background: #c4a83c;"></div> -->
<!-- 											<div style="background: #f97d72;"></div> -->
<!-- 											<div style="background: #70d6c5;"></div> -->
<!-- 											<div style="background: #89b7c7;"></div> -->
<!-- 											<div style="background: #a7b9b8;"></div> -->
<!-- 										</div> -->
<!-- 										<div class="allergy-tooltip"> -->
<%-- 											<c:forEach var="thisAllergy" items="${thisProduct.allergies}"> --%>
<%-- 												<div><img src="${thisAllergy.foodAllergyIconPhotoUrl}">  --%>
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 															${thisAllergy.name2}								 --%>
<%-- 														</c:when> --%>
<%-- 														<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 															${thisAllergy.name3} --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<%-- 															${thisAllergy.name1} --%>
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
<!-- 												</div> -->
<%-- 											</c:forEach>										 --%>
<!-- 										</div> -->
<!-- 									</div> -->
<%-- 								</c:if> --%>
								<h2 class="product-title">
									<c:choose>
										<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
											${thisProduct.name2}								
										</c:when>
										<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
											${thisProduct.name3}
										</c:when>
										<c:otherwise>
											${thisProduct.name}
										</c:otherwise>
									</c:choose>
								</h2>
								<div class="product-text">
									<p>
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
								<div class="product-price">
									<plastocart:gtz value="${thisProduct.price}">
										<plastocart:fmcn locale="${currencyLocale}" value="${thisProduct.price}" />
									</plastocart:gtz>
								</div>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:forEach>
</div>
<%-- <c:if test="${allergies != null and not empty allergies}">	 --%>
<!-- 	<div class="section-allergy"> -->
<!-- 		<div class="section-allergy-title"> -->
<%-- 			<h3><fmt:message key='page.title.allergy' /></h3> <div class="allergy-arrow"></div> --%>
<!-- 		</div> -->
<!-- 		<div class="wrap-allergy-containers"> -->
<!-- 			<div class="allergy-container-column"> -->
<%-- 				<c:forEach var="thisAllergy" items="${allergies}"> --%>
<!-- 					<div class="allergy-container"> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col-lg-2 col-md-3 col-sm-3 col-xs-3"> -->
<%-- 								<img class="allergy-icn" src="${thisAllergy.foodAllergyIconPhotoUrl}"> --%>
<!-- 							</div> -->
<!-- 							<div class="col-lg-10 col-md-9 col-sm-9 col-xs-9"> -->
<!-- 								<h4> -->
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 											${thisAllergy.name2} --%>
<%-- 										</c:when> --%>
<%-- 										<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 											${thisAllergy.name3} --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											${thisAllergy.name1} --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<!-- 								</h4> -->
<!-- 								<p> -->
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 											${thisAllergy.description2} --%>
<%-- 										</c:when> --%>
<%-- 										<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}"> --%>
<%-- 											${thisAllergy.description3} --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											${thisAllergy.description1} --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<!-- 								</p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div>				 -->
<%-- 				</c:forEach> --%>
<!-- 			</div>	 -->
<!-- 		</div> -->
<!-- 	</div> -->
<%-- </c:if> --%>
<script type="text/javascript">
	var titlesProducts = [
		<c:forEach var="thisMenuCategory" items="${menu.categories}" varStatus = "status">
			<c:forEach var="thisProduct" items="${thisMenuCategory.products}" varStatus="loop">

				[
				${thisMenuCategory.id},
				<c:choose>
					<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						"${fn:replace(thisProduct.name2, '\"', '&#34;')}"						
					</c:when>
					<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
						"${fn:replace(thisProduct.name3, '\"', '&#34;')}"
					</c:when>
					<c:otherwise>
						"${fn:replace(thisProduct.name, '\"', '&#34;')}"
					</c:otherwise>
				</c:choose>

				],

			</c:forEach>
		</c:forEach>
	];
</script>