<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:if test="${loginForm.myAccountFlow == false}">
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.ajaxregister' /></c:set>
	<c:set var="ajaxforgotLoginUrl"><fmt:message key='url.path.ajaxforgotlogin' /></c:set>
</c:if>
<c:if test="${loginForm.myAccountFlow == true}">
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.myaccount.ajaxregister' /></c:set>
	<c:set var="ajaxforgotLoginUrl"><fmt:message key='url.path.myaccount.ajaxforgotlogin' /></c:set>
</c:if>
<script type="text/javascript">
	function login() {		
		$.ajax({
			type : "POST",
			url : '/myaccount/ajaxlogin',
			data : $('#loginform').serialize(),
			success : function(response) {
				if (response.status == 'failure') {
					$("#errorDiv").html(
							"<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
				} else {
					window.location = response.redirecturl;
				}
			},
			dataType : 'json'
		});
		return false;
	};
</script>
<div class="modal-header">
	<h4 class="modal-title"><fmt:message key='header.login.popup' /></h4>
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
</div>
<div class="modal-body">
	<form:form method="post" modelAttribute="loginForm" id="loginform">
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
		<form:hidden path="companyId" />
		<form:hidden path="refererUrl" />				
		<div id="errorDiv"></div>
		<div class="mb-3">
			<fmt:message key="label.email" var="var_email" />
			<form:input path="email" id="email" cssClass="form-control" placeholder="${var_email}" htmlEscape="true" maxlength="100" />
		</div>
		<div class="mb-3">
			<fmt:message key="label.password" var="var_password" />
			<form:password path="password" id="password" cssClass="form-control" placeholder="${var_password}" htmlEscape="true" maxlength="15" />
		</div>
	</form:form>
	<div class="d-grid">
		<button type="button" class="btn btn-primary" id="submitbutton" onclick="login()">
			<fmt:message key="label.button.login" />
		</button>
	</div>
	<div class="forgot-text">
		<span data-modal-href="/${ajaxforgotLoginUrl}/?companyId=${companyId}" data-bs-target="#forgotloginModal" data-bs-toggle="modal">
			<fmt:message key="label.link.forgotten.login" />
		</span>
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
	$(document).ready(function() {
		if( $(window).width() > 1025 ) {
			$("#email").focus();
		}
	});
</script>