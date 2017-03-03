//Sy.ns('app.utils');
//(function(utils) {
//	//判断obj是否为json对象
//	function isJson(obj) {
// var isjson = typeof (obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;
// return isjson;
//	}
//	
// utils.strToJson = function(str) {
//// if (!isJson(str)) {
//// return jQuery.parseJSON(str);
//// }
// return str;
//};
//})(app.utils);
Sy.ns('app.utils');
(function(utils) {
	utils.strToJson = function(str) {
 return eval('(' + str + ')');
	};
 })(app.utils);
