var Observable = require("FuseJS/Observable");
var MediaQuery = require("FuseJS/MediaQuery");

var doonIt = false;

var foo = function() {
	MediaQuery.music.all(function(results) {
        console.log("Here it is!:" + results);
    }).catch(function(e) {
        console.log("Well damn:" + e);
    });
};

var bar = function() {
	MediaQuery.artists.all(function(results) {
        console.log("Here it is!:" + results);
    }).catch(function(e) {
        console.log("Well damn:" + e);
    });
};

var baz = function() {
	MediaQuery.artists("SPLEN").tracks(function(results) {
        console.log("Here it is!:" + results);
    }).catch(function(e) {
        console.log("Well damn:" + e);
    });
};

module.exports = {
	foo: foo,
	bar: bar,
	baz: baz
};
