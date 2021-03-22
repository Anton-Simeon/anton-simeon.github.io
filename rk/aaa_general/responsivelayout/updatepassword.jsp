<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="updatePasswordUrl"><fmt:message key='url.path.updatepassword' /></c:set>
<h2 class="profile-title"><fmt:message key='header.update.password' /></h2>
<div class="row">
	<form:form action="/${updatePasswordUrl}" method="post" modelAttribute="updatePasswordForm" id="updatepasswordform" role="form" class="col-lg-6 col-md-10">
		<form:hidden path="companyId"/>
		<spring:bind path="*">
		<c:set var="validationErrors"><form:errors path="*"/></c:set>
		<c:if test="${not empty validationErrors}"> 
			<div class="alert alert-dismissible alert-danger">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<c:forEach items="${status.errorMessages}" var="error">
				${error} <br />
			</c:forEach>
		</div>
		</c:if>
		</spring:bind>
		<c:if test="${successMessage != null}">
			<div class="alert alert-dismissible alert-success">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			${successMessage}
			</div>
		</c:if>
		<c:if test="${warningMessage != null}">
			<div class="alert alert-dismissible alert-warning">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			${warningMessage}
			</div>
		</c:if>
		<div class="mb-3">
			<label class="form-label" for="firstname"><fmt:message key="label.newpassword" /> <span class="required">*</span></label> 
			<form:password path="newPassword" id="newpassword" cssClass="form-control" htmlEscape="true" maxlength="15" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="lastname"><fmt:message key="label.retypepassword" /> <span class="required">*</span></label> 
			<form:password path="retypedPassword" id="retypedpassword" cssClass="form-control" htmlEscape="true" maxlength="15" />
		</div>
		<div class="mb-3 d-grid">
			<c:choose>
				<c:when test="${param.custombuttons == 'yes'}">
					<button type="submit" class="btn btn-primary btn-block"><fmt:message key="label.button.update" /></button>								
				</c:when>
				<c:otherwise>
					<button type="submit" class="btn btn-primary btn-block"><fmt:message key="label.button.update" /></button>								
				</c:otherwise>
			</c:choose>
		</div>
	</form:form>
</div>