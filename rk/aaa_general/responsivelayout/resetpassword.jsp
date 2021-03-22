<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="resetPasswordUrl"><fmt:message key='url.path.myaccount.resetpassword' /></c:set>
<form:form action="/${resetPasswordUrl}"  method="post" modelAttribute="resetPasswordForm" id="resetPasswordForm">
	<form:hidden path="companyId" />
	<form:hidden path="customerId" />
	<form:hidden path="token" />
	<div id="errorDiv"></div>
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
	<c:if test="${warningMessage != null}">
		<div class="alert alert-dismissible alert-danger">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${warningMessage}</strong>
		</div>
	</c:if>
	<c:if test="${successMessage != null}">
		<div class="alert alert-dismissible alert-success">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${successMessage}</strong>
		</div>
	</c:if>			
	<div class="mb-3">
		<label for="newPassword"><fmt:message key="label.newpassword" /><span class="required">*</span></label>
		<form:password path="newPassword" id="newPassword" cssClass="form-control" htmlEscape="true" maxlength="15"/>
	</div>
	<div class="mb-3">
		<label for="newPasswordConfirm"><fmt:message key="label.newpassword.confirm" /> <span class="required">*</span></label>
		<form:password path="newPasswordConfirm" id="newPasswordConfirm" cssClass="form-control" htmlEscape="true" maxlength="15"/>
	</div>
	<div class="d-grid mb-5">
		<button type="submit" class="btn btn-primary">
			<fmt:message key="label.button.submit" />
		</button>
	</div>
</form:form>