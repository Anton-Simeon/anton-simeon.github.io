<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery('#city').on('change', function() {
		var value = jQuery(this).val(); 
        jQuery.ajax({
            type: "POST",
            url: '/getAreaNames',
            data: { city: value},
            dataType: "json",
            success: function(response) {
                jQuery("#area").get(0).options.length = 0;
        		$.each(response.areaList, function(index, item) {
                	jQuery("#area").get(0).options[jQuery("#area").get(0).options.length] = new Option(item.area, item.area);
                });
            },
            error: function() {
                jQuery("#area").get(0).options.length = 0;
            }
         });
    })
})
</script>
<c:set var="guestConfirmDetailsUrl"><fmt:message key='url.path.guestconfirmdetails' /></c:set>
<h2><fmt:message key='page.title.orderdetails' /></h2>
	<c:if test="${infoMessage != null}">
		<div class="alert alert-dismissible alert-info">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${infoMessage}</strong>
		
		</div>
	</c:if>					
	<c:if test="${warningMessage != null}">
		<div class="alert alert-dismissible alert-warning">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${warningMessage}</strong>
		
		</div>
	</c:if>
	<c:if test="${not empty orderTypes}">		
	<div class="row">
		<form:form action="/${guestConfirmDetailsUrl}" method="post" modelAttribute="guestConfirmDetailsForm" id="guestconfirmdetailsform" role="form" class="col-md-9 col-sm-10 col-xs-12">
			<input type="hidden" name="isAddressBook" value="true" />
			<form:hidden path="companyId"/>
			<spring:bind path="*">
			<c:set var="validationErrors"><form:errors path="*"/></c:set>
			<c:if test="${not empty validationErrors}"> 
				<div class="alert alert-dismissible alert-danger">
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				<strong>
					<c:forEach items="${status.errorMessages}" var="error">
						${error} <br />
					</c:forEach>
				</strong>
				
			</div>
			</c:if>
			</spring:bind>
			<div class="mb-3">
				<label for="ordertype"><fmt:message key="label.ordertype" /> <span class="required">*</span></label> 
				<form:select path="orderType" onchange="changeOrderType(this.options[this.selectedIndex].value,${companyId});" id="ordertype" cssClass="form-control">	
					<c:forEach var="thisOrderType" items="${orderTypes}">
				   		<form:option value="${thisOrderType}"><plastocart:getmessage messageCode="${thisOrderType}" /></form:option>
				   	</c:forEach>
			    </form:select>
			</div>
			<div class="mb-3">
				<label for="paymentmethod"><fmt:message key="label.paymentmethod" /> <span class="required">*</span></label> 
		        <select id="paymentMethod" name="paymentMethod" class="form-control">	
			        <c:forEach var="thisPaymentMethod" items="${paymentMethods}">
						<option <c:if test="${thisPaymentMethod.paymentType == confirmDetailsForm.paymentMethod}">selected=\"selected\"</c:if> value="${thisPaymentMethod.paymentType}"><plastocart:getmessage messageCode="${thisPaymentMethod.paymentType}" /> </option>
					</c:forEach>
		        </select>
			</div>
			<div class="mb-3">
				<label for="ordertime"><fmt:message key="label.ordertime" /> <span class="required">*</span> <span aria-hidden="true" class="glyphicon glyphicon-dashboard"></span></label> 
				<tg:ordertimewriter orderTime="${customerorder.orderTime}" orderType="${customerorder.orderType}" branchId="${branch.id}" />
			</div>
			<hr>
			<div class="mb-3">
				<label for="firstname"><fmt:message key="label.firstname" /></label> 
				<form:input path="firstName" id="firstname" cssClass="form-control" htmlEscape="true" maxlength="60" />
			</div>
			<div class="mb-3">
				<label for="lastname"><fmt:message key="label.lastname" /></label> 
				<form:input path="lastName" id="lastname" cssClass="form-control" htmlEscape="true" maxlength="60" />
			</div>
			<div class="mb-3">
				<label for="email"><fmt:message key="label.email2" /></label> 
				<form:input path="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100" />
			</div>
			<div class="mb-3">
				<label for="telephone"><fmt:message key="label.phone" /> <span class="required">*</span></label> 
				<form:input path="phone" id="phone" cssClass="form-control" htmlEscape="true" maxlength="40" />
			</div>
			<div class="mb-3">
				<label for="instructions"><fmt:message key="label.specialinstructions" /></label>
				<form:textarea rows="2" cols="23" id="specialinstructions" path="specialInstructions" cssClass="form-control" maxlength="250" />
			</div>
			<div class="mb-3">
				<label for="promocode"><fmt:message key="label.promocode" /></label> 
				<form:input path="promoCode" id="promocode" cssClass="form-control" htmlEscape="true" maxlength="60" />
			</div>
			<hr>
			<div class="mb-3" id="addressbookdiv">
				<c:forEach items="${addressFieldRules}" var="fieldRule">
					<c:if test="${fieldRule.display}">
						<div class="mb-3">
							<label for="${fieldRule.fieldName}"><fmt:message key="label.${fieldRule.label}" /><c:if test="${fieldRule.required}"><span class="required">*</span></c:if></label>
							<c:choose>
								<c:when test="${fieldRule.fieldName == 'city'}">
									<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
										<c:forEach var="thisCity" items="${cityList}">
										<option value="${thisCity.city}">${thisCity.city}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:when test="${fieldRule.fieldName == 'area'}">
									<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
										<c:forEach var="thisArea" items="${areaList}">
										<option value="${thisArea.area}">${thisArea.area}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<form:input path="${fieldRule.fieldName}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" cssClass="form-control" htmlEscape="true" />
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="mb-3">
				<c:choose>
					<c:when test="${param.custombuttons == 'yes'}">									
						<c:choose>
							<c:when test="${param.hoverbuttons == 'yes'}">
								<button type="submit" class="btn btn-primary pull-right">
									<span class="text-large"><fmt:message key="label.button.continue.standard" /></span>
								</button>										
							</c:when>
							<c:otherwise>
								<button type="submit" class="btn btn-primary pull-right">
									<span class="text-large"><fmt:message key="label.button.continue.standard" /></span>
								</button>									
							</c:otherwise>
						</c:choose>										
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-primary pull-right">
							<span class="text-large"><fmt:message key="label.button.continue.standard" /></span>
						</button>
					</c:otherwise>
				</c:choose>
			</div>
		</form:form>
	</div>
</c:if>