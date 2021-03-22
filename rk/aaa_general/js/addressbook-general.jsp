<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
	function deleteaddress(addressid){
		$.ajax({
	    	type: "POST",
	    	url: "/ajaxdeleteaddress/"+addressid+"?companyId="+${companyId},
	    	data: $('#submenuform').serialize(),
	    	success: function(response) {
	    		if (response.status == 'failure') {
	    			alert("Failed to Delete");
	    		} else if (response.status == 'sessiontimeout') {
		    		window.location.replace('/sessiontimeout');
		    	} else {
	    			location.reload();
	    		}
	    	},
	    	dataType: 'json'
	    });
	}
	
	$(document).ready(function () {
		$('#addressBookModal').on('show.bs.modal', function (event) {
	        $.ajax({
		    	type: "POST",
		    	url: "/ajaxchecksession?companyId="+${companyId},
		    	data: $('#submenuform').serialize(),
		    	success: function(response) {
		    		if (response.status == 'sessiontimeout') {
		    			window.location.replace('/sessiontimeout');
			    	}
		    	},
		    	error: function() {
		    		alert("Cannot process the request at this time. Please try again later.");
		    	},
		    	dataType: 'json'
		    });
	    })
	});
</script>