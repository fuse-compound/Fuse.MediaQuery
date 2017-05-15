var Observable = require("FuseJS/Observable");
var MediaQuery = require("FuseJS/MediaQuery");

var doonIt = false;

var foo = function() {
	var query = {
		"kind": MediaQuery.Music,
		"artist": "Alan Gogoll"
	};
	MediaQuery.fetch(query).then(function(results) {
		var json_results = JSON.stringify(results);
		console.log("Here it is!:" + json_results);
	}).catch(function(e) {
		console.log("Well damn:" + e);
	});
};

module.exports = {
	foo: foo
};
