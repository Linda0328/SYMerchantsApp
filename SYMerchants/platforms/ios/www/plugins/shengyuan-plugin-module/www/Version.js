cordova.define("shengyuan-plugin-module.Version", function(require, exports, module) {
	var exec = require('cordova/exec');
	var platform = require('cordova/platform');

	module.exports = {
		getInfo : function(completeCallback) {
			exec(completeCallback, null, "SYVersionPlugin", "getInfo", []);
		},
		setToken : function(token, completeCallback) {
			exec(completeCallback, null, "SYVersionPlugin", "setToken", [ token ]);
		},
		setNeedPush : function(isNeed, completeCallback) {
			exec(completeCallback, null, "SYVersionPlugin", "setNeedPush", [ isNeed ]);
		}
	};
});

//cordova.exec() 参数：第一个function()参数为成功回调方法
//
//第二个function()参数为失败回调方法
//
//第三个"Test"参数为文件名
//
//第四个"test"参数为方法名
//
//第五个为数组参数，用来向OC传递数据，传递过去即为command.arguments


