
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
/*Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});*/

Parse.Cloud.beforeSave("People", function(request, response) {
	if(request.object.get('status') != 'force') {
		var query = new Parse.Query("People");
		query.equalTo("number", request.object.get("number"));
		query.find({
	  	  success: function(results) {
		  	  if(results.length){
			  	  //increment validity count
			  	  var before = results[0].get('strength');
			  	  results[0].increment("strength", 1);
			  	  results[0].save('status', 'force')
			  	  			.then(function(gameTurnAgain) {
				  	  			response.error('success: ' + before + " -> "  + results[0].get('strength'));
				  	  		}, function(error) {
					  	  		response.error('error: ' + JSON.stringify(error));
					  	  	}); 
			  } else{
				  response.success();
			  }
		  },
		  error: function() {
		      response.success();
		  }
	   });
  } else{
	request.object.unset('status');
	response.success();
  }
});

