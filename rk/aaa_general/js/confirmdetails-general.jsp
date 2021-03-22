<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#addressbookTablediv').on("click", "table tr", function(){
			jQuery(this).find('td input:radio').prop('checked', true);
		});
	});
	
	function deleteaddress(addressid,companyId){
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxdeleteaddress/'+addressid,
	    	data: {"referer": "confirmdetails","companyId": companyId},
	    	success: function(response) {
	    		if (response.status == 'failure') {
	    			alert("Failed to Delete");
	    		} else {
	    			jQuery('#addressbookTablediv').html(response.addressbookHtml);
	    		}
	    	},
	    	dataType: 'json'
	    });
	}
</script>