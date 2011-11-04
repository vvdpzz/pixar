ce6.ajaxJsonGet = function(url, data, callback, errorCallback) {
	errorCallback = errorCallback || ce6.jsonErrorCallback;
	ce6.ajaxCall(url, data, callback, errorCallback, {
		dataType: 'json',
		type: 'GET'
	});
}

ce6.ajaxCall = function(url, data, callback, errorCallback, options) {
	data = data || {};
	options = options || {};
	var params = {
		url : url,
		dataType : options.dataType || 'json',
		data : data,
		type : options.type || 'POST',
		cache: false
	};

	if (callback)
		params.success = callback;
	if (errorCallback)
		params.error = errorCallback;	

	$.ajax(params);
};

ce6.ajaxJsonPost = function(url, data, callback, errorCallback) {
	data = data || '';
	if (typeof(data) != 'string') {
		data = $.param(data);
	} 
  // data = data ? (data + '&' + xsrfTokenParam) : xsrfTokenParam;
	errorCallback = errorCallback || ce6.jsonErrorCallback;
	ce6.ajaxCall(url, data, callback, errorCallback, {
		dataType: 'json',
		type: 'POST'
	});
}

ce6.ajaxJson = ce6.ajaxJsonPost;

(function (a) {
    a.fn.ellipsis = function (b) {
        b = b || {};
        var e = b.ellipsisHtml || "...",
            h = document.documentElement.style;
        if (b.ellipsisHtml || b.force || !("textOverflow" in h || "OTextOverflow" in h)) return a(this).each(function () {
            var f = a(this);
            if (!f.data("ellipsisExecuted")) {
                f.data("ellipsisExecuted", true);
                b.forceRefreshHtml && f.data("originalText", null);
                if (f.css("overflow") == "hidden") {
                    var g = f.hasClass("truncate");
                    f.data("originalText") && f.html(f.data("originalText"));
                    var m = f.html(),
                        p = f.hasClass("multiline"),
                        t = parseInt(f.css("max-width")) > 0 ? parseInt(f.css("max-width")) : f.width(),
                        o = parseInt(f.css("max-height")) > 0 ? parseInt(f.css("max-height")) : f.height(),
                        w = function () {
                            return x.height() > o
                        },
                        c = function () {
                            return x.width() > t
                        };
                    w = p ? w : c;
                    var x = a(this.cloneNode(true)).hide().css({
                        position: "absolute",
                        width: p ? t : "auto",
                        height: p ? "auto" : o,
                        overflow: "visible",
                        "max-width": "none",
                        "max-height": "none"
                    });
                    f.after(x);
                    p = function (l) {
                        l = m.substr(0, l);
                        if (g) l = l.substr(0, l.lastIndexOf(" "));
                        x.html(l + e)
                    };
                    if (m.length > 0 && w()) {
                        c = 0;
                        for (var D = m.length; c < D - 1;) {
                            var k = parseInt((c + D) / 2);
                            p(k);
                            if (w()) D = k;
                            else c = k
                        }
                        p(c)
                    }
                    f.html(x.html());
                    f.data("originalText", m);
                    x.remove();
                    if (b.enableUpdating == true) {
                        var j = f.width();
                        f.one("resize", function () {
                            if (f.width() != j) {
                                f.data("ellipsisExecuted", false);
                                f.html(m);
                                f.ellipsis(b)
                            }
                        })
                    }
                }
            }
        })
    }
})(jQuery);

ce6.site = {
	url : function(method, params) {
		params = params || {};
		url_args = $.param(params);
		return '/' + method + (url_args?'?'+url_args:'');
    },
	redirect : function(method, params) {
		if (method.indexOf('http://')==0)
			window.location.href = method;
		else
			window.location.href = this.url(method, params);
    }
};

(function (a) {
    function b(f) {
        var g = {},
            m = /^jQuery\d+$/;
        a.each(f.attributes, function (p, t) {
            if (t.specified && !m.test(t.name)) g[t.name] = t.value
        });
        return g
    }
    function e() {
        var f = a(this);
        if (f.val() === f.attr("placeholder") && f.hasClass("placeholder")) f.data("placeholder-password") ? f.hide().next().show().focus() : f.val("").removeClass("placeholder")
    }
    function h() {
        var f, g = a(this),
            m = g,
            p = g.data("placeholder-init");
        if (g.val() === "" || !p && g.val() === g.attr("placeholder")) {
            if (g.is(":password")) {
                if (!g.data("placeholder-textinput")) {
                    try {
                        f = g.clone().attr({
                            type: "text"
                        })
                    } catch (t) {
                        f = a("<input>").attr(a.extend(b(g[0]), {
                            type: "text"
                        }))
                    }
                    f.removeAttr("id").removeAttr("name").data("placeholder-password", true).bind("focus.placeholder", e);
                    g.data("placeholder-textinput", f).before(f)
                }
                g = g.hide().prev().show()
            }
            g.addClass("placeholder").val(g.attr("placeholder"))
        } else g.removeClass("placeholder");
        p || m.data("placeholder-init", true)
    }
    a.fn.placeholder = function () {
        return this.filter(":input[placeholder]").bind("focus.placeholder", e).bind("blur.placeholder", h).trigger("blur.placeholder").end()
    };
    a(function () {
        a("form").bind("submit.placeholder", function () {
            var f = a(".placeholder", this).each(e);
            setTimeout(function () {
                f.each(h)
            }, 10)
        })
    });
    a(window).bind("unload.placeholder", function () {
        a(".placeholder").val("")
    })
})(jQuery);

(function (a) {
    var b = {
        button: null,
        menu: null
    },
        e = function (f, g, m) {
            f.click(function (p) {
                if (b.menu != g) {
                    h();
                    f.removeClass("inactive-menu").addClass("active-menu");
                    g.show();
                    var t = g.data("onMenuShow");
                    t && t(g);
                    b.button = f;
                    b.menu = g
                } else h();
                p.stopPropagation()
            });
            m = m || {};
            m.onMenuShow && g.data("onMenuShow", m.onMenuShow);
            m.onMenuHide && g.data("onMenuHide", m.onMenuHide)
        },
        h = function () {
            if (b.button) {
                b.button.removeClass("active-menu").addClass("inactive-menu");
                b.menu.hide();
                var f = b.menu.data("onMenuHide");
                f && f(b.menu)
            }
            b.button = b.menu = null
        };
    a(document).click(h);
    a.fn.extend({
        toggleMenu: function (f, g) {
            e(a(this), f, g);
            return this
        }
    })
})(jQuery);