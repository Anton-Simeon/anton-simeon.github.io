function updateShoppingCart() {
	console.log('asdas2_start');
	$.ajax({
    	type: "POST",
    	url: 'http://www.mocky.io/v2/5bd6293f310000600041dbfd',
    	data: {
    			menuId: 124, 
    			companyId: 15, 
    			clearcartflag: 'false'
    		  },
    	success: function(response) {
    		alert('done');
    		console.log('asdas2_success1');
    		console.log(response);
			console.log('asdas2_success2');
		},
		error: function (jqXHR, exception) {
		        var msg = '';
		        if (jqXHR.status === 0) {
		            msg = 'Not connect.\n Verify Network.';
		        } else if (jqXHR.status == 404) {
		            msg = 'Requested page not found. [404]';
		        } else if (jqXHR.status == 500) {
		            msg = 'Internal Server Error [500].';
		        } else if (exception === 'parsererror') {
		            msg = 'Requested JSON parse failed.';
		        } else if (exception === 'timeout') {
		            msg = 'Time out error.';
		        } else if (exception === 'abort') {
		            msg = 'Ajax request aborted.';
		        } else {
		            msg = 'Uncaught Error.\n' + jqXHR.responseText;
		        }
		        console.log('erorrName: ' + msg);
		    },
    	dataType: 'json'
    });
}