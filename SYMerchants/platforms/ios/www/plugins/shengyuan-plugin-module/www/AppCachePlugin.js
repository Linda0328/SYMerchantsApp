cordova.define("shengyuan-plugin-module.AppCachePlugin", function(require, exports, module) {
               
               var exec = require('cordova/exec');
               var platform = require('cordova/platform');
               
               module.exports = {
               cleanCache : function(completeCallback) {
               exec(completeCallback, null, "SYAppCachePlugin", "cleanCache", []);
               }
               };
});
