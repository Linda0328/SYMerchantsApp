cordova.define("shengyuan-plugin-module.EventPlugin", function(require, exports, module) {

	var exec = require('cordova/exec');
	var platform = require('cordova/platform');
	var channel = require('cordova/channel');

	channel.onCordovaReady.subscribe(function() {
		exec(function(msg) {
			if (msg != '') {
				eval(msg);
			}
		}, null, "SYEventPlugin", "listen", []);
	});

	module.exports = {
		bind : function(btnEvent, completeCallback) {
			exec(completeCallback, null, "SYEventPlugin", "bind", [ btnEvent ]);
		}
	};
});
