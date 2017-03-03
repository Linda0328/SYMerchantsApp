cordova.define("shengyuan-plugin-module.ResultPlugin", function(require, exports, module) {
	var exec = require('cordova/exec');
	var platform = require('cordova/platform');

	module.exports = {
		reload : function() {
			exec(null, null, "SYResultPlugin", "reload", []);
		},
		finish : function() {
			exec(null, null, "SYResultPlugin", "finish", []);
		},
		exec : function(func, data) {
			var _data = (data || {});
			exec(null, null, "SYResultPlugin", "exec", [ func, _data ]);
		}
	};
});
