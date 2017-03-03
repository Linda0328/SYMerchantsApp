Sy = {
    version : '1.0'
};
Sy.ns = function() {
    var a = arguments, o = null, i, j, d, rt;
    for (i = 0; i < a.length; ++i) {
        d = a[i].split(".");
        rt = d[0];
        eval('if (typeof ' + rt + ' == "undefined"){' + rt + ' = {};}; o = ' + rt + ';');
        for (j = 1; j < d.length; ++j) {
            o[d[j]] = o[d[j]] || {};
            o = o[d[j]];
        }
    }
};

Sy.ns('app.error');
(function(error) {
	var error_ftl = '<div class="line-hr"></div><div class="error"><p class="error-img"><img src="img/eror-tis.png"></p><p class="error-txt"><span class="error-txt-s">出错了，<%=msg%>，点击重试。</span></p></div>';
 
	error.show = function(msg, func) {
 var _msg = (msg || '');
 var render = template.compile(error_ftl);
 var error_html = render({
                         msg : _msg
                         });
 $("body").html(error_html);
 if (func && typeof func == 'function') {
 $("body").click(func);
 } else {
 $("body").click(function() {
                 location.reload();
                 });
 }
	};
 })(app.error);

jQuery.cachedScript = function(url, callback) {
    $.ajax({
           type : 'GET',
           url : url,
           success : callback,
           error : function() {
           app.error.show('资源文件加载异常');
           },
           dataType : 'script',
           ifModified : true,
           cache : true
           });
};

Sy.ns('app.version');
Sy.ns('app.request');
(function(request) {
	request.initHead = function() {
 // load remote css
 var cssref = document.createElement('link');
 cssref.setAttribute("rel", "stylesheet");
 cssref.setAttribute("type", "text/css");
 cssref.setAttribute("href", app.version.remoteUrl + "/app_resources/style/base.css?v=" + app.version.pageVersion);
 document.getElementsByTagName("head")[0].appendChild(cssref);
 
 $.cachedScript(app.version.remoteUrl + "/app_resources/js/common.js?v=" + app.version.pageVersion, function() {
                // load remote page js
                var req = {};
                
                window.location.search.substr(1).replace(/(\w+)=([^;]+)/ig, function(a, b, c) {
                                                         req[b] = decodeURI(c);
                                                         });
                
                // check url has package
                var filePath = "";
                var packageName = "";
                if (req['pg']) {
                filePath = req['pg'] + "/";
                packageName = req['pg'] + ".";
                }
                $.cachedScript(app.version.remoteUrl + "/app_resources/js/" + filePath + req['act'] + ".js?v=" + app.version.pageVersion, function() {
                               eval('app.page.' + packageName + req['act'] + '.init(req)');
                               });
                });
	};
 
	request.loadResource = function() {
 syapp.version.getInfo(function(info) {
                       app.version = info;
                       request.initHead();
                       });
	};
 })(app.request);

document.addEventListener('deviceready', app.request.loadResource, false);
