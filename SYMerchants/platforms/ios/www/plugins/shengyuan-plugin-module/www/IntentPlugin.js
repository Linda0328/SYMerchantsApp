cordova.define("shengyuan-plugin-module.IntentPlugin", function(require, exports, module) {

	var exec = require('cordova/exec');
	var platform = require('cordova/platform');

	module.exports = {
		open : function(url, completeCallback) {
			exec(completeCallback, null, "SYIntentPlugin", "open", [ url ]);
		},
		start : function(url, finish, titleBar, bottomBar, completeCallback) {
			var _finish = (finish || false);
			var _titleBar = (titleBar || "");
			var _bottomBar = (bottomBar || "");
			exec(completeCallback, null, "SYIntentPlugin", "start", [ url, _finish, _titleBar, _bottomBar ]);
		}
	};
});
