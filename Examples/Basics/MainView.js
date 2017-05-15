var Observable = require("FuseJS/Observable");
var MediaQuery = require("FuseJS/MediaQuery");

var doonIt = false;

var tracks = function() {
	var query = {
		"artist": "Alan Gogoll"
	};
	MediaQuery.tracks(query).then(function(results) {
		var json_results = JSON.stringify(results);
		console.log("Here it is!:" + json_results);
	}).catch(function(e) {
		console.log("Well damn:" + e);
	});
};

var artists = function() {
	var query = {};
	MediaQuery.artists(query).then(function(results) {
		var json_results = JSON.stringify(results);
		console.log("Here it is!:" + json_results);
	}).catch(function(e) {
		console.log("Well damn:" + e);
	});
};

var albums = function() {
	var query = {};
	MediaQuery.albums(query).then(function(results) {
		var json_results = JSON.stringify(results);
		console.log("Here it is!:" + json_results);
	}).catch(function(e) {
		console.log("Well damn:" + e);
	});
};

module.exports = {
	tracks: tracks,
	artists: artists,
	albums: albums
};
