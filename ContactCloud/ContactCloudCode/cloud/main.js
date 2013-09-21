
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
/*Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});*/

/*
Parse.Cloud.define("addUser", function(request, response) {
  var query = new Parse.Query("People");
  query.equalTo("number", request.params.number);
  query.find({
    success: function(results) {
function(post) {
 response.success('found: ' + JSON.stringify(results));
	post.save();}
    },
    error: function() {
      response.error("person lookup failed");
    }
  });
}); */

Parse.Cloud.beforeSave("People", function(request, response) {
  /*  var query = new Parse.Query("People");
  query.equalTo("number", request["object"]["number"]);
  query.find({
    success: function(results) {
   	response.error("person lookup failed"); 
    },
    error: function() {
      response.error("person lookup failed");
    }
  }); */
	response.error("request: " + JSON.stringify(request["object"]["number"]));
});

