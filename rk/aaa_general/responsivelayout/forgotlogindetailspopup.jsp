<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:if test="${loginForm.myAccountFlow == false}">
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.ajaxregister' /></c:set>
</c:if>
<c:if test="${loginForm.myAccountFlow == true}">
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.myaccount.ajaxregister' /></c:set>
</c:if>
<c:set var="shoppingCartEmpty" value="TRUE" />
<c:set var="customerOrder" value="${customerorder}" />
<script type="text/javascript">
	function forgotLogin() {
		console.log('asdasdas');
		$.ajax({
			type: "POST",
			url: '/myaccount/ajaxforgotlogin',
			data: $('#forgotloginform').serialize(),
			success: function(response) {
				if (response.status == 'failure') {
					$("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
				} else {
					$("#errorDiv").html("<div class=\"alert alert-dismissible alert-success\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.successMessage + "</div>");
					$("#usernamefield").hide();
					$("#sendpassword").hide();
					$("#links").hide();
					$("#continuelogin").show();
				}
			},
			dataType: 'json'
		});
		return false;
	};
</script>
<div class="modal-header">
	<h4 class="modal-title"><fmt:message key='header.forgot.login.details' /></h4>
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
</div>
<div class="modal-body">
	<form:form method="post" modelAttribute="forgotLoginDetailsForm" id="forgotloginform" role="form">
		<form:hidden path="companyId"/>
		<spring:bind path="*">				
		<div class="alert alert-dismissible alert-info"><fmt:message key='reset.password.info' /></div>					
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
		<div id="errorDiv"></div>
		<div class="mb-3">
			<fmt:message key="label.email" var="var_email" />
			<form:input type="email" path="email" id="email" class="form-control" placeholder="${var_email}" htmlEscape="true" maxlength="100" />
		</div>								
	</form:form>
	<div class="d-grid mb-1">
		<button type="submit" class="btn btn-primary" onclick="forgotLogin()"><fmt:message key="label.button.submit" /></button>
	</div>
</div>
<div class="modal-footer">
	<h4><fmt:message key="label.newcustomer" /></h4>
	<c:choose>
		<c:when test="${widgetSite == 'true'}">
			<button type="button" data-modal-href="/${ajaxregisterUrl}?companyId=${companyId}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">
				<fmt:message key="label.button.create.account" />
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" data-modal-href="/${ajaxregisterUrl}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">
				<fmt:message key="label.button.create.account" />
			</button>
		</c:otherwise>
	</c:choose>
</div>
<script type="text/javascript">
$(document).ready(function () {
	$("#email").focus();
});
</script>