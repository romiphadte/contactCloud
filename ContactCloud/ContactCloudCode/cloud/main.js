
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
/*Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});*/

Parse.Cloud.define("addUser", function(request, response) {
  var query = new Parse.Query("People");
  query.equalTo("number", request.params.number);
  query.find({
    success: function(results) {
      response.success('found: ' + JSON.stringify(results));
    },
    error: function() {
      response.error("person lookup failed");
    }
  });
});

