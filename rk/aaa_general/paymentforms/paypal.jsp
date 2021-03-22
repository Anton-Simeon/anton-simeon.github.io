<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.blueplustechnologies.core.model.Company" %>
<%@ page import="com.blueplustechnologies.core.model.CompanyIntegration" %>
<%@ page import="com.blueplustechnologies.core.model.CompanyIntegrationParam" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethod" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegration" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegrationParam" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<%
	Company company = WebContextUtil.getCompany();

	String mode = null;
	PaymentMethod paymentMethod = (PaymentMethod) WebContextUtil.getSession().getAttribute("paymentmethod");	
	PaymentMethodIntegration paymentMethodIntegration = paymentMethod.getPaymentMethodIntegration();
	if (paymentMethodIntegration != null && paymentMethodIntegration.getPaymentMethodIntegrationParams() != null) {
		for (PaymentMethodIntegrationParam thisPaymentMethodIntegrationParam: paymentMethodIntegration.getPaymentMethodIntegrationParams()) {
			if (thisPaymentMethodIntegrationParam.getKey().equals("mode")) {
				mode = thisPaymentMethodIntegrationParam.getValue();
				break;
			}
		}
	}
%>
<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<div id="paypal-button-container"></div>
<script>paypal.Button.render(
{env: '<%= mode %>', 
commit: true, 
payment: function() {
var CREATE_URL = '/paypal/payment/create?companyId=<%= company.getId() %>';
return paypal.request.post(CREATE_URL).then(function(res) 
{return res.paymentID;
});},
onAuthorize: 
function(data, actions) {
var EXECUTE_URL = '/paypal/payment/execute?companyId=<%= company.getId() %>';
var data = {
paymentID: data.paymentID,
payerID: data.payerID};

return paypal.request.post(EXECUTE_URL, data).then(function (res) {
console.log(res);
return actions.redirect();
});
}}, '#paypal-button-container');</script>