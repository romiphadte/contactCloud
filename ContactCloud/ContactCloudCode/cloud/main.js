
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
/*Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});*/

Parse.Cloud.beforeSave("People", function(request, response) {
  var query = new Parse.Query("People");
  query.equalTo("number", request.object.get("number"));
  query.find({
    success: function(results) {
	if(results.length){
		response.error();
	} else{
		response.success();
	}
    },
    error: function() {
      response.success();
    }
  });
});

