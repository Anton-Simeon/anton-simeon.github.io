<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:if test="${loginForm.myAccountFlow == false}">
	<c:set var="loginUrl"><fmt:message key='url.path.login' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.register' /></c:set>
	<c:set var="forgotLoginUrl"><fmt:message key='url.path.forgotlogin' /></c:set>
</c:if>
<c:if test="${loginForm.myAccountFlow == true}">
	<c:set var="loginUrl"><fmt:message key='url.path.myaccount.login' /></c:set>
	<c:set var="forgotLoginUrl"><fmt:message key='url.path.myaccount.forgotlogin' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.myaccount.register' /></c:set>
</c:if>
<c:set var="shoppingCartEmpty" value="TRUE" />
<c:set var="customerOrder" value="${customerOrder}" />
<form:form action="/${forgotLoginUrl}" method="post" modelAttribute="forgotLoginDetailsForm" id="forgotloginform" role="form">
	<spring:bind path="*">
	<div class="alert alert-dismissible alert-info"><fmt:message key='reset.password.info' /></div>		
	<c:set var="validationErrors"><form:errors path="*"/></c:set>
	<c:if test="${not empty validationErrors}"> 
		<div class="alert alert-dismissible alert-danger">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>
				<c:forEach var="error" items="${status.errors.allErrors}">
	             	<fmt:message key="${error.code}"></fmt:message> <br />
				</c:forEach>
			</strong>
			
		</div>
	</c:if>
	</spring:bind>
	<form:hidden path="companyId"/>
	<c:if test="${successMessage != null}">
		<div class="alert alert-dismissible alert-success">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${successMessage}</strong>
		
		</div>
	</c:if>
	<div class="mb-3">
		<label class="form-label" for="username"><fmt:message key="label.email" /><span class="required">*</span></label>
		<form:input path="email" id="email" class="form-control" htmlEscape="true" maxlength="100" />
	</div>
	<div class="d-grid">
		<button type="submit" class="btn btn-primary">
			<fmt:message key="label.button.submit" />
		</button>
	</div>
	<div class="authorization-form-footer mb-5">
		<h4><fmt:message key="label.newcustomer" /></h4>
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${registerUrl}?companyId=${companyId}" class="btn btn-primary">
					<fmt:message key="label.button.create.account" />
				</a>
			</c:when>
			<c:otherwise>
				<a href="/${registerUrl}" class="btn btn-primary">
					<fmt:message key="label.button.create.account" />
				</a>
			</c:otherwise>
		</c:choose>
	</div>
</form:form>