var Observable = require("FuseJS/Observable");
var MediaQuery = require("FuseJS/MediaQuery");

var doonIt = false;

var foo = function() {
	var query = {
		"kind": MediaQuery.Music,
		"artist": "Splen"
	};
	MediaQuery.fetch(query).then(function(results) {
		console.log("Here it is!:" + results);
	}).catch(function(e) {
		console.log("Well damn:" + e);
	});
};

module.exports = {
	foo: foo
};
