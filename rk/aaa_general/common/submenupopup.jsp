<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.blueplustechnologies.core.model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%
	Product product = (Product)request.getAttribute("productsubmenu");
%>
<jsp:include page="/aaa_general/js/submenupopup-general.jsp" />
<c:choose>
	<c:when test="${errormessage != null and errormessage != ''}">
		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
		<div class="validation_error">${errormessage}</div>	
	</c:when>
	<c:otherwise>
		<button type="button" class="btn-close btn-close-add-modal" data-bs-dismiss="modal" aria-hidden="true"></button>
		<div id="errorDiv"></div>
		<form id="submenuform" onsubmit="return addItem()" method="post">
			<input type="hidden" name="menuId" value="${menu.id}" /> 
			<input type="hidden" name="categoryId" value="${category.id}" /> 
			<input type="hidden" name="productCategoryId" value="${productsubmenu.categoryId}" /> 
			<input type="hidden" name="productId" value="${productsubmenu.id}" /> 
			<input type="hidden" name="orderItemId" value="${orderItemId}" />
			<input type="hidden" name="companyId" value="${companyId}" />
			<div class="row add-modal-columns">
				<div class="col-md-6">
					<c:if test="${productsubmenu.productPhotoUrl != null and productsubmenu.productPhotoUrl != ''}">
						<img src="${fn:replace(productsubmenu.productPhotoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_640,c_limit/v')}" class="img-fluid">
					</c:if> 
					<div class="product-content-menu">
						<h4>
							<c:choose>
								<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
									${productsubmenu.name2}
								</c:when>
								<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
									${productsubmenu.name3}
								</c:when>
								<c:otherwise>
									${productsubmenu.name}
								</c:otherwise>
							</c:choose>
						</h4>
						<p>
							<c:choose>
								<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">											
									<%= product.getDescription2() != null ? product.getDescription2().replace("\n","<br />") : "" %>
								</c:when>
								<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
									<%= product.getDescription3() != null ? product.getDescription3().replace("\n","<br />") : "" %>
								</c:when>
								<c:otherwise>
									<%= product.getDescription() != null ? product.getDescription().replace("\n","<br />") : "" %>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
					<div class="modal-menu-price">
						<plastocart:gtz value="${productsubmenu.price}">
							<plastocart:fmcn locale="${defaultLocale}" value="${productsubmenu.price}" />
						</plastocart:gtz>
					</div>
					<div class="modal-menu-quantity">
						<label for="productquantity"><fmt:message key='label.quantity' /></label> 
						<select name="productquantity" id="productquantity" class="form-select">
							<option value="1" <c:if test="${productQuantity == '1'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>1</option>
							<option value="2" <c:if test="${productQuantity == '2'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>2</option>
							<option value="3" <c:if test="${productQuantity == '3'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>3</option>
							<option value="4" <c:if test="${productQuantity == '4'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>4</option>
							<option value="5" <c:if test="${productQuantity == '5'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>5</option>
							<option value="6" <c:if test="${productQuantity == '6'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>6</option>
							<option value="7" <c:if test="${productQuantity == '7'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>7</option>
							<option value="8" <c:if test="${productQuantity == '8'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>8</option>
							<option value="9" <c:if test="${productQuantity == '9'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>9</option>
							<option value="10" <c:if test="${productQuantity == '10'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>10</option>
							<option value="11" <c:if test="${productQuantity == '11'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>11</option>
							<option value="12" <c:if test="${productQuantity == '12'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>12</option>
							<option value="13" <c:if test="${productQuantity == '13'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>13</option>
							<option value="14" <c:if test="${productQuantity == '14'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>14</option>
							<option value="15" <c:if test="${productQuantity == '15'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>15</option>
							<option value="16" <c:if test="${productQuantity == '16'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>16</option>
							<option value="17" <c:if test="${productQuantity == '17'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>17</option>
							<option value="18" <c:if test="${productQuantity == '18'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>18</option>
							<option value="19" <c:if test="${productQuantity == '19'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>19</option>
							<option value="20" <c:if test="${productQuantity == '20'}"><c:out escapeXml="false" value="selected=\"selected\"" /></c:if>>20</option>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="submenu-form-box">
						<c:if test="${productsubmenu.promotionCode != null and productsubmenu.promotionCode != ''}">
							<div class="mb-3">
								<div class="promotioncode-div">
									<label for="promotioncode"><fmt:message key="label.promotioncode" /></label> 
									<input type="text" id="promotioncode" name="promotioncode" value="${promotionCode}" class="promotioncode" />
								</div>
							</div>
						</c:if>
						<div class="mb-3">
							<plastocart:printoptiongroupsresponsive product="${productsubmenu}" />
						</div>
						<c:if test="${param.instructions != 'disabled'}">
							<div>
								<h5 class="optiongroup-title"><fmt:message key="label.specialinstructions" /></h5> 
								<textarea id="instructions" name="instructions" class="form-control">${instructions}</textarea> <fmt:message key="label.optional" />
							</div>
						</c:if>
					</div>
					<div class="d-grid">
						<button id="submitbutton" class="btn btn-primary" type="button" onclick="javascript: formsubmit();"><fmt:message key='label.button.additem' /></button>
					</div>
				</div>
			</div>
		</form>
	</c:otherwise>
</c:choose>