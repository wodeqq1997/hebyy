/* KindEditor 4.0.5 (2012-01-15), Copyright (C) kindsoft.net, Licence: http://www.kindsoft.net/license.php */
(function (B, n) {
    function da(a) {
        if (!a)return!1;
        return Object.prototype.toString.call(a) === "[object Array]"
    }

    function Za(a) {
        if (!a)return!1;
        return Object.prototype.toString.call(a) === "[object Function]"
    }

    function M(a, b) {
        for (var c = 0, d = b.length; c < d; c++)if (a === b[c])return c;
        return-1
    }

    function l(a, b) {
        if (da(a))for (var c = 0, d = a.length; c < d; c++) {
            if (b.call(a[c], c, a[c]) === !1)break
        } else for (c in a)if (a.hasOwnProperty(c) && b.call(a[c], c, a[c]) === !1)break
    }

    function C(a) {
        return a.replace(/(?:^[ \t\n\r]+)|(?:[ \t\n\r]+$)/g,
            "")
    }

    function ma(a, b, c) {
        c = c === n ? "," : c;
        return(c + b + c).indexOf(c + a + c) >= 0
    }

    function s(a) {
        return a && /^\d+$/.test(a) ? a + "px" : a
    }

    function t(a) {
        var b;
        return a && (b = /(\d+)/.exec(a)) ? parseInt(b[1], 10) : 0
    }

    function D(a) {
        return a.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;")
    }

    function $a(a) {
        return a.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/&amp;/g, "&")
    }

    function ea(a) {
        var b = a.split("-"), a = "";
        l(b, function (b, d) {
            a += b > 0 ? d.charAt(0).toUpperCase() + d.substr(1) :
                d
        });
        return a
    }

    function na(a) {
        function b(a) {
            a = parseInt(a, 10).toString(16).toUpperCase();
            return a.length > 1 ? a : "0" + a
        }

        return a.replace(/rgb\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/ig, function (a, d, e, f) {
            return"#" + b(d) + b(e) + b(f)
        })
    }

    function u(a, b) {
        var b = b === n ? "," : b, c = {}, d = da(a) ? a : a.split(b), e;
        l(d, function (a, b) {
            if (e = /^(\d+)\.\.(\d+)$/.exec(b))for (var d = parseInt(e[1], 10); d <= parseInt(e[2], 10); d++)c[d.toString()] = !0; else c[b] = !0
        });
        return c
    }

    function Da(a, b) {
        return Array.prototype.slice.call(a, b || 0)
    }

    function k(a, b) {
        return a === n ? b : a
    }

    function E(a, b, c) {
        c || (c = b, b = null);
        var d;
        if (b) {
            var e = function () {
            };
            e.prototype = b.prototype;
            d = new e;
            l(c, function (a, b) {
                d[a] = b
            })
        } else d = c;
        d.constructor = a;
        a.prototype = d;
        a.parent = b ? b.prototype : null
    }

    function ab(a) {
        var b;
        if (b = /\{[\s\S]*\}|\[[\s\S]*\]/.exec(a))a = b[0];
        b = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        b.lastIndex = 0;
        b.test(a) && (a = a.replace(b, function (a) {
            return"\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4)
        }));
        if (/^[\],:{}\s]*$/.test(a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, "")))return eval("(" + a + ")");
        throw"JSON parse error";
    }

    function Mb(a, b, c) {
        a.addEventListener ? a.addEventListener(b, c, bb) : a.attachEvent && a.attachEvent("on" + b, c)
    }

    function oa(a, b, c) {
        a.removeEventListener ? a.removeEventListener(b, c, bb) : a.detachEvent && a.detachEvent("on" + b, c)
    }

    function cb(a, b) {
        this.init(a, b)
    }

    function db(a) {
        try {
            delete a[V]
        } catch (b) {
            a.removeAttribute &&
            a.removeAttribute(V)
        }
    }

    function W(a, b, c) {
        if (b.indexOf(",") >= 0)l(b.split(","), function () {
            W(a, this, c)
        }); else {
            var d = a[V] || null;
            d || (a[V] = ++eb, d = eb);
            v[d] === n && (v[d] = {});
            var e = v[d][b];
            e && e.length > 0 ? oa(a, b, e[0]) : (v[d][b] = [], v[d].el = a);
            e = v[d][b];
            e.length === 0 && (e[0] = function (b) {
                var c = b ? new cb(a, b) : n;
                l(e, function (b, d) {
                    b > 0 && d && d.call(a, c)
                })
            });
            M(c, e) < 0 && e.push(c);
            Mb(a, b, e[0])
        }
    }

    function fa(a, b, c) {
        if (b && b.indexOf(",") >= 0)l(b.split(","), function () {
            fa(a, this, c)
        }); else {
            var d = a[V] || null;
            if (d)if (b === n)d in v && (l(v[d],
                function (b, c) {
                    b != "el" && c.length > 0 && oa(a, b, c[0])
                }), delete v[d], db(a)); else if (v[d]) {
                var e = v[d][b];
                if (e && e.length > 0) {
                    c === n ? (oa(a, b, e[0]), delete v[d][b]) : (l(e, function (a, b) {
                        a > 0 && b === c && e.splice(a, 1)
                    }), e.length == 1 && (oa(a, b, e[0]), delete v[d][b]));
                    var f = 0;
                    l(v[d], function () {
                        f++
                    });
                    f < 2 && (delete v[d], db(a))
                }
            }
        }
    }

    function fb(a, b) {
        if (b.indexOf(",") >= 0)l(b.split(","), function () {
            fb(a, this)
        }); else {
            var c = a[V] || null;
            if (c) {
                var d = v[c][b];
                if (v[c] && d && d.length > 0)d[0]()
            }
        }
    }

    function Ea(a, b, c) {
        b = /^\d{2,}$/.test(b) ? b : b.toUpperCase().charCodeAt(0);
        W(a, "keydown", function (d) {
            d.ctrlKey && d.which == b && !d.shiftKey && !d.altKey && (c.call(a), d.stop())
        })
    }

    function ga(a) {
        for (var b = {}, c = /\s*([\w\-]+)\s*:([^;]*)(;|$)/g, d; d = c.exec(a);) {
            var e = C(d[1].toLowerCase());
            d = C(na(d[2]));
            b[e] = d
        }
        return b
    }

    function J(a) {
        for (var b = {}, c = /\s+(?:([\w\-:]+)|(?:([\w\-:]+)=([^\s"'<>]+))|(?:([\w\-:"]+)="([^"]*)")|(?:([\w\-:"]+)='([^']*)'))(?=(?:\s|\/|>)+)/g, d; d = c.exec(a);) {
            var e = (d[1] || d[2] || d[4] || d[6]).toLowerCase();
            b[e] = (d[2] ? d[3] : d[4] ? d[5] : d[7]) || ""
        }
        return b
    }

    function Nb(a, b) {
        return a =
            /\s+class\s*=/.test(a) ? a.replace(/(\s+class=["']?)([^"']*)(["']?[\s>])/, function (a, d, e, f) {
                return(" " + e + " ").indexOf(" " + b + " ") < 0 ? e === "" ? d + b + f : d + e + " " + b + f : a
            }) : a.substr(0, a.length - 1) + ' class="' + b + '">'
    }

    function Ob(a) {
        var b = "";
        l(ga(a), function (a, d) {
            b += a + ":" + d + ";"
        });
        return b
    }

    function pa(a, b, c, d) {
        function e(a) {
            for (var a = a.split("/"), b = [], c = 0, d = a.length; c < d; c++) {
                var e = a[c];
                e == ".." ? b.length > 0 && b.pop() : e !== "" && e != "." && b.push(e)
            }
            return"/" + b.join("/")
        }

        function f(b, c) {
            if (a.substr(0, b.length) === b) {
                for (var e = [],
                         g = 0; g < c; g++)e.push("..");
                g = ".";
                e.length > 0 && (g += "/" + e.join("/"));
                d == "/" && (g += "/");
                return g + a.substr(b.length)
            } else if (h = /^(.*)\//.exec(b))return f(h[1], ++c)
        }

        b = k(b, "").toLowerCase();
        if (M(b, ["absolute", "relative", "domain"]) < 0)return a;
        c = c || location.protocol + "//" + location.host;
        if (d === n)var g = location.pathname.match(/^(\/.*)\//), d = g ? g[1] : "";
        var h;
        if (h = /^(\w+:\/\/[^\/]*)/.exec(a)) {
            if (h[1] !== c)return a
        } else if (/^\w+:/.test(a))return a;
        /^\//.test(a) ? a = c + e(a.substr(1)) : /^\w+:\/\//.test(a) || (a = c + e(d + "/" + a));
        b === "relative" ? a = f(c + d, 0).substr(2) : b === "absolute" && a.substr(0, c.length) === c && (a = a.substr(c.length));
        return a
    }

    function R(a, b, c, d, e) {
        var c = c || "", d = k(d, !1), e = k(e, "\t"), f = "xx-small,x-small,small,medium,large,x-large,xx-large".split(","), a = a.replace(/(<(?:pre|pre\s[^>]*)>)([\s\S]*?)(<\/pre>)/ig, function (a, b, c, d) {
                return b + c.replace(/<(?:br|br\s[^>]*)>/ig, "\n") + d
            }), a = a.replace(/<(?:br|br\s[^>]*)\s*\/?>\s*<\/p>/ig, "</p>"), a = a.replace(/(<(?:p|p\s[^>]*)>)\s*(<\/p>)/ig, "$1<br />$2"), a = a.replace(/\u200B/g, ""),
            g = {};
        b && (l(b, function (a, b) {
            for (var c = a.split(","), d = 0, e = c.length; d < e; d++)g[c[d]] = u(b)
        }), g.script || (a = a.replace(/(<(?:script|script\s[^>]*)>)([\s\S]*?)(<\/script>)/ig, "")), g.style || (a = a.replace(/(<(?:style|style\s[^>]*)>)([\s\S]*?)(<\/style>)/ig, "")));
        var h = [], a = a.replace(/(\s*)<(\/)?([\w\-:]+)((?:\s+|(?:\s+[\w\-:]+)|(?:\s+[\w\-:]+=[^\s"'<>]+)|(?:\s+[\w\-:"]+="[^"]*")|(?:\s+[\w\-:"]+='[^']*'))*)(\/)?>(\s*)/g, function (a, m, o, A, K, r, q) {
            var m = m || "", o = o || "", w = A.toLowerCase(), n = K || "", A = r ? " " + r : "", q = q || "";
            if (b && !g[w])return"";
            A === "" && gb[w] && (A = " /");
            hb[w] && (m && (m = " "), q && (q = " "));
            Fa[w] && (o ? q = "\n" : m = "\n");
            d && w == "br" && (q = "\n");
            if (ib[w] && !Fa[w])if (d) {
                o && h.length > 0 && h[h.length - 1] === w ? h.pop() : h.push(w);
                q = m = "\n";
                K = 0;
                for (r = o ? h.length : h.length - 1; K < r; K++)m += e, o || (q += e);
                A ? h.pop() : o || (q += e)
            } else m = q = "";
            if (n !== "") {
                var k = J(a);
                if (w === "font") {
                    var p = {}, G = "";
                    l(k, function (a, b) {
                        if (a === "color")p.color = b, delete k[a];
                        a === "size" && (p["font-size"] = f[parseInt(b, 10) - 1] || "", delete k[a]);
                        a === "face" && (p["font-family"] = b, delete k[a]);
                        a === "style" && (G = b)
                    });
                    G && !/;$/.test(G) && (G += ";");
                    l(p, function (a, b) {
                        b !== "" && (/\s/.test(b) && (b = "'" + b + "'"), G += a + ":" + b + ";")
                    });
                    k.style = G
                }
                l(k, function (a, d) {
                    Pb[a] && (k[a] = a);
                    M(a, ["src", "href"]) >= 0 && (k[a] = pa(d, c));
                    (b && a !== "style" && !g[w]["*"] && !g[w][a] || w === "body" && a === "contenteditable" || /^kindeditor_\d+$/.test(a)) && delete k[a];
                    if (a === "style" && d !== "") {
                        var e = ga(d);
                        l(e, function (a) {
                            b && !g[w].style && !g[w]["." + a] && delete e[a]
                        });
                        var f = "";
                        l(e, function (a, b) {
                            f += a + ":" + b + ";"
                        });
                        k.style = f
                    }
                });
                n = "";
                l(k, function (a, b) {
                    a === "style" &&
                        b === "" || (b = b.replace(/"/g, "&quot;"), n += " " + a + '="' + b + '"')
                })
            }
            w === "font" && (w = "span");
            return m + "<" + o + w + n + A + ">" + q
        }), a = a.replace(/(<(?:pre|pre\s[^>]*)>)([\s\S]*?)(<\/pre>)/ig, function (a, b, c, d) {
            return b + c.replace(/\n/g, '<span id="__kindeditor_pre_newline__">\n') + d
        }), a = a.replace(/\n\s*\n/g, "\n"), a = a.replace(/<span id="__kindeditor_pre_newline__">\n/g, "\n");
        return C(a)
    }

    function jb(a, b) {
        a = a.replace(/<meta[\s\S]*?>/ig, "").replace(/<![\s\S]*?>/ig, "").replace(/<style[^>]*>[\s\S]*?<\/style>/ig, "").replace(/<script[^>]*>[\s\S]*?<\/script>/ig,
            "").replace(/<w:[^>]+>[\s\S]*?<\/w:[^>]+>/ig, "").replace(/<o:[^>]+>[\s\S]*?<\/o:[^>]+>/ig, "").replace(/<xml>[\s\S]*?<\/xml>/ig, "").replace(/<(?:table|td)[^>]*>/ig, function (a) {
                return a.replace(/border-bottom:([#\w\s]+)/ig, "border:$1")
            });
        return R(a, b)
    }

    function kb(a) {
        if (/\.(rm|rmvb)(\?|$)/i.test(a))return"audio/x-pn-realaudio-plugin";
        if (/\.(swf|flv)(\?|$)/i.test(a))return"application/x-shockwave-flash";
        return"video/x-ms-asf-plugin"
    }

    function lb(a) {
        return J(unescape(a))
    }

    function Ga(a) {
        var b = "<embed ";
        l(a, function (a, d) {
            b += a + '="' + d + '" '
        });
        b += "/>";
        return b
    }

    function mb(a, b) {
        var c = b.width, d = b.height, e = b.type || kb(b.src), f = Ga(b), g = "";
        c > 0 && (g += "width:" + c + "px;");
        d > 0 && (g += "height:" + d + "px;");
        c = /realaudio/i.test(e) ? "ke-rm" : /flash/i.test(e) ? "ke-flash" : "ke-media";
        c = '<img class="' + c + '" src="' + a + '" ';
        g !== "" && (c += 'style="' + g + '" ');
        c += 'data-ke-tag="' + escape(f) + '" alt="" />';
        return c
    }

    function ra(a, b) {
        if (a.nodeType == 9 && b.nodeType != 9)return!0;
        for (; b = b.parentNode;)if (b == a)return!0;
        return!1
    }

    function sa(a, b) {
        var b = b.toLowerCase(),
            c = null;
        if (!Qb && a.nodeName.toLowerCase() != "script") {
            var d = a.ownerDocument.createElement("div");
            d.appendChild(a.cloneNode(!1));
            d = J($a(d.innerHTML));
            b in d && (c = d[b])
        } else try {
            c = a.getAttribute(b, 2)
        } catch (e) {
            c = a.getAttribute(b, 1)
        }
        b === "style" && c !== null && (c = Ob(c));
        return c
    }

    function ta(a, b) {
        function c(a) {
            if (typeof a != "string")return a;
            return a.replace(/([^\w\-])/g, "\\$1")
        }

        function d(a, b) {
            return a === "*" || a.toLowerCase() === c(b.toLowerCase())
        }

        function e(a, b, c) {
            var e = [];
            (a = (c.ownerDocument || c).getElementById(a.replace(/\\/g,
                ""))) && d(b, a.nodeName) && ra(c, a) && e.push(a);
            return e
        }

        function f(a, b, c) {
            var e = c.ownerDocument || c, g = [], j, i, h;
            if (c.getElementsByClassName) {
                e = c.getElementsByClassName(a.replace(/\\/g, ""));
                j = 0;
                for (i = e.length; j < i; j++)h = e[j], d(b, h.nodeName) && g.push(h)
            } else if (e.querySelectorAll) {
                e = e.querySelectorAll((c.nodeName !== "#document" ? c.nodeName + " " : "") + b + "." + a);
                j = 0;
                for (i = e.length; j < i; j++)h = e[j], ra(c, h) && g.push(h)
            } else {
                e = c.getElementsByTagName(b);
                a = " " + a + " ";
                j = 0;
                for (i = e.length; j < i; j++)if (h = e[j], h.nodeType == 1)(b = h.className) &&
                    (" " + b + " ").indexOf(a) > -1 && g.push(h)
            }
            return g
        }

        function g(a, b, d, e) {
            for (var f = [], d = e.getElementsByTagName(d), g = 0, j = d.length; g < j; g++)e = d[g], e.nodeType == 1 && (b === null ? sa(e, a) !== null && f.push(e) : b === c(sa(e, a)) && f.push(e));
            return f
        }

        function h(a, b) {
            var c = [], j, h = (j = /^((?:\\.|[^.#\s\[<>])+)/.exec(a)) ? j[1] : "*";
            if (j = /#((?:[\w\-]|\\.)+)$/.exec(a))c = e(j[1], h, b); else if (j = /\.((?:[\w\-]|\\.)+)$/.exec(a))c = f(j[1], h, b); else if (j = /\[((?:[\w\-]|\\.)+)\]/.exec(a))c = g(j[1].toLowerCase(), null, h, b); else if (j = /\[((?:[\w\-]|\\.)+)\s*=\s*['"]?((?:\\.|[^'"]+)+)['"]?\]/.exec(a)) {
                c =
                    j[1].toLowerCase();
                j = j[2];
                if (c === "id")h = e(j, h, b); else if (c === "class")h = f(j, h, b); else if (c === "name") {
                    c = [];
                    j = (b.ownerDocument || b).getElementsByName(j.replace(/\\/g, ""));
                    for (var m, o = 0, q = j.length; o < q; o++)m = j[o], d(h, m.nodeName) && ra(b, m) && m.getAttributeNode("name") && c.push(m);
                    h = c
                } else h = g(c, j, h, b);
                c = h
            } else {
                h = b.getElementsByTagName(h);
                m = 0;
                for (o = h.length; m < o; m++)j = h[m], j.nodeType == 1 && c.push(j)
            }
            return c
        }

        var j = a.split(",");
        if (j.length > 1) {
            var m = [];
            l(j, function () {
                l(ta(this, b), function () {
                    M(this, m) < 0 && m.push(this)
                })
            });
            return m
        }
        for (var b = b || document, j = [], o, A = /((?:\\.|[^\s>])+|[\s>])/g; o = A.exec(a);)o[1] !== " " && j.push(o[1]);
        o = [];
        if (j.length == 1)return h(j[0], b);
        var A = !1, K, r, q, k, n, p, qa, G, s, t;
        p = 0;
        for (lenth = j.length; p < lenth; p++)if (K = j[p], K === ">")A = !0; else {
            if (p > 0) {
                r = [];
                qa = 0;
                for (s = o.length; qa < s; qa++) {
                    k = o[qa];
                    q = h(K, k);
                    G = 0;
                    for (t = q.length; G < t; G++)n = q[G], A ? k === n.parentNode && r.push(n) : r.push(n)
                }
                o = r
            } else o = h(K, b);
            if (o.length === 0)return[]
        }
        return o
    }

    function X(a) {
        if (!a)return document;
        return a.ownerDocument || a.document || a
    }

    function S(a) {
        if (!a)return B;
        a = X(a);
        return a.parentWindow || a.defaultView
    }

    function Rb(a, b) {
        if (a.nodeType == 1) {
            var c = X(a);
            try {
                a.innerHTML = '<img id="__kindeditor_temp_tag__" width="0" height="0" style="display:none;" />' + b;
                var d = c.getElementById("__kindeditor_temp_tag__");
                d.parentNode.removeChild(d)
            } catch (e) {
                f(a).empty(), f("@" + b, c).each(function () {
                    a.appendChild(this)
                })
            }
        }
    }

    function Ha(a, b, c) {
        p && F < 8 && b.toLowerCase() == "class" && (b = "className");
        a.setAttribute(b, "" + c)
    }

    function Ia(a) {
        if (!a || !a.nodeName)return"";
        return a.nodeName.toLowerCase()
    }

    function Sb(a, b) {
        var c = S(a), d = ea(b), e = "";
        c.getComputedStyle ? (c = c.getComputedStyle(a, null), e = c[d] || c.getPropertyValue(b) || a.style[d]) : a.currentStyle && (e = a.currentStyle[d] || a.style[d]);
        return e
    }

    function H(a) {
        a = a || document;
        return T ? a.body : a.documentElement
    }

    function Y(a) {
        var a = a || document, b;
        p || Ja ? (b = H(a).scrollLeft, a = H(a).scrollTop) : (b = S(a).scrollX, a = S(a).scrollY);
        return{x:b, y:a}
    }

    function I(a) {
        this.init(a)
    }

    function nb(a) {
        a.collapsed = a.startContainer === a.endContainer && a.startOffset === a.endOffset;
        return a
    }

    function Ka(a, b, c) {
        function d(d, e, f) {
            var g = d.nodeValue.length, j;
            b && (j = d.cloneNode(!0), j = e > 0 ? j.splitText(e) : j, f < g && j.splitText(f - e));
            if (c) {
                var i = d;
                e > 0 && (i = d.splitText(e), a.setStart(d, e));
                f < g && (d = i.splitText(f - e), a.setEnd(d, 0));
                h.push(i)
            }
            return j
        }

        function e() {
            c && a.up().collapse(!0);
            for (var b = 0, d = h.length; b < d; b++) {
                var e = h[b];
                e.parentNode && e.parentNode.removeChild(e)
            }
        }

        function f(e, q) {
            for (var k = e.firstChild, r; k;) {
                r = (new N(g)).selectNode(k);
                m = r.compareBoundaryPoints(ha, a);
                m >= 0 && o <= 0 && (o = r.compareBoundaryPoints(ia,
                    a));
                o >= 0 && A <= 0 && (A = r.compareBoundaryPoints(Z, a));
                A >= 0 && l <= 0 && (l = r.compareBoundaryPoints(ja, a));
                if (l >= 0)return!1;
                r = k.nextSibling;
                if (m > 0)if (k.nodeType == 1)if (o >= 0 && A <= 0)b && q.appendChild(k.cloneNode(!0)), c && h.push(k); else {
                    var n;
                    b && (n = k.cloneNode(!1), q.appendChild(n));
                    if (f(k, n) === !1)return!1
                } else if (k.nodeType == 3 && (k = k == j.startContainer ? d(k, j.startOffset, k.nodeValue.length) : k == j.endContainer ? d(k, 0, j.endOffset) : d(k, 0, k.nodeValue.length), b))try {
                    q.appendChild(k)
                } catch (p) {
                }
                k = r
            }
        }

        var g = a.doc, h = [], j = a.cloneRange().down(),
            m = -1, o = -1, A = -1, l = -1, r = a.commonAncestor(), q = g.createDocumentFragment();
        if (r.nodeType == 3)return r = d(r, a.startOffset, a.endOffset), b && q.appendChild(r), e(), b ? q : a;
        f(r, q);
        c && a.up().collapse(!0);
        for (var r = 0, k = h.length; r < k; r++) {
            var n = h[r];
            n.parentNode && n.parentNode.removeChild(n)
        }
        return b ? q : a
    }

    function ka(a, b) {
        for (var c = b; c;) {
            var d = f(c);
            if (d.name == "marquee" || d.name == "select")return;
            c = c.parentNode
        }
        try {
            a.moveToElementText(b)
        } catch (e) {
        }
    }

    function ob(a, b) {
        var c = a.parentElement().ownerDocument, d = a.duplicate();
        d.collapse(b);
        var e = d.parentElement(), i = e.childNodes;
        if (i.length === 0)return{node:e.parentNode, offset:f(e).index()};
        var g = c, h = 0, j = -1, m = a.duplicate();
        ka(m, e);
        for (var o = 0, k = i.length; o < k; o++) {
            var l = i[o], j = m.compareEndPoints("StartToStart", d);
            if (j === 0)return{node:l.parentNode, offset:o};
            if (l.nodeType == 1) {
                var r = a.duplicate(), q, n = f(l), p = l;
                n.isControl() && (q = c.createElement("span"), n.after(q), p = q, h += n.text().replace(/\r\n|\n|\r/g, "").length);
                ka(r, p);
                m.setEndPoint("StartToEnd", r);
                j > 0 ? h += r.text.replace(/\r\n|\n|\r/g, "").length :
                    h = 0;
                q && f(q).remove()
            } else l.nodeType == 3 && (m.moveStart("character", l.nodeValue.length), h += l.nodeValue.length);
            j < 0 && (g = l)
        }
        if (j < 0 && g.nodeType == 1)return{node:e, offset:f(e.lastChild).index() + 1};
        if (j > 0)for (; g.nextSibling && g.nodeType == 1;)g = g.nextSibling;
        m = a.duplicate();
        ka(m, e);
        m.setEndPoint("StartToEnd", d);
        h -= m.text.replace(/\r\n|\n|\r/g, "").length;
        if (j > 0 && g.nodeType == 3)for (c = g.previousSibling; c && c.nodeType == 3;)h -= c.nodeValue.length, c = c.previousSibling;
        return{node:g, offset:h}
    }

    function pb(a, b) {
        var c = a.ownerDocument ||
            a, d = c.body.createTextRange();
        if (c == a)return d.collapse(!0), d;
        if (a.nodeType == 1 && a.childNodes.length > 0) {
            var e = a.childNodes, i;
            b === 0 ? (i = e[0], e = !0) : (i = e[b - 1], e = !1);
            if (!i)return d;
            if (f(i).name === "head")return b === 1 && (e = !0), b === 2 && (e = !1), d.collapse(e), d;
            if (i.nodeType == 1) {
                var g = f(i), h;
                g.isControl() && (h = c.createElement("span"), e ? g.before(h) : g.after(h), i = h);
                ka(d, i);
                d.collapse(e);
                h && f(h).remove();
                return d
            }
            a = i;
            b = e ? 0 : i.nodeValue.length
        }
        c = c.createElement("span");
        f(a).before(c);
        ka(d, c);
        d.moveStart("character", b);
        f(c).remove();
        return d
    }

    function qb(a) {
        function b(a) {
            if (f(a.node).name == "tr")a.node = a.node.cells[a.offset], a.offset = 0
        }

        var c;
        if (p) {
            if (a.item)return c = X(a.item(0)), c = new N(c), c.selectNode(a.item(0)), c;
            c = a.parentElement().ownerDocument;
            var d = ob(a, !0), a = ob(a, !1);
            b(d);
            b(a);
            c = new N(c);
            c.setStart(d.node, d.offset);
            c.setEnd(a.node, a.offset);
            return c
        }
        d = a.startContainer;
        c = d.ownerDocument || d;
        c = new N(c);
        c.setStart(d, a.startOffset);
        c.setEnd(a.endContainer, a.endOffset);
        return c
    }

    function N(a) {
        this.init(a)
    }

    function La(a) {
        if (!a.nodeName)return a.constructor ===
            N ? a : qb(a);
        return new N(a)
    }

    function O(a, b, c) {
        try {
            a.execCommand(b, !1, c)
        } catch (d) {
        }
    }

    function rb(a, b) {
        var c = "";
        try {
            c = a.queryCommandValue(b)
        } catch (d) {
        }
        typeof c !== "string" && (c = "");
        return c
    }

    function Ma(a) {
        var b = S(a);
        return a.selection || b.getSelection()
    }

    function sb(a) {
        var b = {}, c, d;
        l(a, function (a, f) {
            c = a.split(",");
            for (var g = 0, h = c.length; g < h; g++)d = c[g], b[d] = f
        });
        return b
    }

    function Na(a, b) {
        return tb(a, b, "*") || tb(a, b)
    }

    function tb(a, b, c) {
        c = c || a.name;
        if (a.type !== 1)return!1;
        b = sb(b);
        if (!b[c])return!1;
        for (var c = b[c].split(","),
                 b = 0, d = c.length; b < d; b++) {
            var e = c[b];
            if (e === "*")return!0;
            var f = /^(\.?)([^=]+)(?:=([^=]*))?$/.exec(e), g = f[1] ? "css" : "attr", e = f[2], f = f[3] || "";
            if (f === "" && a[g](e) !== "")return!0;
            if (f !== "" && a[g](e) === f)return!0
        }
        return!1
    }

    function Oa(a, b) {
        a.type == 1 && (ub(a, b, "*"), ub(a, b))
    }

    function ub(a, b, c) {
        c = c || a.name;
        if (a.type === 1 && (b = sb(b), b[c])) {
            for (var c = b[c].split(","), b = !1, d = 0, e = c.length; d < e; d++) {
                var f = c[d];
                if (f === "*") {
                    b = !0;
                    break
                }
                var g = /^(\.?)([^=]+)(?:=([^=]*))?$/.exec(f), f = g[2];
                g[1] ? (f = ea(f), a[0].style[f] && (a[0].style[f] =
                    "")) : a.removeAttr(f)
            }
            b && a.remove(!0)
        }
    }

    function Pa(a) {
        for (; a.first();)a = a.first();
        return a
    }

    function $(a) {
        return a.type == 1 && a.html().replace(/<[^>]+>/g, "") === ""
    }

    function Tb(a, b, c) {
        l(b, function (b, c) {
            b !== "style" && a.attr(b, c)
        });
        l(c, function (b, c) {
            a.css(b, c)
        })
    }

    function vb(a) {
        for (; a && a.name != "body";) {
            if (Fa[a.name] || a.name == "div" && a.hasClass("ke-script"))return!0;
            a = a.parent()
        }
        return!1
    }

    function ua(a) {
        this.init(a)
    }

    function wb(a) {
        a.nodeName && (a = X(a), a = La(a).selectNodeContents(a.body).collapse(!1));
        return new ua(a)
    }

    function Qa(a) {
        var b = a.moveEl, c = a.moveFn, d = a.clickEl || b, e = a.beforeDrag, i = [document], g = [
            {x:0, y:0}
        ], h = [];
        (a.iframeFix === n || a.iframeFix) && f("iframe").each(function () {
            var a;
            try {
                a = Ra(this), f(a)
            } catch (b) {
                a = null
            }
            a && (i.push(a), g.push(f(this).pos()))
        });
        d.mousedown(function (a) {
            var m = d.get(), o = t(b.css("left")), k = t(b.css("top")), n = b.width(), r = b.height(), q = a.pageX, p = a.pageY, s = !0;
            e && e();
            l(i, function (a, b) {
                function e(b) {
                    if (s) {
                        var f = P(g[a].x + b.pageX - q), j = P(g[a].y + b.pageY - p);
                        c.call(d, o, k, n, r, f, j)
                    }
                    b.stop()
                }

                function j(a) {
                    a.stop()
                }

                function i(a) {
                    s = !1;
                    m.releaseCapture && m.releaseCapture();
                    l(h, function () {
                        f(this.doc).unbind("mousemove", this.move).unbind("mouseup", this.up).unbind("selectstart", this.select)
                    });
                    a.stop()
                }

                f(b).mousemove(e).mouseup(i).bind("selectstart", j);
                h.push({doc:b, move:e, up:i, select:j})
            });
            m.setCapture && m.setCapture();
            a.stop()
        })
    }

    function Q(a) {
        this.init(a)
    }

    function Sa(a) {
        return new Q(a)
    }

    function Ra(a) {
        a = f(a)[0];
        return a.contentDocument || a.contentWindow.document
    }

    function Ub(a, b, c, d) {
        var e = ['<html><head><meta charset="utf-8" /><title>KindEditor</title>',
            "<style>", "html {margin:0;padding:0;}", "body {margin:0;padding:5px;}", 'body, td {font:12px/1.5 "sans serif",tahoma,verdana,helvetica;}', "body, p, div {word-wrap: break-word;}", "p {margin:5px 0;}", "table {border-collapse:collapse;}", "img {border:0;}", "table.ke-zeroborder td {border:1px dotted #AAA;}", "img.ke-flash {", "\tborder:1px solid #AAA;", "\tbackground-image:url(" + a + "common/flash.gif);", "\tbackground-position:center center;", "\tbackground-repeat:no-repeat;", "\twidth:100px;", "\theight:100px;",
            "}", "img.ke-rm {", "\tborder:1px solid #AAA;", "\tbackground-image:url(" + a + "common/rm.gif);", "\tbackground-position:center center;", "\tbackground-repeat:no-repeat;", "\twidth:100px;", "\theight:100px;", "}", "img.ke-media {", "\tborder:1px solid #AAA;", "\tbackground-image:url(" + a + "common/media.gif);", "\tbackground-position:center center;", "\tbackground-repeat:no-repeat;", "\twidth:100px;", "\theight:100px;", "}", "img.ke-anchor {", "\tborder:1px dashed #666;", "\twidth:16px;", "\theight:16px;", "}", ".ke-script {",
            "\tdisplay:none;", "\tfont-size:0;", "\twidth:0;", "\theight:0;", "}", ".ke-pagebreak {", "\tborder:1px dotted #AAA;", "\tfont-size:0;", "\theight:2px;", "}", "</style>"];
        da(c) || (c = [c]);
        l(c, function (a, b) {
            b && e.push('<link href="' + b + '" rel="stylesheet" />')
        });
        d && e.push("<style>" + d + "</style>");
        e.push("</head><body " + (b ? 'class="' + b + '"' : "") + "></body></html>");
        return e.join("\n")
    }

    function aa(a, b) {
        return a.hasVal() ? a.val(b) : a.html(b)
    }

    function va(a) {
        this.init(a)
    }

    function xb(a) {
        return new va(a)
    }

    function yb(a, b) {
        var c =
            this.get(a);
        c && !c.hasClass("ke-disabled") && b(c)
    }

    function Ta(a) {
        this.init(a)
    }

    function zb(a) {
        return new Ta(a)
    }

    function wa(a) {
        this.init(a)
    }

    function Ua(a) {
        return new wa(a)
    }

    function xa(a) {
        this.init(a)
    }

    function Ab(a) {
        return new xa(a)
    }

    function Bb(a) {
        this.init(a)
    }

    function ya(a) {
        this.init(a)
    }

    function Cb(a) {
        return new ya(a)
    }

    function Va(a, b) {
        var c = document.getElementsByTagName("head")[0] || (T ? document.body : document.documentElement), d = document.createElement("script");
        c.appendChild(d);
        d.src = a;
        d.charset = "utf-8";
        d.onload = d.onreadystatechange = function () {
            if (!this.readyState || this.readyState === "loaded")b && b(), d.onload = d.onreadystatechange = null, c.removeChild(d)
        }
    }

    function Wa(a) {
        for (var b = document.getElementsByTagName("head")[0] || (T ? document.body : document.documentElement), c = document.createElement("link"), d = pa(a, "absolute"), e = f('link[rel="stylesheet"]', b), i = 0, g = e.length; i < g; i++)if (pa(e[i].href, "absolute") === d)return;
        b.appendChild(c);
        c.href = a;
        c.rel = "stylesheet"
    }

    function Db(a, b) {
        if (!b)return ba[a];
        ba[a] = b
    }

    function Eb(a) {
        var b,
            c = "core";
        if (b = /^(\w+)\.(\w+)$/.exec(a))c = b[1], a = b[2];
        return{ns:c, key:a}
    }

    function Fb(a, b) {
        b = b === n ? f.options.langType : b;
        if (typeof a === "string") {
            if (!L[b])return"no language";
            var c = a.length - 1;
            if (a.substr(c) === ".")return L[b][a.substr(0, c)];
            c = Eb(a);
            return L[b][c.ns][c.key]
        }
        l(a, function (a, c) {
            var f = Eb(a);
            L[b] || (L[b] = {});
            L[b][f.ns] || (L[b][f.ns] = {});
            L[b][f.ns][f.key] = c
        })
    }

    function za(a, b) {
        if (!a.collapsed) {
            var a = a.cloneRange().up(), c = a.startContainer, d = a.startOffset;
            if (ca || a.isControl())if ((c = f(c.childNodes[d])) &&
                c.name == "img" && b(c))return c
        }
    }

    function Vb() {
        var a = this;
        f(a.edit.doc).contextmenu(function (b) {
            a.menu && a.hideMenu();
            if (a.useContextmenu) {
                if (a._contextmenus.length !== 0) {
                    var c = 0, d = [];
                    for (l(a._contextmenus, function () {
                        if (this.title == "-")d.push(this); else if (this.cond && this.cond() && (d.push(this), this.width && this.width > c))c = this.width
                    }); d.length > 0 && d[0].title == "-";)d.shift();
                    for (; d.length > 0 && d[d.length - 1].title == "-";)d.pop();
                    var e = null;
                    l(d, function (a) {
                        this.title == "-" && e.title == "-" && delete d[a];
                        e = this
                    });
                    if (d.length >
                        0) {
                        b.preventDefault();
                        var i = f(a.edit.iframe).pos(), g = Ua({x:i.x + b.clientX, y:i.y + b.clientY, width:c, css:{visibility:"hidden"}, shadowMode:a.shadowMode});
                        l(d, function () {
                            this.title && g.addItem(this)
                        });
                        var i = H(g.doc), h = g.div.height();
                        b.clientY + h >= i.clientHeight - 100 && g.pos(g.x, t(g.y) - h);
                        g.div.css("visibility", "visible");
                        a.menu = g
                    }
                }
            } else b.preventDefault()
        })
    }

    function Wb() {
        function a(a) {
            for (a = f(a.commonAncestor()); a;) {
                if (a.type == 1 && !a.isStyle())break;
                a = a.parent()
            }
            return a.name
        }

        var b = this, c = b.edit.doc, d = b.newlineTag;
        if (!(p && d !== "br") && (!la || !(F < 3 && d !== "p")) && !Ja) {
            var e = u("h1,h2,h3,h4,h5,h6,pre,li"), i = u("p,h1,h2,h3,h4,h5,h6,pre,li,blockquote");
            f(c).keydown(function (f) {
                if (!(f.which != 13 || f.shiftKey || f.ctrlKey || f.altKey)) {
                    b.cmd.selection();
                    var h = a(b.cmd.range);
                    h == "marquee" || h == "select" || (d === "br" && !e[h] ? (f.preventDefault(), b.insertHtml("<br />")) : i[h] || O(c, "formatblock", "<p>"))
                }
            });
            f(c).keyup(function (e) {
                if (!(e.which != 13 || e.shiftKey || e.ctrlKey || e.altKey) && d != "br")if (b.cmd.selection(), e = a(b.cmd.range), !(e == "marquee" ||
                    e == "select"))if (i[e] || O(c, "formatblock", "<p>"), e = b.cmd.commonAncestor("div")) {
                    for (var h = f("<p></p>"), j = e[0].firstChild; j;) {
                        var m = j.nextSibling;
                        h.append(j);
                        j = m
                    }
                    e.before(h);
                    e.remove();
                    b.cmd.range.selectNodeContents(h[0]);
                    b.cmd.select()
                }
            })
        }
    }

    function Xb() {
        var a = this, b = a.edit.doc;
        f(b).keydown(function (c) {
            if (c.which == 9)if (c.preventDefault(), a.afterTab)a.afterTab.call(a, c); else {
                var c = a.cmd, d = c.range;
                d.shrink();
                d.collapsed && d.startContainer.nodeType == 1 && (d.insertNode(f("@&nbsp;", b)[0]), c.select());
                a.insertHtml("&nbsp;&nbsp;&nbsp;&nbsp;")
            }
        })
    }

    function Yb() {
        var a = this;
        f(a.edit.textarea[0], a.edit.win).focus(
            function (b) {
                a.afterFocus && a.afterFocus.call(a, b)
            }).blur(function (b) {
            a.afterBlur && a.afterBlur.call(a, b)
        })
    }

    function U(a) {
        return C(a.replace(/<span [^>]*id="?__kindeditor_bookmark_\w+_\d+__"?[^>]*><\/span>/ig, ""))
    }

    function Xa(a) {
        return a.replace(/<div[^>]+class="?__kindeditor_paste__"?[^>]*>[\s\S]*?<\/div>/ig, "")
    }

    function Gb(a, b) {
        if (a.length === 0)a.push(b); else {
            var c = a[a.length - 1];
            U(b.html) !== U(c.html) && a.push(b)
        }
    }

    function Hb(a, b) {
        var c =
            this.edit, d = c.doc.body, e, i;
        if (a.length === 0)return this;
        c.designMode ? (e = this.cmd.range, i = e.createBookmark(!0), i.html = d.innerHTML) : i = {html:d.innerHTML};
        Gb(b, i);
        var g = a.pop();
        U(i.html) === U(g.html) && a.length > 0 && (g = a.pop());
        c.designMode ? (c.html(g.html), g.start && (e.moveToBookmark(g), this.select())) : f(d).html(U(g.html));
        return this
    }

    function Aa(a) {
        function b(a, b) {
            Aa.prototype[a] === n && (c[a] = b);
            c.options[a] = b
        }

        var c = this;
        c.options = {};
        l(a, function (c) {
            b(c, a[c])
        });
        l(f.options, function (a, d) {
            c[a] === n && b(a, d)
        });
        b("width",
            k(c.width, c.minWidth));
        b("height", k(c.height, c.minHeight));
        b("width", s(c.width));
        b("height", s(c.height));
        if (Zb && (!$b || F < 534))c.designMode = !1;
        var d = f(c.srcElement || "<textarea/>");
        c.srcElement = d;
        c.initContent = aa(d);
        c.plugin = {};
        c.isCreated = !1;
        c.isLoading = !1;
        c._handlers = {};
        c._contextmenus = [];
        c._undoStack = [];
        c._redoStack = [];
        c._calledPlugins = {};
        c._firstAddBookmark = !0;
        c.menu = c.contextmenu = null;
        c.dialogs = []
    }

    if (!B.KindEditor) {
        if (!B.console)B.console = {};
        if (!console.log)console.log = function () {
        };
        var z = navigator.userAgent.toLowerCase(),
            p = z.indexOf("msie") > -1 && z.indexOf("opera") == -1, la = z.indexOf("gecko") > -1 && z.indexOf("khtml") == -1, ca = z.indexOf("applewebkit") > -1, Ja = z.indexOf("opera") > -1, Zb = z.indexOf("mobile") > -1, $b = /ipad|iphone|ipod/.test(z), T = document.compatMode != "CSS1Compat", F = (z = /(?:msie|firefox|webkit|opera)[\/:\s](\d+)/.exec(z)) ? z[1] : "0", Ba = (new Date).getTime(), P = Math.round, f = {DEBUG:!1, VERSION:"4.0.5 (2012-01-15)", IE:p, GECKO:la, WEBKIT:ca, OPERA:Ja, V:F, TIME:Ba, each:l, isArray:da, isFunction:Za, inArray:M, inString:ma, trim:C, addUnit:s,
                removeUnit:t, escape:D, unescape:$a, toCamel:ea, toHex:na, toMap:u, toArray:Da, undef:k, invalidUrl:function (a) {
                    return!a || /[<>"]/.test(a)
                }, addParam:function (a, b) {
                    return a.indexOf("?") >= 0 ? a + "&" + b : a + "?" + b
                }, extend:E, json:ab}, hb = u("a,abbr,acronym,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,img,input,ins,kbd,label,map,q,s,samp,select,small,span,strike,strong,sub,sup,textarea,tt,u,var"), ib = u("address,applet,blockquote,body,center,dd,dir,div,dl,dt,fieldset,form,frameset,h1,h2,h3,h4,h5,h6,head,hr,html,iframe,ins,isindex,li,map,menu,meta,noframes,noscript,object,ol,p,pre,script,style,table,tbody,td,tfoot,th,thead,title,tr,ul"),
            gb = u("area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed"), Ib = u("b,basefont,big,del,em,font,i,s,small,span,strike,strong,sub,sup,u"), ac = u("img,table,input,textarea,button"), Fa = u("pre,style,script"), Ca = u("html,head,body,td,tr,table,ol,ul,li");
        u("colgroup,dd,dt,li,options,p,td,tfoot,th,thead,tr");
        var Pb = u("checked,compact,declare,defer,disabled,ismap,multiple,nohref,noresize,noshade,nowrap,readonly,selected"), Jb = u("input,button,textarea,select");
        f.basePath = function () {
            for (var a =
                document.getElementsByTagName("script"), b, c = 0, d = a.length; c < d; c++)if (b = a[c].src || "", /kindeditor[\w\-\.]*\.js/.test(b))return b.substring(0, b.lastIndexOf("/") + 1);
            return""
        }();
        f.options = {designMode:!0, fullscreenMode:!1, filterMode:!1, wellFormatMode:!0, shadowMode:!0, loadStyleMode:!0, basePath:f.basePath, themesPath:f.basePath + "themes/", langPath:f.basePath + "lang/", pluginsPath:f.basePath + "plugins/", themeType:"default", langType:"zh_CN", urlType:"", newlineTag:"p", resizeType:2, syncType:"form", pasteType:2, dialogAlignType:"page",
            useContextmenu:!0, bodyClass:"ke-content", indentChar:"\t", cssPath:"", cssData:"", minWidth:650, minHeight:100, minChangeSize:5, items:["source", "|", "undo", "redo", "|", "preview", "print", "template", "cut", "copy", "paste", "plainpaste", "wordpaste", "|", "justifyleft", "justifycenter", "justifyright", "justifyfull", "insertorderedlist", "insertunorderedlist", "indent", "outdent", "subscript", "superscript", "clearhtml", "quickformat", "selectall", "|", "fullscreen", "/", "formatblock", "fontname", "fontsize", "|", "forecolor", "hilitecolor",
                "bold", "italic", "underline", "strikethrough", "lineheight", "removeformat", "|", "image", "flash", "media", "insertfile", "table", "hr", "emoticons", "map", "code", "pagebreak", "anchor", "link", "unlink", "|", "about"], noDisableItems:["source", "fullscreen"], colorTable:[
                ["#E53333", "#E56600", "#FF9900", "#64451D", "#DFC5A4", "#FFE500"],
                ["#009900", "#006600", "#99BB00", "#B8D100", "#60D978", "#00D5FF"],
                ["#337FE5", "#003399", "#4C33E5", "#9933E5", "#CC33E5", "#EE33EE"],
                ["#FFFFFF", "#CCCCCC", "#999999", "#666666", "#333333", "#000000"]
            ],
            fontSizeTable:["9px", "10px", "12px", "14px", "16px", "18px", "24px", "32px"], htmlTags:{font:["color", "size", "face", ".background-color"], span:[".color", ".background-color", ".font-size", ".font-family", ".background", ".font-weight", ".font-style", ".text-decoration", ".vertical-align", ".line-height"], div:["align", ".border", ".margin", ".padding", ".text-align", ".color", ".background-color", ".font-size", ".font-family", ".font-weight", ".background", ".font-style", ".text-decoration", ".vertical-align", ".margin-left"], table:["border",
                "cellspacing", "cellpadding", "width", "height", "align", "bordercolor", ".padding", ".margin", ".border", "bgcolor", ".text-align", ".color", ".background-color", ".font-size", ".font-family", ".font-weight", ".font-style", ".text-decoration", ".background", ".width", ".height", ".border-collapse"], "td,th":["align", "valign", "width", "height", "colspan", "rowspan", "bgcolor", ".text-align", ".color", ".background-color", ".font-size", ".font-family", ".font-weight", ".font-style", ".text-decoration", ".vertical-align", ".background",
                ".border"], a:["href", "target", "name"], embed:["src", "width", "height", "type", "loop", "autostart", "quality", ".width", ".height", "align", "allowscriptaccess"], img:["src", "width", "height", "border", "alt", "title", "align", ".width", ".height", ".border"], "p,ol,ul,li,blockquote,h1,h2,h3,h4,h5,h6":["align", ".text-align", ".color", ".background-color", ".font-size", ".font-family", ".background", ".font-weight", ".font-style", ".text-decoration", ".vertical-align", ".text-indent", ".margin-left"], pre:["class"], hr:["class", ".page-break-after"],
                "br,tbody,tr,strong,b,sub,sup,em,i,u,strike,s,del":[]}, layout:'<div class="container"><div class="toolbar"></div><div class="edit"></div><div class="statusbar"></div></div>'};
        var bb = !1, Kb = u("8,9,13,32,46,48..57,59,61,65..90,106,109..111,188,190..192,219..222"), z = u("33..40"), Ya = {};
        l(Kb, function (a, b) {
            Ya[a] = b
        });
        l(z, function (a, b) {
            Ya[a] = b
        });
        var bc = "altKey,attrChange,attrName,bubbles,button,cancelable,charCode,clientX,clientY,ctrlKey,currentTarget,data,detail,eventPhase,fromElement,handler,keyCode,metaKey,newValue,offsetX,offsetY,originalTarget,pageX,pageY,prevValue,relatedNode,relatedTarget,screenX,screenY,shiftKey,srcElement,target,toElement,view,wheelDelta,which".split(",");
        E(cb, {init:function (a, b) {
            var c = this, d = a.ownerDocument || a.document || a;
            c.event = b;
            l(bc, function (a, d) {
                c[d] = b[d]
            });
            if (!c.target)c.target = c.srcElement || d;
            if (c.target.nodeType === 3)c.target = c.target.parentNode;
            if (!c.relatedTarget && c.fromElement)c.relatedTarget = c.fromElement === c.target ? c.toElement : c.fromElement;
            if (c.pageX == null && c.clientX != null) {
                var e = d.documentElement, d = d.body;
                c.pageX = c.clientX + (e && e.scrollLeft || d && d.scrollLeft || 0) - (e && e.clientLeft || d && d.clientLeft || 0);
                c.pageY = c.clientY + (e && e.scrollTop ||
                    d && d.scrollTop || 0) - (e && e.clientTop || d && d.clientTop || 0)
            }
            if (!c.which && (c.charCode || c.charCode === 0 ? c.charCode : c.keyCode))c.which = c.charCode || c.keyCode;
            if (!c.metaKey && c.ctrlKey)c.metaKey = c.ctrlKey;
            if (!c.which && c.button !== n)c.which = c.button & 1 ? 1 : c.button & 2 ? 3 : c.button & 4 ? 2 : 0;
            switch (c.which) {
                case 186:
                    c.which = 59;
                    break;
                case 187:
                case 107:
                case 43:
                    c.which = 61;
                    break;
                case 189:
                case 45:
                    c.which = 109;
                    break;
                case 42:
                    c.which = 106;
                    break;
                case 47:
                    c.which = 111;
                    break;
                case 78:
                    c.which = 110
            }
            c.which >= 96 && c.which <= 105 && (c.which -= 48)
        },
            preventDefault:function () {
                var a = this.event;
                a.preventDefault && a.preventDefault();
                a.returnValue = !1
            }, stopPropagation:function () {
                var a = this.event;
                a.stopPropagation && a.stopPropagation();
                a.cancelBubble = !0
            }, stop:function () {
                this.preventDefault();
                this.stopPropagation()
            }});
        var V = "kindeditor_" + Ba, eb = 0, v = {};
        p && B.attachEvent("onunload", function () {
            l(v, function (a, b) {
                b.el && fa(b.el)
            })
        });
        f.ctrl = Ea;
        f.ready = function (a) {
            function b() {
                e || (e = !0, a(KindEditor))
            }

            function c() {
                if (!e) {
                    try {
                        document.documentElement.doScroll("left")
                    } catch (a) {
                        setTimeout(c,
                            100);
                        return
                    }
                    b()
                }
            }

            function d() {
                document.readyState === "complete" && b()
            }

            var e = !1;
            document.addEventListener ? W(document, "DOMContentLoaded", b) : document.attachEvent && (W(document, "readystatechange", d), document.documentElement.doScroll && B.frameElement === n && c());
            W(B, "load", b)
        };
        f.formatUrl = pa;
        f.formatHtml = R;
        f.getCssList = ga;
        f.getAttrList = J;
        f.mediaType = kb;
        f.mediaAttrs = lb;
        f.mediaEmbed = Ga;
        f.mediaImg = mb;
        f.clearMsWord = jb;
        z = document.createElement("div");
        z.setAttribute("className", "t");
        var Qb = z.className !== "t";
        f.query =
            function (a, b) {
                var c = ta(a, b);
                return c.length > 0 ? c[0] : null
            };
        f.queryAll = ta;
        E(I, {init:function (a) {
            for (var b = 0, c = a.length; b < c; b++)this[b] = a[b].constructor === I ? a[b][0] : a[b];
            this.length = a.length;
            this.doc = X(this[0]);
            this.name = Ia(this[0]);
            this.type = this.length > 0 ? this[0].nodeType : null;
            this.win = S(this[0]);
            this._data = {}
        }, each:function (a) {
            for (var b = 0; b < this.length; b++)if (a.call(this[b], b, this[b]) === !1)break;
            return this
        }, bind:function (a, b) {
            this.each(function () {
                W(this, a, b)
            });
            return this
        }, unbind:function (a, b) {
            this.each(function () {
                fa(this,
                    a, b)
            });
            return this
        }, fire:function (a) {
            if (this.length < 1)return this;
            fb(this[0], a);
            return this
        }, hasAttr:function (a) {
            if (this.length < 1)return!1;
            return!!sa(this[0], a)
        }, attr:function (a, b) {
            var c = this;
            if (a === n)return J(c.outer());
            if (typeof a === "object")return l(a, function (a, b) {
                c.attr(a, b)
            }), c;
            if (b === n)return b = c.length < 1 ? null : sa(c[0], a), b === null ? "" : b;
            c.each(function () {
                Ha(this, a, b)
            });
            return c
        }, removeAttr:function (a) {
            this.each(function () {
                var b = a;
                p && F < 8 && b.toLowerCase() == "class" && (b = "className");
                Ha(this, b, "");
                this.removeAttribute(b)
            });
            return this
        }, get:function (a) {
            if (this.length < 1)return null;
            return this[a || 0]
        }, hasClass:function (a) {
            if (this.length < 1)return!1;
            return ma(a, this[0].className, " ")
        }, addClass:function (a) {
            this.each(function () {
                if (!ma(a, this.className, " "))this.className = C(this.className + " " + a)
            });
            return this
        }, removeClass:function (a) {
            this.each(function () {
                if (ma(a, this.className, " "))this.className = C(this.className.replace(RegExp("(^|\\s)" + a + "(\\s|$)"), " "))
            });
            return this
        }, html:function (a) {
            if (a === n) {
                if (this.length <
                    1 || this.type != 1)return"";
                return R(this[0].innerHTML)
            }
            this.each(function () {
                Rb(this, a)
            });
            return this
        }, text:function () {
            if (this.length < 1)return"";
            return p ? this[0].innerText : this[0].textContent
        }, hasVal:function () {
            if (this.length < 1)return!1;
            return!!Jb[Ia(this[0])]
        }, val:function (a) {
            if (a === n) {
                if (this.length < 1)return"";
                return this.hasVal() ? this[0].value : this.attr("value")
            } else return this.each(function () {
                Jb[Ia(this)] ? this.value = a : Ha(this, "value", a)
            }), this
        }, css:function (a, b) {
            var c = this;
            if (a === n)return ga(c.attr("style"));
            if (typeof a === "object")return l(a, function (a, b) {
                c.css(a, b)
            }), c;
            if (b === n) {
                if (c.length < 1)return"";
                return c[0].style[ea(a)] || Sb(c[0], a) || ""
            }
            c.each(function () {
                this.style[ea(a)] = b
            });
            return c
        }, width:function (a) {
            if (a === n) {
                if (this.length < 1)return 0;
                return this[0].offsetWidth
            }
            return this.css("width", s(a))
        }, height:function (a) {
            if (a === n) {
                if (this.length < 1)return 0;
                return this[0].offsetHeight
            }
            return this.css("height", s(a))
        }, opacity:function (a) {
            this.each(function () {
                this.style.opacity === n ? this.style.filter = a == 1 ?
                    "" : "alpha(opacity=" + a * 100 + ")" : this.style.opacity = a == 1 ? "" : a
            });
            return this
        }, data:function (a, b) {
            if (b === n)return this._data[a];
            this._data[a] = b;
            return this
        }, pos:function () {
            var a = this[0], b = 0, c = 0;
            if (a)if (a.getBoundingClientRect)a = a.getBoundingClientRect(), c = Y(this.doc), b = a.left + c.x, c = a.top + c.y; else for (; a;)b += a.offsetLeft, c += a.offsetTop, a = a.offsetParent;
            return{x:P(b), y:P(c)}
        }, clone:function (a) {
            if (this.length < 1)return new I([]);
            return new I([this[0].cloneNode(a)])
        }, append:function (a) {
            this.each(function () {
                this.appendChild &&
                this.appendChild(f(a)[0])
            });
            return this
        }, appendTo:function (a) {
            this.each(function () {
                f(a)[0].appendChild(this)
            });
            return this
        }, before:function (a) {
            this.each(function () {
                this.parentNode.insertBefore(f(a)[0], this)
            });
            return this
        }, after:function (a) {
            this.each(function () {
                this.nextSibling ? this.parentNode.insertBefore(f(a)[0], this.nextSibling) : this.parentNode.appendChild(f(a)[0])
            });
            return this
        }, replaceWith:function (a) {
            var b = [];
            this.each(function (c, d) {
                fa(d);
                var e = f(a)[0];
                d.parentNode.replaceChild(e, d);
                b.push(e)
            });
            return f(b)
        }, empty:function () {
            this.each(function (a, b) {
                for (var c = b.firstChild; c;) {
                    if (!b.parentNode)break;
                    var d = c.nextSibling;
                    c.parentNode.removeChild(c);
                    c = d
                }
            });
            return this
        }, remove:function (a) {
            var b = this;
            b.each(function (c, d) {
                if (d.parentNode) {
                    fa(d);
                    if (a)for (var e = d.firstChild; e;) {
                        var f = e.nextSibling;
                        d.parentNode.insertBefore(e, d);
                        e = f
                    }
                    d.parentNode.removeChild(d);
                    delete b[c]
                }
            });
            b.length = 0;
            b._data = {};
            return b
        }, show:function (a) {
            return this.css("display", a === n ? "block" : a)
        }, hide:function () {
            return this.css("display",
                "none")
        }, outer:function () {
            if (this.length < 1)return"";
            var a = this.doc.createElement("div");
            a.appendChild(this[0].cloneNode(!0));
            return R(a.innerHTML)
        }, isSingle:function () {
            return!!gb[this.name]
        }, isInline:function () {
            return!!hb[this.name]
        }, isBlock:function () {
            return!!ib[this.name]
        }, isStyle:function () {
            return!!Ib[this.name]
        }, isControl:function () {
            return!!ac[this.name]
        }, contains:function (a) {
            if (this.length < 1)return!1;
            return ra(this[0], f(a)[0])
        }, parent:function () {
            if (this.length < 1)return null;
            var a = this[0].parentNode;
            return a ? new I([a]) : null
        }, children:function () {
            if (this.length < 1)return[];
            for (var a = [], b = this[0].firstChild; b;)(b.nodeType != 3 || C(b.nodeValue) !== "") && a.push(new I([b])), b = b.nextSibling;
            return a
        }, first:function () {
            var a = this.children();
            return a.length > 0 ? a[0] : null
        }, last:function () {
            var a = this.children();
            return a.length > 0 ? a[a.length - 1] : null
        }, index:function () {
            if (this.length < 1)return-1;
            for (var a = -1, b = this[0]; b;)a++, b = b.previousSibling;
            return a
        }, prev:function () {
            if (this.length < 1)return null;
            var a = this[0].previousSibling;
            return a ? new I([a]) : null
        }, next:function () {
            if (this.length < 1)return null;
            var a = this[0].nextSibling;
            return a ? new I([a]) : null
        }, scan:function (a, b) {
            function c(d) {
                for (d = b ? d.firstChild : d.lastChild; d;) {
                    var e = b ? d.nextSibling : d.previousSibling;
                    if (a(d) === !1)return!1;
                    if (c(d) === !1)return!1;
                    d = e
                }
            }

            if (!(this.length < 1))return b = b === n ? !0 : b, c(this[0]), this
        }});
        l("blur,focus,focusin,focusout,load,resize,scroll,unload,click,dblclick,mousedown,mouseup,mousemove,mouseover,mouseout,mouseenter,mouseleave,change,select,submit,keydown,keypress,keyup,error,contextmenu".split(","),
            function (a, b) {
                I.prototype[b] = function (a) {
                    return a ? this.bind(b, a) : this.fire(b)
                }
            });
        z = f;
        f = function (a, b) {
            function c(a) {
                a[0] || (a = []);
                return new I(a)
            }

            if (!(a === n || a === null)) {
                if (typeof a === "string") {
                    b && (b = f(b)[0]);
                    var d = a.length;
                    a.charAt(0) === "@" && (a = a.substr(1));
                    if (a.length !== d || /<.+>/.test(a)) {
                        var d = (b ? b.ownerDocument || b : document).createElement("div"), e = [];
                        d.innerHTML = '<img id="__kindeditor_temp_tag__" width="0" height="0" style="display:none;" />' + a;
                        for (var i = 0, g = d.childNodes.length; i < g; i++) {
                            var h = d.childNodes[i];
                            h.id != "__kindeditor_temp_tag__" && e.push(h)
                        }
                        return c(e)
                    }
                    return c(ta(a, b))
                }
                if (a && a.constructor === I)return a;
                if (da(a))return c(a);
                return c(Da(arguments))
            }
        };
        l(z, function (a, b) {
            f[a] = b
        });
        B.KindEditor = f;
        var ia = 0, ha = 1, Z = 2, ja = 3, Lb = 0;
        E(N, {init:function (a) {
            this.startContainer = a;
            this.startOffset = 0;
            this.endContainer = a;
            this.endOffset = 0;
            this.collapsed = !0;
            this.doc = a
        }, commonAncestor:function () {
            function a(a) {
                for (var b = []; a;)b.push(a), a = a.parentNode;
                return b
            }

            for (var b = a(this.startContainer), c = a(this.endContainer), d =
                0, e = b.length, f = c.length, g, h; ++d;)if (g = b[e - d], h = c[f - d], !g || !h || g !== h)break;
            return b[e - d + 1]
        }, setStart:function (a, b) {
            var c = this.doc;
            this.startContainer = a;
            this.startOffset = b;
            if (this.endContainer === c)this.endContainer = a, this.endOffset = b;
            return nb(this)
        }, setEnd:function (a, b) {
            var c = this.doc;
            this.endContainer = a;
            this.endOffset = b;
            if (this.startContainer === c)this.startContainer = a, this.startOffset = b;
            return nb(this)
        }, setStartBefore:function (a) {
            return this.setStart(a.parentNode || this.doc, f(a).index())
        }, setStartAfter:function (a) {
            return this.setStart(a.parentNode ||
                this.doc, f(a).index() + 1)
        }, setEndBefore:function (a) {
            return this.setEnd(a.parentNode || this.doc, f(a).index())
        }, setEndAfter:function (a) {
            return this.setEnd(a.parentNode || this.doc, f(a).index() + 1)
        }, selectNode:function (a) {
            return this.setStartBefore(a).setEndAfter(a)
        }, selectNodeContents:function (a) {
            var b = f(a);
            if (b.type == 3 || b.isSingle())return this.selectNode(a);
            b = b.children();
            if (b.length > 0)return this.setStartBefore(b[0][0]).setEndAfter(b[b.length - 1][0]);
            return this.setStart(a, 0).setEnd(a, 0)
        }, collapse:function (a) {
            if (a)return this.setEnd(this.startContainer,
                this.startOffset);
            return this.setStart(this.endContainer, this.endOffset)
        }, compareBoundaryPoints:function (a, b) {
            var c = this.get(), d = b.get();
            if (p) {
                var e = {};
                e[ia] = "StartToStart";
                e[ha] = "EndToStart";
                e[Z] = "EndToEnd";
                e[ja] = "StartToEnd";
                c = c.compareEndPoints(e[a], d);
                if (c !== 0)return c;
                var i, g, h, j;
                if (a === ia || a === ja)i = this.startContainer, h = this.startOffset;
                if (a === ha || a === Z)i = this.endContainer, h = this.endOffset;
                if (a === ia || a === ha)g = b.startContainer, j = b.startOffset;
                if (a === Z || a === ja)g = b.endContainer, j = b.endOffset;
                if (i ===
                    g)return i = h - j, i > 0 ? 1 : i < 0 ? -1 : 0;
                for (c = g; c && c.parentNode !== i;)c = c.parentNode;
                if (c)return f(c).index() >= h ? -1 : 1;
                for (c = i; c && c.parentNode !== g;)c = c.parentNode;
                if (c)return f(c).index() >= j ? 1 : -1;
                if ((c = f(g).next()) && c.contains(i))return 1;
                if ((c = f(i).next()) && c.contains(g))return-1
            } else return c.compareBoundaryPoints(a, d)
        }, cloneRange:function () {
            return(new N(this.doc)).setStart(this.startContainer, this.startOffset).setEnd(this.endContainer, this.endOffset)
        }, toString:function () {
            var a = this.get();
            return(p ? a.text : a.toString()).replace(/\r\n|\n|\r/g,
                "")
        }, cloneContents:function () {
            return Ka(this, !0, !1)
        }, deleteContents:function () {
            return Ka(this, !1, !0)
        }, extractContents:function () {
            return Ka(this, !0, !0)
        }, insertNode:function (a) {
            var b = this.startContainer, c = this.startOffset, d = this.endContainer, e = this.endOffset, f, g, h, j = 1;
            if (a.nodeName.toLowerCase() === "#document-fragment")f = a.firstChild, g = a.lastChild, j = a.childNodes.length;
            b.nodeType == 1 ? (h = b.childNodes[c]) ? (b.insertBefore(a, h), b === d && (e += j)) : b.appendChild(a) : b.nodeType == 3 && (c === 0 ? (b.parentNode.insertBefore(a,
                b), b.parentNode === d && (e += j)) : c >= b.nodeValue.length ? b.nextSibling ? b.parentNode.insertBefore(a, b.nextSibling) : b.parentNode.appendChild(a) : (h = c > 0 ? b.splitText(c) : b, b.parentNode.insertBefore(a, h), b === d && (d = h, e -= c)));
            f ? this.setStartBefore(f).setEndAfter(g) : this.selectNode(a);
            if (this.compareBoundaryPoints(Z, this.cloneRange().setEnd(d, e)) >= 1)return this;
            return this.setEnd(d, e)
        }, surroundContents:function (a) {
            a.appendChild(this.extractContents());
            return this.insertNode(a).selectNode(a)
        }, isControl:function () {
            var a =
                this.startContainer, b = this.startOffset, c = this.endContainer, d = this.endOffset;
            return a.nodeType == 1 && a === c && b + 1 === d && f(a.childNodes[b]).isControl()
        }, get:function (a) {
            var b = this.doc;
            if (!p) {
                b = b.createRange();
                try {
                    b.setStart(this.startContainer, this.startOffset), b.setEnd(this.endContainer, this.endOffset)
                } catch (c) {
                }
                return b
            }
            if (a && this.isControl())return b = b.body.createControlRange(), b.addElement(this.startContainer.childNodes[this.startOffset]), b;
            a = this.cloneRange().down();
            b = b.body.createTextRange();
            b.setEndPoint("StartToStart",
                pb(a.startContainer, a.startOffset));
            b.setEndPoint("EndToStart", pb(a.endContainer, a.endOffset));
            return b
        }, html:function () {
            return f(this.cloneContents()).outer()
        }, down:function () {
            function a(a, d, e) {
                if (a.nodeType == 1 && (a = f(a).children(), a.length !== 0)) {
                    var i, g, h, j;
                    d > 0 && (i = a[d - 1]);
                    d < a.length && (g = a[d]);
                    if (i && i.type == 3)h = i[0], j = h.nodeValue.length;
                    g && g.type == 3 && (h = g[0], j = 0);
                    h && (e ? b.setStart(h, j) : b.setEnd(h, j))
                }
            }

            var b = this;
            a(b.startContainer, b.startOffset, !0);
            a(b.endContainer, b.endOffset, !1);
            return b
        }, up:function () {
            function a(a, d, e) {
                a.nodeType == 3 && (d === 0 ? e ? b.setStartBefore(a) : b.setEndBefore(a) : d == a.nodeValue.length && (e ? b.setStartAfter(a) : b.setEndAfter(a)))
            }

            var b = this;
            a(b.startContainer, b.startOffset, !0);
            a(b.endContainer, b.endOffset, !1);
            return b
        }, enlarge:function (a) {
            function b(b, e, i) {
                b = f(b);
                if (!(b.type == 3 || Ca[b.name] || !a && b.isBlock()))if (e === 0) {
                    for (; !b.prev();) {
                        e = b.parent();
                        if (!e || Ca[e.name] || !a && e.isBlock())break;
                        b = e
                    }
                    i ? c.setStartBefore(b[0]) : c.setEndBefore(b[0])
                } else if (e == b.children().length) {
                    for (; !b.next();) {
                        e = b.parent();
                        if (!e || Ca[e.name] || !a && e.isBlock())break;
                        b = e
                    }
                    i ? c.setStartAfter(b[0]) : c.setEndAfter(b[0])
                }
            }

            var c = this;
            c.up();
            b(c.startContainer, c.startOffset, !0);
            b(c.endContainer, c.endOffset, !1);
            return c
        }, shrink:function () {
            for (var a, b = this.collapsed; this.startContainer.nodeType == 1 && (a = this.startContainer.childNodes[this.startOffset]) && a.nodeType == 1 && !f(a).isSingle();)this.setStart(a, 0);
            if (b)return this.collapse(b);
            for (; this.endContainer.nodeType == 1 && this.endOffset > 0 && (a = this.endContainer.childNodes[this.endOffset -
                1]) && a.nodeType == 1 && !f(a).isSingle();)this.setEnd(a, a.childNodes.length);
            return this
        }, createBookmark:function (a) {
            var b, c = f('<span style="display:none;"></span>', this.doc)[0];
            c.id = "__kindeditor_bookmark_start_" + Lb++ + "__";
            if (!this.collapsed)b = c.cloneNode(!0), b.id = "__kindeditor_bookmark_end_" + Lb++ + "__";
            b && this.cloneRange().collapse(!1).insertNode(b).setEndBefore(b);
            this.insertNode(c).setStartAfter(c);
            return{start:a ? "#" + c.id : c, end:b ? a ? "#" + b.id : b : null}
        }, moveToBookmark:function (a) {
            var b = this.doc, c = f(a.start,
                b), a = a.end ? f(a.end, b) : null;
            if (!c || c.length < 1)return this;
            this.setStartBefore(c[0]);
            c.remove();
            a && a.length > 0 ? (this.setEndBefore(a[0]), a.remove()) : this.collapse(!0);
            return this
        }, dump:function () {
            console.log("--------------------");
            console.log(this.startContainer.nodeType == 3 ? this.startContainer.nodeValue : this.startContainer, this.startOffset);
            console.log(this.endContainer.nodeType == 3 ? this.endContainer.nodeValue : this.endContainer, this.endOffset)
        }});
        f.range = La;
        f.START_TO_START = ia;
        f.START_TO_END = ha;
        f.END_TO_END =
            Z;
        f.END_TO_START = ja;
        E(ua, {init:function (a) {
            var b = a.doc;
            this.doc = b;
            this.win = S(b);
            this.sel = Ma(b);
            this.range = a
        }, selection:function (a) {
            var b = this.doc, c;
            c = Ma(b);
            var d;
            try {
                d = c.rangeCount > 0 ? c.getRangeAt(0) : c.createRange()
            } catch (e) {
            }
            c = p && (!d || !d.item && d.parentElement().ownerDocument !== b) ? null : d;
            this.sel = Ma(b);
            if (c)return this.range = La(c), f(this.range.startContainer).name == "html" && this.range.selectNodeContents(b.body).collapse(!1), this;
            a && this.range.selectNodeContents(b.body).collapse(!1);
            return this
        }, select:function (a) {
            var a =
                k(a, !0), b = this.sel, c = this.range.cloneRange().shrink(), d = c.startContainer, e = c.startOffset, i = X(d), g = this.win, h, j = !1;
            if (a && d.nodeType == 1 && c.collapsed) {
                if (p) {
                    b = f("<span>&nbsp;</span>", i);
                    c.insertNode(b[0]);
                    h = i.body.createTextRange();
                    try {
                        h.moveToElementText(b[0])
                    } catch (m) {
                    }
                    h.collapse(!1);
                    h.select();
                    b.remove();
                    g.focus();
                    return this
                }
                if (ca && (a = d.childNodes, f(d).isInline() || e > 0 && f(a[e - 1]).isInline() || a[e] && f(a[e]).isInline()))c.insertNode(i.createTextNode("\u200b")), j = !0
            }
            if (p)try {
                h = c.get(!0), h.select()
            } catch (o) {
            } else j &&
                c.collapse(!1), h = c.get(!0), b.removeAllRanges(), b.addRange(h);
            g.focus();
            return this
        }, wrap:function (a) {
            var b = this.range, c;
            c = f(a, this.doc);
            if (b.collapsed)return b.shrink(), b.insertNode(c[0]).selectNodeContents(c[0]), this;
            if (c.isBlock()) {
                for (var d = a = c.clone(!0); d.first();)d = d.first();
                d.append(b.extractContents());
                b.insertNode(a[0]).selectNode(a[0]);
                return this
            }
            b.enlarge();
            var e = b.createBookmark(), a = b.commonAncestor(), i = !1;
            f(a).scan(function (a) {
                if (!i && a == e.start)i = !0; else if (i) {
                    if (a == e.end)return!1;
                    var b =
                        f(a);
                    if (!vb(b) && b.type == 3 && C(a.nodeValue).length > 0) {
                        for (var d; (d = b.parent()) && d.isStyle() && d.children().length == 1;)b = d;
                        d = c;
                        d = d.clone(!0);
                        if (b.type == 3)Pa(d).append(b.clone(!1)), b.replaceWith(d); else {
                            for (var a = b, m; (m = b.first()) && m.children().length == 1;)b = m;
                            m = b.first();
                            for (b = b.doc.createDocumentFragment(); m;)b.appendChild(m[0]), m = m.next();
                            m = a.clone(!0);
                            for (var o = Pa(m), k = m, l = !1; d;) {
                                for (; k;)k.name === d.name && (Tb(k, d.attr(), d.css()), l = !0), k = k.first();
                                l || o.append(d.clone(!1));
                                l = !1;
                                d = d.first()
                            }
                            d = m;
                            b.firstChild &&
                            Pa(d).append(b);
                            a.replaceWith(d)
                        }
                    }
                }
            });
            b.moveToBookmark(e);
            return this
        }, split:function (a, b) {
            for (var c = this.range, d = c.doc, e = c.cloneRange().collapse(a), i = e.startContainer, g = e.startOffset, h = i.nodeType == 3 ? i.parentNode : i, j = !1, m; h && h.parentNode;) {
                m = f(h);
                if (b) {
                    if (!m.isStyle())break;
                    if (!Na(m, b))break
                } else if (Ca[m.name])break;
                j = !0;
                h = h.parentNode
            }
            if (j)d = d.createElement("span"), c.cloneRange().collapse(!a).insertNode(d), a ? e.setStartBefore(h.firstChild).setEnd(i, g) : e.setStart(i, g).setEndAfter(h.lastChild), i = e.extractContents(),
                g = i.firstChild, j = i.lastChild, a ? (e.insertNode(i), c.setStartAfter(j).setEndBefore(d)) : (h.appendChild(i), c.setStartBefore(d).setEndBefore(g)), e = d.parentNode, e == c.endContainer && (h = f(d).prev(), i = f(d).next(), h && i && h.type == 3 && i.type == 3 ? c.setEnd(h[0], h[0].nodeValue.length) : a || c.setEnd(c.endContainer, c.endOffset - 1)), e.removeChild(d);
            return this
        }, remove:function (a) {
            var b = this.doc, c = this.range;
            c.enlarge();
            if (c.startOffset === 0) {
                for (var d = f(c.startContainer), e; (e = d.parent()) && e.isStyle() && e.children().length ==
                    1;)d = e;
                c.setStart(d[0], 0);
                d = f(c.startContainer);
                d.isBlock() && Oa(d, a);
                (d = d.parent()) && d.isBlock() && Oa(d, a)
            }
            if (c.collapsed) {
                this.split(!0, a);
                b = c.startContainer;
                d = c.startOffset;
                if (d > 0 && (e = f(b.childNodes[d - 1])) && $(e))e.remove(), c.setStart(b, d - 1);
                (d = f(b.childNodes[d])) && $(d) && d.remove();
                $(b) && (c.startBefore(b), b.remove());
                c.collapse(!0);
                return this
            }
            this.split(!0, a);
            this.split(!1, a);
            var i = b.createElement("span"), g = b.createElement("span");
            c.cloneRange().collapse(!1).insertNode(g);
            c.cloneRange().collapse(!0).insertNode(i);
            var h = [], j = !1;
            f(c.commonAncestor()).scan(function (a) {
                if (!j && a == i)j = !0; else {
                    if (a == g)return!1;
                    j && h.push(a)
                }
            });
            f(i).remove();
            f(g).remove();
            b = c.startContainer;
            d = c.startOffset;
            e = c.endContainer;
            var m = c.endOffset;
            if (d > 0) {
                var o = f(b.childNodes[d - 1]);
                o && $(o) && (o.remove(), c.setStart(b, d - 1), b == e && c.setEnd(e, m - 1));
                if ((d = f(b.childNodes[d])) && $(d))d.remove(), b == e && c.setEnd(e, m - 1)
            }
            (b = f(e.childNodes[c.endOffset])) && $(b) && b.remove();
            b = c.createBookmark(!0);
            l(h, function (b, c) {
                Oa(f(c), a)
            });
            c.moveToBookmark(b);
            return this
        },
            commonNode:function (a) {
                function b(b) {
                    for (var c = b; b;) {
                        if (Na(f(b), a))return f(b);
                        b = b.parentNode
                    }
                    for (; c && (c = c.lastChild);)if (Na(f(c), a))return f(c);
                    return null
                }

                var c = this.range, d = c.endContainer, c = c.endOffset, e = d.nodeType == 3 || c === 0 ? d : d.childNodes[c - 1], i = b(e);
                if (i)return i;
                if (e.nodeType == 1 || d.nodeType == 3 && c === 0)if (d = f(e).prev())return b(d);
                return null
            }, commonAncestor:function (a) {
                function b(b) {
                    for (; b;) {
                        if (b.nodeType == 1 && b.tagName.toLowerCase() === a)return b;
                        b = b.parentNode
                    }
                    return null
                }

                var c = this.range, d =
                    c.startContainer, e = c.startOffset, i = c.endContainer, c = c.endOffset, i = i.nodeType == 3 || c === 0 ? i : i.childNodes[c - 1], d = b(d.nodeType == 3 || e === 0 ? d : d.childNodes[e - 1]), e = b(i);
                if (d && e && d === e)return f(d);
                return null
            }, state:function (a) {
                var b = this.doc, c = !1;
                try {
                    c = b.queryCommandState(a)
                } catch (d) {
                }
                return c
            }, val:function (a) {
                var b = this.doc, a = a.toLowerCase(), c = "";
                if (a === "fontfamily" || a === "fontname")return c = rb(b, "fontname"), c = c.replace(/['"]/g, ""), c.toLowerCase();
                if (a === "formatblock") {
                    c = rb(b, a);
                    if (c === "" && (a = this.commonNode({"h1,h2,h3,h4,h5,h6,p,div,pre,address":"*"})))c =
                        a.name;
                    c === "Normal" && (c = "p");
                    return c.toLowerCase()
                }
                if (a === "fontsize")return(a = this.commonNode({"*":".font-size"})) && (c = a.css("font-size")), c.toLowerCase();
                if (a === "forecolor")return(a = this.commonNode({"*":".color"})) && (c = a.css("color")), c = na(c), c === "" && (c = "default"), c.toLowerCase();
                if (a === "hilitecolor")return(a = this.commonNode({"*":".background-color"})) && (c = a.css("background-color")), c = na(c), c === "" && (c = "default"), c.toLowerCase();
                return c
            }, toggle:function (a, b) {
                this.commonNode(b) ? this.remove(b) : this.wrap(a);
                return this.select()
            }, bold:function () {
                return this.toggle("<strong></strong>", {span:".font-weight=bold", strong:"*", b:"*"})
            }, italic:function () {
                return this.toggle("<em></em>", {span:".font-style=italic", em:"*", i:"*"})
            }, underline:function () {
                return this.toggle("<u></u>", {span:".text-decoration=underline", u:"*"})
            }, strikethrough:function () {
                return this.toggle("<s></s>", {span:".text-decoration=line-through", s:"*"})
            }, forecolor:function (a) {
                return this.toggle('<span style="color:' + a + ';"></span>', {span:".color=" +
                    a, font:"color"})
            }, hilitecolor:function (a) {
                return this.toggle('<span style="background-color:' + a + ';"></span>', {span:".background-color=" + a})
            }, fontsize:function (a) {
                return this.toggle('<span style="font-size:' + a + ';"></span>', {span:".font-size=" + a, font:"size"})
            }, fontname:function (a) {
                return this.fontfamily(a)
            }, fontfamily:function (a) {
                return this.toggle('<span style="font-family:' + a + ';"></span>', {span:".font-family=" + a, font:"face"})
            }, removeformat:function () {
                var a = {"*":".font-weight,.font-style,.text-decoration,.color,.background-color,.font-size,.font-family,.text-indent"};
                l(Ib, function (b) {
                    a[b] = "*"
                });
                this.remove(a);
                return this.select()
            }, inserthtml:function (a) {
                function b(a, b) {
                    var b = '<img id="__kindeditor_temp_tag__" width="0" height="0" style="display:none;" />' + b, c = a.get();
                    c.item ? c.item(0).outerHTML = b : c.pasteHTML(b);
                    var e = a.doc.getElementById("__kindeditor_temp_tag__");
                    e.parentNode.removeChild(e);
                    c = qb(c);
                    a.setEnd(c.endContainer, c.endOffset);
                    a.collapse(!1);
                    d.select(!1)
                }

                function c(a, b) {
                    var c = a.doc, e = c.createDocumentFragment();
                    f("@" + b, c).each(function () {
                        e.appendChild(this)
                    });
                    a.deleteContents();
                    a.insertNode(e);
                    a.collapse(!1);
                    d.select(!1)
                }

                var d = this, e = d.range;
                if (a === "")return d;
                if (vb(f(e.startContainer)))return d;
                if (p) {
                    try {
                        b(e, a)
                    } catch (i) {
                        c(e, a)
                    }
                    return d
                }
                c(e, a);
                return d
            }, hr:function () {
                return this.inserthtml("<hr />")
            }, print:function () {
                this.win.print();
                return this
            }, insertimage:function (a, b, c, d, e, f) {
                b = k(b, "");
                k(e, 0);
                a = '<img src="' + D(a) + '" data-ke-src="' + D(a) + '" ';
                c && (a += 'width="' + D(c) + '" ');
                d && (a += 'height="' + D(d) + '" ');
                b && (a += 'title="' + D(b) + '" ');
                f && (a += 'align="' + D(f) + '" ');
                a += 'alt="' + D(b) + '" ';
                a += " class='ke-content-img'/>";
                return this.inserthtml(a)
            }, createlink:function (a, b) {
                var c = this.doc, d = this.range;
                this.select();
                var e = this.commonNode({a:"*"});
                e && !d.isControl() && (d.selectNode(e.get()), this.select());
                e = '<a href="' + D(a) + '" data-ke-src="' + D(a) + '" ';
                b && (e += ' target="' + D(b) + '"');
                if (d.collapsed)return e += ">" + D(a) + "</a>", this.inserthtml(e);
                if (d.isControl()) {
                    var i = f(d.startContainer.childNodes[d.startOffset]);
                    e += "></a>";
                    i.after(f(e, c));
                    i.next().append(i);
                    d.selectNode(i[0]);
                    return this.select()
                }
                O(c,
                    "createlink", "__kindeditor_temp_url__");
                f('a[href="__kindeditor_temp_url__"]', c).each(function () {
                    f(this).attr("href", a).attr("data-ke-src", a);
                    b ? f(this).attr("target", b) : f(this).removeAttr("target")
                });
                return this
            }, unlink:function () {
                var a = this.doc, b = this.range;
                this.select();
                if (b.collapsed) {
                    var c = this.commonNode({a:"*"});
                    c && (b.selectNode(c.get()), this.select());
                    O(a, "unlink", null);
                    ca && f(b.startContainer).name === "img" && (a = f(b.startContainer).parent(), a.name === "a" && a.remove(!0))
                } else O(a, "unlink", null);
                return this
            }});
        l("formatblock,selectall,justifyleft,justifycenter,justifyright,justifyfull,insertorderedlist,insertunorderedlist,indent,outdent,subscript,superscript".split(","), function (a, b) {
            ua.prototype[b] = function (a) {
                this.select();
                O(this.doc, b, a);
                (!p || M(b, "formatblock,selectall,insertorderedlist,insertunorderedlist".split(",")) >= 0) && this.selection();
                return this
            }
        });
        l("cut,copy,paste".split(","), function (a, b) {
            ua.prototype[b] = function () {
                if (!this.doc.queryCommandSupported(b))throw"not supported";
                this.select();
                O(this.doc, b, null);
                return this
            }
        });
        f.cmd = wb;
        E(Q, {init:function (a) {
            var b = this;
            b.name = a.name || "";
            b.doc = a.doc || document;
            b.win = S(b.doc);
            b.x = s(a.x);
            b.y = s(a.y);
            b.z = a.z;
            b.width = s(a.width);
            b.height = s(a.height);
            b.div = f('<div style="display:block;"></div>');
            b.options = a;
            b._alignEl = a.alignEl;
            b.width && b.div.css("width", b.width);
            b.height && b.div.css("height", b.height);
            b.z && b.div.css({position:"absolute", left:b.x, top:b.y, "z-index":b.z});
            b.z && (b.x === n || b.y === n) && b.autoPos(b.width, b.height);
            a.cls && b.div.addClass(a.cls);
            a.shadowMode && b.div.addClass("ke-shadow");
            a.css && b.div.css(a.css);
            a.src ? f(a.src).replaceWith(b.div) : f(b.doc.body).append(b.div);
            a.html && b.div.html(a.html);
            if (a.autoScroll)if (p && F < 7 || T) {
                var c = Y();
                f(b.win).bind("scroll", function () {
                    var a = Y(), e = a.x - c.x, a = a.y - c.y;
                    b.pos(t(b.x) + e, t(b.y) + a, !1)
                })
            } else b.div.css("position", "fixed")
        }, pos:function (a, b, c) {
            c = k(c, !0);
            if (a !== null && (a = a < 0 ? 0 : s(a), this.div.css("left", a), c))this.x = a;
            if (b !== null && (b = b < 0 ? 0 : s(b), this.div.css("top", b), c))this.y = b;
            return this
        }, autoPos:function (a, b) {
            var c = t(a) || 0, d = t(b) || 0, e = Y();
            if (this._alignEl) {
                var i = f(this._alignEl), g = i.pos(), c = P(i[0].clientWidth / 2 - c / 2), d = P(i[0].clientHeight / 2 - d / 2);
                x = c < 0 ? g.x : g.x + c;
                y = d < 0 ? g.y : g.y + d
            } else g = H(this.doc), x = P(e.x + (g.clientWidth - c) / 2), y = P(e.y + (g.clientHeight - d) / 2);
            p && F < 7 || T || (x -= e.x, y -= e.y);
            return this.pos(x, y)
        }, remove:function () {
            var a = this;
            p && F < 7 && f(a.win).unbind("scroll");
            a.div.remove();
            l(a, function (b) {
                a[b] = null
            });
            return this
        }, show:function () {
            this.div.show();
            return this
        }, hide:function () {
            this.div.hide();
            return this
        },
            draggable:function (a) {
                var b = this, a = a || {};
                a.moveEl = b.div;
                a.moveFn = function (a, d, e, f, g, h) {
                    if ((a += g) < 0)a = 0;
                    if ((d += h) < 0)d = 0;
                    b.pos(a, d)
                };
                Qa(a);
                return b
            }});
        f.WidgetClass = Q;
        f.widget = Sa;
        E(va, Q, {init:function (a) {
            function b() {
                var b = Ra(c.iframe);
                b.open();
                if (h)b.domain = document.domain;
                b.write(Ub(d, e, i, g));
                b.close();
                c.win = c.iframe[0].contentWindow;
                c.doc = b;
                var j = wb(b);
                c.afterChange(function () {
                    j.selection()
                });
                ca && f(b).click(function (a) {
                    f(a.target).name === "img" && (j.selection(!0), j.range.selectNode(a.target), j.select())
                });
                p && f(b).keydown(function (a) {
                    if (a.which == 8) {
                        j.selection();
                        var b = j.range;
                        b.isControl() && (b.collapse(!0), f(b.startContainer.childNodes[b.startOffset]).remove(), a.preventDefault())
                    }
                });
                c.cmd = j;
                c.html(aa(c.srcElement));
                p ? (b.body.disabled = !0, b.body.contentEditable = !0, b.body.removeAttribute("disabled")) : b.designMode = "on";
                a.afterCreate && a.afterCreate.call(c)
            }

            var c = this;
            va.parent.init.call(c, a);
            c.srcElement = f(a.srcElement);
            c.div.addClass("ke-edit");
            c.designMode = k(a.designMode, !0);
            c.beforeGetHtml = a.beforeGetHtml;
            c.beforeSetHtml = a.beforeSetHtml;
            c.afterSetHtml = a.afterSetHtml;
            var d = k(a.themesPath, ""), e = a.bodyClass, i = a.cssPath, g = a.cssData, h = location.host.replace(/:\d+/, "") !== document.domain, j = "document.open();" + (h ? 'document.domain="' + document.domain + '";' : "") + "document.close();", j = p ? ' src="javascript:void(function(){' + encodeURIComponent(j) + '}())"' : "";
            c.iframe = f('<iframe class="ke-edit-iframe" hidefocus="true" frameborder="0"' + j + "></iframe>").css("width", "100%");
            c.textarea = f('<textarea class="ke-edit-textarea" hidefocus="true"></textarea>').css("width",
                "100%");
            c.width && c.setWidth(c.width);
            c.height && c.setHeight(c.height);
            c.designMode ? c.textarea.hide() : c.iframe.hide();
            h && c.iframe.bind("load", function () {
                c.iframe.unbind("load");
                p ? b() : setTimeout(b, 0)
            });
            c.div.append(c.iframe);
            c.div.append(c.textarea);
            c.srcElement.hide();
            !h && b()
        }, setWidth:function (a) {
            this.div.css("width", s(a));
            return this
        }, setHeight:function (a) {
            a = s(a);
            this.div.css("height", a);
            this.iframe.css("height", a);
            if (p && F < 8 || T)a = s(t(a) - 2);
            this.textarea.css("height", a);
            return this
        }, remove:function () {
            var a =
                this.doc;
            f(a.body).unbind();
            f(a).unbind();
            f(this.win).unbind();
            aa(this.srcElement, this.html());
            this.srcElement.show();
            a.write("");
            this.iframe.unbind();
            this.textarea.unbind();
            va.parent.remove.call(this)
        }, html:function (a, b) {
            var c = this.doc;
            if (this.designMode) {
                c = c.body;
                if (a === n)return a = b ? "<!doctype html><html>" + c.parentNode.innerHTML + "</html>" : c.innerHTML, this.beforeGetHtml && (a = this.beforeGetHtml(a)), la && a == "<br />" && (a = ""), a;
                this.beforeSetHtml && (a = this.beforeSetHtml(a));
                f(c).html(a);
                this.afterSetHtml &&
                this.afterSetHtml();
                return this
            }
            if (a === n)return this.textarea.val();
            this.textarea.val(a);
            return this
        }, design:function (a) {
            if (a === n ? !this.designMode : a) {
                if (!this.designMode)a = this.html(), this.designMode = !0, this.html(a), this.textarea.hide(), this.iframe.show()
            } else if (this.designMode)a = this.html(), this.designMode = !1, this.html(a), this.iframe.hide(), this.textarea.show();
            return this.focus()
        }, focus:function () {
            this.designMode ? this.win.focus() : this.textarea[0].focus();
            return this
        }, blur:function () {
            if (p) {
                var a =
                    f('<input type="text" style="float:left;width:0;height:0;padding:0;margin:0;border:0;" value="" />', this.div);
                this.div.append(a);
                a[0].focus();
                a.remove()
            } else this.designMode ? this.win.blur() : this.textarea[0].blur();
            return this
        }, afterChange:function (a) {
            function b(b) {
                setTimeout(function () {
                    a(b)
                }, 1)
            }

            var c = this.doc, d = c.body;
            f(c).keyup(function (b) {
                !b.ctrlKey && !b.altKey && Ya[b.which] && a(b)
            });
            f(c).mouseup(a).contextmenu(a);
            f(this.win).blur(a);
            f(d).bind("paste", b);
            f(d).bind("cut", b);
            return this
        }});
        f.edit = xb;
        f.iframeDoc = Ra;
        E(Ta, Q, {init:function (a) {
            function b(a) {
                a = f(a);
                if (a.hasClass("ke-outline"))return a;
                if (a.hasClass("ke-toolbar-icon"))return a.parent()
            }

            function c(a, c) {
                var d = b(a.target);
                if (d && !d.hasClass("ke-disabled") && !d.hasClass("ke-selected"))d[c]("ke-on")
            }

            var d = this;
            Ta.parent.init.call(d, a);
            d.disableMode = k(a.disableMode, !1);
            d.noDisableItemMap = u(k(a.noDisableItems, []));
            d._itemMap = {};
            d.div.addClass("ke-toolbar").bind("contextmenu,mousedown,mousemove",
                function (a) {
                    a.preventDefault()
                }).attr("unselectable",
                "on");
            d.div.mouseover(
                function (a) {
                    c(a, "addClass")
                }).mouseout(
                function (a) {
                    c(a, "removeClass")
                }).click(function (a) {
                var c = b(a.target);
                c && !c.hasClass("ke-disabled") && d.options.click.call(this, a, c.attr("data-name"))
            })
        }, get:function (a) {
            if (this._itemMap[a])return this._itemMap[a];
            return this._itemMap[a] = f("span.ke-icon-" + a, this.div).parent()
        }, select:function (a) {
            yb.call(this, a, function (a) {
                a.addClass("ke-selected")
            });
            return self
        }, unselect:function (a) {
            yb.call(this, a, function (a) {
                a.removeClass("ke-selected").removeClass("ke-on")
            });
            return self
        }, enable:function (a) {
            if (a = a.get ? a : this.get(a))a.removeClass("ke-disabled"), a.opacity(1);
            return this
        }, disable:function (a) {
            if (a = a.get ? a : this.get(a))a.removeClass("ke-selected").addClass("ke-disabled"), a.opacity(0.5);
            return this
        }, disableAll:function (a, b) {
            var c = this, d = c.noDisableItemMap;
            b && (d = u(b));
            (a === n ? !c.disableMode : a) ? (f("span.ke-outline", c.div).each(function () {
                var a = f(this), b = a[0].getAttribute("data-name", 2);
                d[b] || c.disable(a)
            }), c.disableMode = !0) : (f("span.ke-outline", c.div).each(function () {
                var a =
                    f(this), b = a[0].getAttribute("data-name", 2);
                d[b] || c.enable(a)
            }), c.disableMode = !1);
            return c
        }});
        f.toolbar = zb;
        E(wa, Q, {init:function (a) {
            a.z = a.z || 811213;
            wa.parent.init.call(this, a);
            this.centerLineMode = k(a.centerLineMode, !0);
            this.div.addClass("ke-menu").bind("click,mousedown",
                function (a) {
                    a.stopPropagation()
                }).attr("unselectable", "on")
        }, addItem:function (a) {
            if (a.title === "-")this.div.append(f('<div class="ke-menu-separator"></div>')); else {
                var b = f('<div class="ke-menu-item" unselectable="on"></div>'), c = f('<div class="ke-inline-block ke-menu-item-left"></div>'),
                    d = f('<div class="ke-inline-block ke-menu-item-right"></div>'), e = s(a.height), i = k(a.iconClass, "");
                this.div.append(b);
                e && (b.css("height", e), d.css("line-height", e));
                var g;
                this.centerLineMode && (g = f('<div class="ke-inline-block ke-menu-item-center"></div>'), e && g.css("height", e));
                b.mouseover(
                    function () {
                        f(this).addClass("ke-menu-item-on");
                        g && g.addClass("ke-menu-item-center-on")
                    }).mouseout(
                    function () {
                        f(this).removeClass("ke-menu-item-on");
                        g && g.removeClass("ke-menu-item-center-on")
                    }).click(
                    function (b) {
                        a.click.call(f(this));
                        b.stopPropagation()
                    }).append(c);
                g && b.append(g);
                b.append(d);
                a.checked && (i = "ke-icon-checked");
                i !== "" && c.html('<span class="ke-inline-block ke-toolbar-icon ke-toolbar-icon-url ' + i + '"></span>');
                d.html(a.title);
                return this
            }
        }, remove:function () {
            this.options.beforeRemove && this.options.beforeRemove.call(this);
            f(".ke-menu-item", this.div[0]).unbind();
            wa.parent.remove.call(this);
            return this
        }});
        f.menu = Ua;
        E(xa, Q, {init:function (a) {
            a.z = a.z || 811213;
            xa.parent.init.call(this, a);
            var b = a.colors || [
                ["#E53333", "#E56600",
                    "#FF9900", "#64451D", "#DFC5A4", "#FFE500"],
                ["#009900", "#006600", "#99BB00", "#B8D100", "#60D978", "#00D5FF"],
                ["#337FE5", "#003399", "#4C33E5", "#9933E5", "#CC33E5", "#EE33EE"],
                ["#FFFFFF", "#CCCCCC", "#999999", "#666666", "#333333", "#000000"]
            ];
            this.selectedColor = (a.selectedColor || "").toLowerCase();
            this._cells = [];
            this.div.addClass("ke-colorpicker").bind("click,mousedown",
                function (a) {
                    a.stopPropagation()
                }).attr("unselectable", "on");
            a = this.doc.createElement("table");
            this.div.append(a);
            a.className = "ke-colorpicker-table";
            a.cellPadding = 0;
            a.cellSpacing = 0;
            a.border = 0;
            var c = a.insertRow(0), d = c.insertCell(0);
            d.colSpan = b[0].length;
            this._addAttr(d, "", "ke-colorpicker-cell-top");
            for (var e = 0; e < b.length; e++)for (var c = a.insertRow(e + 1), f = 0; f < b[e].length; f++)d = c.insertCell(f), this._addAttr(d, b[e][f], "ke-colorpicker-cell")
        }, _addAttr:function (a, b, c) {
            var d = this, a = f(a).addClass(c);
            d.selectedColor === b.toLowerCase() && a.addClass("ke-colorpicker-cell-selected");
            a.attr("title", b || d.options.noColor);
            a.mouseover(function () {
                f(this).addClass("ke-colorpicker-cell-on")
            });
            a.mouseout(function () {
                f(this).removeClass("ke-colorpicker-cell-on")
            });
            a.click(function (a) {
                a.stop();
                d.options.click.call(f(this), b)
            });
            b ? a.append(f('<div class="ke-colorpicker-cell-color" unselectable="on"></div>').css("background-color", b)) : a.html(d.options.noColor);
            f(a).attr("unselectable", "on");
            d._cells.push(a)
        }, remove:function () {
            l(this._cells, function () {
                this.unbind()
            });
            xa.parent.remove.call(this);
            return this
        }});
        f.colorpicker = Ab;
        E(Bb, {init:function (a) {
            var b = f(a.button), c = a.fieldName || "file", d = a.url ||
                "", e = b.val(), i = b[0].className || "", g = "kindeditor_upload_iframe_" + (new Date).getTime();
            a.afterError = a.afterError || function (a) {
                alert(a)
            };
            c = ['<div class="ke-inline-block ' + i + '">', '<iframe name="' + g + '" style="display:none;"></iframe>', '<form class="ke-upload-area ke-form" method="post" enctype="multipart/form-data" target="' + g + '" action="' + d + '">', '<span class="ke-button-common">', '<input type="button" class="ke-button-common ke-button" value="' + e + '" />', "</span>", '<input type="file" class="ke-upload-file" name="' +
                c + '" tabindex="-1" />', "</form></div>"].join("");
            c = f(c, b.doc);
            b.hide();
            b.before(c);
            this.div = c;
            this.button = b;
            this.iframe = f("iframe", c);
            this.form = f("form", c);
            this.fileBox = f(".ke-upload-file", c).width(f(".ke-button-common").width());
            this.options = a
        }, submit:function () {
            var a = this, b = a.iframe;
            b.bind("load", function () {
                b.unbind();
                var c = f.iframeDoc(b), e = c.getElementsByTagName("pre")[0], i = "", g, i = e ? e.innerHTML : c.body.innerHTML;
                try {
                    g = f.json(i)
                } catch (h) {
                    a.options.afterError.call(a, "<!doctype html><html>" + c.body.parentNode.innerHTML +
                        "</html>")
                }
                g && a.options.afterUpload.call(a, g)
            });
            a.form[0].submit();
            var c = document.createElement("form");
            a.fileBox.before(c);
            f(c).append(a.fileBox);
            c.reset();
            f(c).remove(!0);
            return a
        }, remove:function () {
            this.fileBox && this.fileBox.unbind();
            this.div.remove();
            this.button.show();
            return this
        }});
        f.uploadbutton = function (a) {
            return new Bb(a)
        };
        E(ya, Q, {init:function (a) {
            var b = k(a.shadowMode, !0);
            a.z = a.z || 811213;
            a.shadowMode = !1;
            ya.parent.init.call(this, a);
            var c = a.title, d = f(a.body, this.doc), e = a.previewBtn, i = a.yesBtn,
                g = a.noBtn, h = a.closeBtn, j = k(a.showMask, !0);
            this.div.addClass("ke-dialog").bind("click,mousedown", function (a) {
                a.stopPropagation()
            });
            var m = f('<div class="ke-dialog-content"></div>').appendTo(this.div);
            p && F < 7 ? this.iframeMask = f('<iframe src="about:blank" class="ke-dialog-shadow"></iframe>').appendTo(this.div) : b && f('<div class="ke-dialog-shadow"></div>').appendTo(this.div);
            b = f('<div class="ke-dialog-header"></div>');
            m.append(b);
            b.html(c);
            this.closeIcon = f('<span class="ke-dialog-icon-close" title="' + h.name +
                '"></span>').click(h.click);
            b.append(this.closeIcon);
            this.draggable({clickEl:b, beforeDrag:a.beforeDrag});
            a = f('<div class="ke-dialog-body"></div>');
            m.append(a);
            a.append(d);
            var o = f('<div class="ke-dialog-footer"></div>');
            (e || i || g) && m.append(o);
            l([
                {btn:e, name:"preview"},
                {btn:i, name:"yes"},
                {btn:g, name:"no"}
            ], function () {
                if (this.btn) {
                    var a = this.btn, a = a || {}, b = a.name || "", c = f('<span class="ke-button-common ke-button-outer" title="' + b + '"></span>'), b = f('<input class="ke-button-common ke-button" type="button" value="' +
                        b + '" />');
                    a.click && b.click(a.click);
                    c.append(b);
                    c.addClass("ke-dialog-" + this.name);
                    o.append(c)
                }
            });
            this.height && a.height(t(this.height) - b.height() - o.height());
            this.div.width(this.div.width());
            this.div.height(this.div.height());
            this.mask = null;
            if (j)d = H(this.doc), this.mask = Sa({x:0, y:0, z:this.z - 1, cls:"ke-dialog-mask", width:Math.max(d.scrollWidth, d.clientWidth), height:Math.max(d.scrollHeight, d.clientHeight)});
            this.autoPos(this.div.width(), this.div.height());
            this.footerDiv = o;
            this.bodyDiv = a;
            this.headerDiv =
                b
        }, setMaskIndex:function (a) {
            this.mask.div.css("z-index", a)
        }, showLoading:function (a) {
            var a = k(a, ""), b = this.bodyDiv;
            this.loading = f('<div class="ke-dialog-loading"><div class="ke-inline-block ke-dialog-loading-content" style="margin-top:' + Math.round(b.height() / 3) + 'px;">' + a + "</div></div>").width(b.width()).height(b.height()).css("top", this.headerDiv.height() + "px");
            b.css("visibility", "hidden").after(this.loading);
            return this
        }, hideLoading:function () {
            this.loading && this.loading.remove();
            this.bodyDiv.css("visibility",
                "visible");
            return this
        }, remove:function () {
            this.options.beforeRemove && this.options.beforeRemove.call(this);
            this.mask && this.mask.remove();
            this.iframeMask && this.iframeMask.remove();
            this.closeIcon.unbind();
            f("input", this.div).unbind();
            this.footerDiv.unbind();
            this.bodyDiv.unbind();
            this.headerDiv.unbind();
            ya.parent.remove.call(this);
            return this
        }});
        f.dialog = Cb;
        f.tabs = function (a) {
            var b = Sa(a), c = b.remove, d = a.afterSelect, a = b.div, e = [];
            a.addClass("ke-tabs").bind("contextmenu,mousedown,mousemove", function (a) {
                a.preventDefault()
            });
            var i = f('<ul class="ke-tabs-ul ke-clearfix"></ul>');
            a.append(i);
            b.add = function (a) {
                var b = f('<li class="ke-tabs-li">' + a.title + "</li>");
                b.data("tab", a);
                e.push(b);
                i.append(b)
            };
            b.selectedIndex = 0;
            b.select = function (a) {
                b.selectedIndex = a;
                l(e, function (c, d) {
                    d.unbind();
                    c === a ? (d.addClass("ke-tabs-li-selected"), f(d.data("tab").panel).show("")) : (d.removeClass("ke-tabs-li-selected").removeClass("ke-tabs-li-on").mouseover(
                        function () {
                            f(this).addClass("ke-tabs-li-on")
                        }).mouseout(
                        function () {
                            f(this).removeClass("ke-tabs-li-on")
                        }).click(function () {
                        b.select(c)
                    }),
                        f(d.data("tab").panel).hide())
                });
                d && d.call(b, a)
            };
            b.remove = function () {
                l(e, function () {
                    this.remove()
                });
                i.remove();
                c.call(b)
            };
            return b
        };
        f.loadScript = Va;
        f.loadStyle = Wa;
        f.ajax = function (a, b, c, d, e) {
            var c = c || "GET", e = e || "json", f = B.XMLHttpRequest ? new B.XMLHttpRequest : new ActiveXObject("Microsoft.XMLHTTP");
            f.open(c, a, !0);
            f.onreadystatechange = function () {
                if (f.readyState == 4 && f.status == 200 && b) {
                    var a = C(f.responseText);
                    e == "json" && (a = ab(a));
                    b(a)
                }
            };
            if (c == "POST") {
                var g = [];
                l(d, function (a, b) {
                    g.push(encodeURIComponent(a) +
                        "=" + encodeURIComponent(b))
                });
                try {
                    f.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
                } catch (h) {
                }
                f.send(g.join("&"))
            } else f.send(null)
        };
        var ba = {}, L = {};
        Aa.prototype = {lang:function (a) {
            return Fb(a, this.langType)
        }, loadPlugin:function (a, b) {
            var c = this;
            if (ba[a]) {
                if (c._calledPlugins[a])return b && b.call(c), c;
                ba[a].call(c, KindEditor);
                b && b.call(c);
                c._calledPlugins[a] = !0;
                return c
            }
            if (c.isLoading)return c;
            c.isLoading = !0;
            Va(c.pluginsPath + a + "/" + a + ".js?ver=" + encodeURIComponent(f.DEBUG ? Ba : "4.0.5 (2012-01-15)"),
                function () {
                    c.isLoading = !1;
                    ba[a] && c.loadPlugin(a, b)
                });
            return c
        }, handler:function (a, b) {
            var c = this;
            c._handlers[a] || (c._handlers[a] = []);
            if (Za(b))return c._handlers[a].push(b), c;
            l(c._handlers[a], function () {
                b = this.call(c, b)
            });
            return b
        }, clickToolbar:function (a, b) {
            var c = this, d = "clickToolbar" + a;
            if (b === n) {
                if (c._handlers[d])return c.handler(d);
                c.loadPlugin(a, function () {
                    c.handler(d)
                });
                return c
            }
            return c.handler(d, b)
        }, updateState:function () {
            var a = this;
            l("justifyleft,justifycenter,justifyright,justifyfull,insertorderedlist,insertunorderedlist,subscript,superscript,bold,italic,underline,strikethrough".split(","),
                function (b, c) {
                    a.cmd.state(c) ? a.toolbar.select(c) : a.toolbar.unselect(c)
                });
            return a
        }, addContextmenu:function (a) {
            this._contextmenus.push(a);
            return this
        }, afterCreate:function (a) {
            return this.handler("afterCreate", a)
        }, beforeRemove:function (a) {
            return this.handler("beforeRemove", a)
        }, beforeGetHtml:function (a) {
            return this.handler("beforeGetHtml", a)
        }, beforeSetHtml:function (a) {
            return this.handler("beforeSetHtml", a)
        }, afterSetHtml:function (a) {
            return this.handler("afterSetHtml", a)
        }, create:function () {
            function a() {
                m.height() ===
                    0 ? setTimeout(a, 100) : c.resize(e, i)
            }

            function b(a, b, d) {
                d = k(d, !0);
                if (a && a >= c.minWidth && (c.resize(a, null), d))c.width = s(a);
                if (b && b >= c.minHeight && (c.resize(null, b), d))c.height = s(b)
            }

            var c = this, d = c.fullscreenMode;
            if (c.isCreated)return c;
            d ? H().style.overflow = "hidden" : H().style.overflow = "";
            var e = d ? H().clientWidth + "px" : c.width, i = d ? H().clientHeight + "px" : c.height;
            if (p && F < 8 || T)i = s(t(i) + 2);
            var g = c.container = f(c.layout);
            d ? f(document.body).append(g) : c.srcElement.before(g);
            var h = f(".toolbar", g), j = f(".edit", g), m = c.statusbar =
                f(".statusbar", g);
            g.removeClass("container").addClass("ke-container ke-container-" + c.themeType).css("width", e);
            if (d) {
                g.css({position:"absolute", left:0, top:0, "z-index":811211});
                if (!la)c._scrollPos = Y();
                B.scrollTo(0, 0);
                f(document.body).css({height:"1px", overflow:"hidden"});
                f(document.body.parentNode).css("overflow", "hidden")
            } else c._scrollPos && (f(document.body).css({height:"", overflow:""}), f(document.body.parentNode).css("overflow", ""), B.scrollTo(c._scrollPos.x, c._scrollPos.y));
            var o = [];
            f.each(c.items,
                function (a, b) {
                    b == "|" ? o.push('<span class="ke-inline-block ke-separator"></span>') : b == "/" ? o.push('<div class="ke-hr"></div>') : (o.push('<span class="ke-outline" data-name="' + b + '" title="' + c.lang(b) + '" unselectable="on">'), o.push('<span class="ke-toolbar-icon ke-toolbar-icon-url ke-icon-' + b + '" unselectable="on"></span></span>'))
                });
            var h = c.toolbar = zb({src:h, html:o.join(""), noDisableItems:c.noDisableItems, click:function (a, b) {
                    a.stop();
                    if (c.menu) {
                        var d = c.menu.name;
                        c.hideMenu();
                        if (d === b)return
                    }
                    c.clickToolbar(b)
                }}),
                l = t(i) - h.div.height(), n = c.edit = xb({height:l > 0 && t(i) > c.minHeight ? l : c.minHeight, src:j, srcElement:c.srcElement, designMode:c.designMode, themesPath:c.themesPath, bodyClass:c.bodyClass, cssPath:c.cssPath, cssData:c.cssData, beforeGetHtml:function (a) {
                    a = c.beforeGetHtml(a);
                    return R(a, c.filterMode ? c.htmlTags : null, c.urlType, c.wellFormatMode, c.indentChar)
                }, beforeSetHtml:function (a) {
                    a = R(a, c.filterMode ? c.htmlTags : null, "", !1);
                    return c.beforeSetHtml(a)
                }, afterSetHtml:function () {
                    c.edit = n = this;
                    c.afterSetHtml()
                }, afterCreate:function () {
                    c.edit =
                        n = this;
                    c.cmd = n.cmd;
                    c._docMousedownFn = function () {
                        c.menu && c.hideMenu()
                    };
                    f(n.doc, document).mousedown(c._docMousedownFn);
                    Vb.call(c);
                    Wb.call(c);
                    Xb.call(c);
                    Yb.call(c);
                    n.afterChange(function () {
                        n.designMode && (c.updateState(), c.addBookmark(), c.options.afterChange && c.options.afterChange.call(c))
                    });
                    n.textarea.keyup(function (a) {
                        !a.ctrlKey && !a.altKey && Kb[a.which] && c.options.afterChange && c.options.afterChange.call(c)
                    });
                    c.readonlyMode && c.readonly();
                    c.isCreated = !0;
                    c.initContent = c.html();
                    c.afterCreate();
                    c.options.afterCreate &&
                    c.options.afterCreate.call(c)
                }});
            m.removeClass("statusbar").addClass("ke-statusbar").append('<span class="ke-inline-block ke-statusbar-center-icon"></span>').append('<span class="ke-inline-block ke-statusbar-right-icon"></span>');
            f(B).unbind("resize");
            a();
            d ? (f(B).bind("resize", function () {
                c.isCreated && b(H().clientWidth, H().clientHeight, !1)
            }), h.select("fullscreen"), m.first().css("visibility", "hidden"), m.last().css("visibility", "hidden")) : (la && f(B).bind("scroll", function () {
                c._scrollPos = Y()
            }), c.resizeType >
                0 ? Qa({moveEl:g, clickEl:m, moveFn:function (a, c, d, e, f, j) {
                e += j;
                b(null, e)
            }}) : m.first().css("visibility", "hidden"), c.resizeType === 2 ? Qa({moveEl:g, clickEl:m.last(), moveFn:function (a, c, d, e, f, j) {
                d += f;
                e += j;
                b(d, e)
            }}) : m.last().css("visibility", "hidden"));
            return c
        }, remove:function () {
            var a = this;
            if (!a.isCreated)return a;
            a.beforeRemove();
            a.menu && a.hideMenu();
            l(a.dialogs, function () {
                a.hideDialog()
            });
            f(document).unbind("mousedown", a._docMousedownFn);
            a.toolbar.remove();
            a.edit.remove();
            a.statusbar.last().unbind();
            a.statusbar.unbind();
            a.container.remove();
            a.container = a.toolbar = a.edit = a.menu = null;
            a.dialogs = [];
            a.isCreated = !1;
            return a
        }, resize:function (a, b) {
            a !== null && t(a) > this.minWidth && this.container.css("width", s(a));
            b !== null && (b = t(b) - this.toolbar.div.height() - this.statusbar.height(), b > 0 && t(b) > this.minHeight && this.edit.setHeight(b));
            return this
        }, select:function () {
            this.isCreated && this.cmd.select();
            return this
        }, html:function (a) {
            if (a === n)return this.isCreated ? this.edit.html() : aa(this.srcElement);
            this.isCreated ? this.edit.html(a) : aa(this.srcElement,
                a);
            return this
        }, fullHtml:function () {
            return this.isCreated ? this.edit.html(n, !0) : ""
        }, text:function (a) {
            return a === n ? C(this.html().replace(/<(?!img|embed).*?>/ig, "").replace(/&nbsp;/ig, " ")) : this.html(D(a))
        }, isEmpty:function () {
            return C(this.text().replace(/\r\n|\n|\r/, "")) === ""
        }, isDirty:function () {
            return C(this.initContent.replace(/\r\n|\n|\r|t/g, "")) !== C(this.html().replace(/\r\n|\n|\r|t/g, ""))
        }, selectedHtml:function () {
            return this.isCreated ? this.cmd.range.html() : ""
        }, count:function (a) {
            a = (a || "html").toLowerCase();
            if (a === "html")return U(Xa(this.html())).length;
            if (a === "text")return this.text().replace(/<(?:img|embed).*?>/ig, "K").replace(/\r\n|\n|\r/g, "").length;
            return 0
        }, exec:function (a) {
            var a = a.toLowerCase(), b = this.cmd, c = M(a, "selectall,copy,paste,print".split(",")) < 0;
            c && this.addBookmark(!1);
            b[a].apply(b, Da(arguments, 1));
            c && (this.updateState(), this.addBookmark(!1), this.options.afterChange && this.options.afterChange.call(this));
            return this
        }, insertHtml:function (a) {
            if (!this.isCreated)return this;
            a = this.beforeSetHtml(a);
            this.exec("inserthtml", a);
            return this
        }, appendHtml:function (a) {
            this.html(this.html() + a);
            if (this.isCreated)a = this.cmd, a.range.selectNodeContents(a.doc.body).collapse(!1), a.select();
            return this
        }, sync:function () {
            aa(this.srcElement, this.html());
            return this
        }, focus:function () {
            this.isCreated ? this.edit.focus() : this.srcElement[0].focus();
            return this
        }, blur:function () {
            this.isCreated ? this.edit.blur() : this.srcElement[0].blur();
            return this
        }, addBookmark:function (a) {
            var a = k(a, !0), b = this.edit, c = b.doc.body, d = Xa(c.innerHTML);
            if (a && this._undoStack.length > 0 && Math.abs(d.length - U(this._undoStack[this._undoStack.length - 1].html).length) < this.minChangeSize)return this;
            b.designMode && !this._firstAddBookmark ? (b = this.cmd.range, a = b.createBookmark(!0), a.html = Xa(c.innerHTML), b.moveToBookmark(a)) : a = {html:d};
            this._firstAddBookmark = !1;
            Gb(this._undoStack, a);
            return this
        }, undo:function () {
            return Hb.call(this, this._undoStack, this._redoStack)
        }, redo:function () {
            return Hb.call(this, this._redoStack, this._undoStack)
        }, fullscreen:function (a) {
            this.fullscreenMode =
                a === n ? !this.fullscreenMode : a;
            return this.remove().create()
        }, readonly:function (a) {
            var a = k(a, !0), b = this, c = b.edit, d = c.doc;
            b.designMode ? b.toolbar.disableAll(a, []) : l(b.noDisableItems, function () {
                b.toolbar[a ? "disable" : "enable"](this)
            });
            p ? d.body.contentEditable = !a : d.designMode = a ? "off" : "on";
            c.textarea[0].disabled = a
        }, createMenu:function (a) {
            var b = this.toolbar.get(a.name), c = b.pos();
            a.x = c.x;
            a.y = c.y + b.height();
            a.shadowMode = k(a.shadowMode, this.shadowMode);
            a.selectedColor !== n ? (a.cls = "ke-colorpicker-" + this.themeType,
                a.noColor = this.lang("noColor"), this.menu = Ab(a)) : (a.cls = "ke-menu-" + this.themeType, a.centerLineMode = !1, this.menu = Ua(a));
            return this.menu
        }, hideMenu:function () {
            this.menu.remove();
            this.menu = null;
            return this
        }, hideContextmenu:function () {
            this.contextmenu.remove();
            this.contextmenu = null;
            return this
        }, createDialog:function (a) {
            var b = this;
            a.autoScroll = k(a.autoScroll, !0);
            a.shadowMode = k(a.shadowMode, b.shadowMode);
            a.closeBtn = k(a.closeBtn, {name:b.lang("close"), click:function () {
                b.hideDialog();
                p && b.cmd && b.cmd.select()
            }});
            a.noBtn = k(a.noBtn, {name:b.lang(a.yesBtn ? "no" : "close"), click:function () {
                b.hideDialog();
                p && b.cmd && b.cmd.select()
            }});
            if (b.dialogAlignType != "page")a.alignEl = b.container;
            a.cls = "ke-dialog-" + b.themeType;
            if (b.dialogs.length > 0) {
                var c = b.dialogs[b.dialogs.length - 1];
                b.dialogs[0].setMaskIndex(c.z + 2);
                a.z = c.z + 3;
                a.showMask = !1
            }
            a = Cb(a);
            b.dialogs.push(a);
            return a
        }, hideDialog:function () {
            this.dialogs.length > 0 && this.dialogs.pop().remove();
            this.dialogs.length > 0 && this.dialogs[0].setMaskIndex(this.dialogs[this.dialogs.length -
                1].z - 1);
            return this
        }, errorDialog:function (a) {
            var b = this.createDialog({width:750, title:this.lang("uploadError"), body:'<div style="padding:10px 20px;"><iframe frameborder="0" style="width:708px;height:400px;"></iframe></div>'}), b = f("iframe", b.div), c = f.iframeDoc(b);
            c.open();
            c.write(a);
            c.close();
            f(c.body).css("background-color", "#FFF");
            b[0].contentWindow.focus();
            return this
        }};
        p && F < 7 && O(document, "BackgroundImageCache", !0);
        f.editor = function (a) {
            return new Aa(a)
        };
        f.create = function (a, b) {
            function c(a) {
                l(ba,
                    function (b, c) {
                        c.call(a, KindEditor)
                    });
                return a.create()
            }

            b = b || {};
            b.basePath = k(b.basePath, f.basePath);
            b.themesPath = k(b.themesPath, b.basePath + "themes/");
            b.langPath = k(b.langPath, b.basePath + "lang/");
            b.pluginsPath = k(b.pluginsPath, b.basePath + "plugins/");
            if (k(b.loadStyleMode, f.options.loadStyleMode)) {
                var d = k(b.themeType, f.options.themeType);
                Wa(b.themesPath + "default/default.css");
                Wa(b.themesPath + d + "/" + d + ".css")
            }
            if (d = f(a)) {
                b.srcElement = d[0];
                if (!b.width)b.width = d[0].style.width || d.width();
                if (!b.height)b.height =
                    d[0].style.height || d.height();
                var e = new Aa(b);
                if (L[e.langType])return c(e);
                Va(e.langPath + e.langType + ".js?ver=" + encodeURIComponent(f.DEBUG ? Ba : "4.0.5 (2012-01-15)"), function () {
                    return c(e)
                });
                return e
            }
        };
        f.plugin = Db;
        f.lang = Fb;
        Db("core", function (a) {
            var b = this, c = {undo:"Z", redo:"Y", bold:"B", italic:"I", underline:"U", print:"P", selectall:"A"};
            b.afterSetHtml(function () {
                b.options.afterChange && b.options.afterChange.call(b)
            });
            if (b.syncType == "form") {
                for (var d = a(b.srcElement), e = !1; d = d.parent();)if (d.name == "form") {
                    e =
                        !0;
                    break
                }
                if (e) {
                    d.bind("submit", function () {
                        b.sync();
                        b.edit.textarea.remove()
                    });
                    var f = a('[type="reset"]', d);
                    f.click(function () {
                        b.html(b.initContent);
                        b.cmd.selection()
                    });
                    b.beforeRemove(function () {
                        d.unbind();
                        f.unbind()
                    })
                }
            }
            b.clickToolbar("source", function () {
                b.edit.designMode ? (b.toolbar.disableAll(!0), b.edit.design(!1), b.toolbar.select("source")) : (b.toolbar.disableAll(!1), b.edit.design(!0), b.toolbar.unselect("source"));
                b.designMode = b.edit.designMode
            });
            b.afterCreate(function () {
                b.designMode || b.toolbar.disableAll(!0).select("source")
            });
            b.clickToolbar("fullscreen", function () {
                b.fullscreen()
            });
            var g = !1;
            b.afterCreate(function () {
                a(b.edit.doc, b.edit.textarea).keyup(function (a) {
                    a.which == 27 && setTimeout(function () {
                        b.fullscreen()
                    }, 0)
                });
                if (g) {
                    if (p && !b.designMode)return;
                    b.focus()
                }
                g || (g = !0)
            });
            l("undo,redo".split(","), function (a, d) {
                c[d] && b.afterCreate(function () {
                    Ea(this.edit.doc, c[d], function () {
                        b.clickToolbar(d)
                    })
                });
                b.clickToolbar(d, function () {
                    b[d]()
                })
            });
            b.clickToolbar("formatblock", function () {
                var a = b.lang("formatblock.formatBlock"), c = {h1:28,
                    h2:24, h3:18, H4:14, p:12}, d = b.cmd.val("formatblock"), e = b.createMenu({name:"formatblock", width:b.langType == "en" ? 200 : 150});
                l(a, function (a, f) {
                    var h = "font-size:" + c[a] + "px;";
                    a.charAt(0) === "h" && (h += "font-weight:bold;");
                    e.addItem({title:'<span style="' + h + '" unselectable="on">' + f + "</span>", height:c[a] + 12, checked:d === a || d === f, click:function () {
                        b.select().exec("formatblock", "<" + a + ">").hideMenu()
                    }})
                })
            });
            b.clickToolbar("fontname", function () {
                var a = b.cmd.val("fontname"), c = b.createMenu({name:"fontname", width:150});
                l(b.lang("fontname.fontName"), function (d, e) {
                    c.addItem({title:'<span style="font-family: ' + d + ';" unselectable="on">' + e + "</span>", checked:a === d.toLowerCase() || a === e.toLowerCase(), click:function () {
                        b.exec("fontname", d).hideMenu()
                    }})
                })
            });
            b.clickToolbar("fontsize", function () {
                var a = b.cmd.val("fontsize"), c = b.createMenu({name:"fontsize", width:150});
                l(b.fontSizeTable, function (d, e) {
                    c.addItem({title:'<span style="font-size:' + e + ';" unselectable="on">' + e + "</span>", height:t(e) + 12, checked:a === e, click:function () {
                        b.exec("fontsize",
                            e).hideMenu()
                    }})
                })
            });
            l("forecolor,hilitecolor".split(","), function (a, c) {
                b.clickToolbar(c, function () {
                    b.createMenu({name:c, selectedColor:b.cmd.val(c) || "default", colors:b.colorTable, click:function (a) {
                        b.exec(c, a).hideMenu()
                    }})
                })
            });
            l("cut,copy,paste".split(","), function (a, c) {
                b.clickToolbar(c, function () {
                    b.focus();
                    try {
                        b.exec(c, null)
                    } catch (a) {
                        alert(b.lang(c + "Error"))
                    }
                })
            });
            b.clickToolbar("about", function () {
                b.createDialog({name:"about", width:300, title:b.lang("about"), body:'<div style="margin:20px;"><div>KindEditor 4.0.5 (2012-01-15)</div><div>Copyright &copy; <a href="http://www.kindsoft.net/" target="_blank">kindsoft.net</a> All rights reserved.</div></div>'})
            });
            b.plugin.getSelectedLink = function () {
                return b.cmd.commonAncestor("a")
            };
            b.plugin.getSelectedImage = function () {
                return za(b.edit.cmd.range, function (a) {
                    return!/^ke-\w+$/i.test(a[0].className)
                })
            };
            b.plugin.getSelectedFlash = function () {
                return za(b.edit.cmd.range, function (a) {
                    return a[0].className == "ke-flash"
                })
            };
            b.plugin.getSelectedMedia = function () {
                return za(b.edit.cmd.range, function (a) {
                    return a[0].className == "ke-media" || a[0].className == "ke-rm"
                })
            };
            b.plugin.getSelectedAnchor = function () {
                return za(b.edit.cmd.range,
                    function (a) {
                        return a[0].className == "ke-anchor"
                    })
            };
            l("link,image,flash,media,anchor".split(","), function (a, c) {
                var d = c.charAt(0).toUpperCase() + c.substr(1);
                l("edit,delete".split(","), function (a, e) {
                    b.addContextmenu({title:b.lang(e + d), click:function () {
                        b.loadPlugin(c, function () {
                            b.plugin[c][e]();
                            b.hideMenu()
                        })
                    }, cond:b.plugin["getSelected" + d], width:150, iconClass:e == "edit" ? "ke-icon-" + c : n})
                });
                b.addContextmenu({title:"-"})
            });
            b.plugin.getSelectedTable = function () {
                return b.cmd.commonAncestor("table")
            };
            b.plugin.getSelectedRow =
                function () {
                    return b.cmd.commonAncestor("tr")
                };
            b.plugin.getSelectedCell = function () {
                return b.cmd.commonAncestor("td")
            };
            l("prop,cellprop,colinsertleft,colinsertright,rowinsertabove,rowinsertbelow,rowmerge,colmerge,rowsplit,colsplit,coldelete,rowdelete,insert,delete".split(","), function (a, c) {
                var d = M(c, ["prop", "delete"]) < 0 ? b.plugin.getSelectedCell : b.plugin.getSelectedTable;
                b.addContextmenu({title:b.lang("table" + c), click:function () {
                    b.loadPlugin("table", function () {
                        b.plugin.table[c]();
                        b.hideMenu()
                    })
                }, cond:d,
                    width:170, iconClass:"ke-icon-table" + c})
            });
            b.addContextmenu({title:"-"});
            l("selectall,justifyleft,justifycenter,justifyright,justifyfull,insertorderedlist,insertunorderedlist,indent,outdent,subscript,superscript,hr,print,bold,italic,underline,strikethrough,removeformat,unlink".split(","), function (a, d) {
                c[d] && b.afterCreate(function () {
                    Ea(this.edit.doc, c[d], function () {
                        b.cmd.selection();
                        b.clickToolbar(d)
                    })
                });
                b.clickToolbar(d, function () {
                    b.focus().exec(d, null)
                })
            });
            b.afterCreate(function () {
                function c() {
                    e.range.moveToBookmark(f);
                    e.select();
                    ca && (a("div." + i, g).each(function () {
                        a(this).after("<br />").remove(!0)
                    }), a("span.Apple-style-span", g).remove(!0), a("meta", g).remove());
                    var d = g[0].innerHTML;
                    g.remove();
                    d !== "" && (b.pasteType === 2 && (/schemas-microsoft-com|worddocument|mso-\w+/i.test(d) ? d = jb(d, b.filterMode ? b.htmlTags : a.options.htmlTags) : (d = R(d, b.filterMode ? b.htmlTags : null), d = b.beforeSetHtml(d))), b.pasteType === 1 && (d = d.replace(/<br[^>]*>/ig, "\n"), d = d.replace(/<\/p><p[^>]*>/ig, "\n"), d = d.replace(/<[^>]+>/g, ""), d = d.replace(/&nbsp;/ig,
                        " "), d = d.replace(/\n\s*\n/g, "\n"), d = d.replace(/ {2}/g, " &nbsp;"), b.newlineTag == "p" ? /\n/.test(d) && (d = d.replace(/^/, "<p>").replace(/$/, "</p>").replace(/\n/g, "</p><p>")) : d = d.replace(/\n/g, "<br />$&")), b.insertHtml(d))
                }

                var d = b.edit.doc, e, f, g, i = "__kindeditor_paste__", k = !1;
                a(d.body).bind("paste", function (l) {
                    if (b.pasteType === 0)l.stop(); else if (!k) {
                        k = !0;
                        a("div." + i, d).remove();
                        e = b.cmd.selection();
                        f = e.range.createBookmark();
                        g = a('<div class="' + i + '"></div>', d).css({position:"absolute", width:"1px", height:"1px",
                            overflow:"hidden", left:"-1981px", top:a(f.start).pos().y + "px", "white-space":"nowrap"});
                        a(d.body).append(g);
                        if (p) {
                            var n = e.range.get(!0);
                            n.moveToElementText(g[0]);
                            n.select();
                            n.execCommand("paste");
                            l.preventDefault()
                        } else e.range.selectNodeContents(g[0]), e.select();
                        setTimeout(function () {
                            c();
                            k = !1
                        }, 0)
                    }
                })
            });
            b.beforeGetHtml(function (a) {
                return a.replace(/<img[^>]*class="?ke-(flash|rm|media)"?[^>]*>/ig,
                    function (a) {
                        var a = J(a), b = ga(a.style || ""), c = lb(a["data-ke-tag"]);
                        c.width = k(a.width, t(k(b.width, "")));
                        c.height =
                            k(a.height, t(k(b.height, "")));
                        return Ga(c)
                    }).replace(/<img[^>]*class="?ke-anchor"?[^>]*>/ig,
                    function (a) {
                        a = J(a);
                        return'<a name="' + unescape(a["data-ke-name"]) + '"></a>'
                    }).replace(/<div\s+[^>]*data-ke-script-attr="([^"]*)"[^>]*>([\s\S]*?)<\/div>/ig,
                    function (a, b, c) {
                        return"<script" + unescape(b) + ">" + unescape(c) + "<\/script>"
                    }).replace(/(<[^>]*)data-ke-src="([^"]*)"([^>]*>)/ig,
                    function (a, b, c) {
                        a = a.replace(/(\s+(?:href|src)=")[^"]*(")/i, "$1" + c + "$2");
                        return a = a.replace(/\s+data-ke-src="[^"]*"/i, "")
                    }).replace(/(<[^>]+\s)data-ke-(on\w+="[^"]*"[^>]*>)/ig,
                    function (a, b, c) {
                        return b + c
                    })
            });
            b.beforeSetHtml(function (a) {
                return a.replace(/<embed[^>]*type="([^"]+)"[^>]*>(?:<\/embed>)?/ig,
                    function (a) {
                        a = J(a);
                        a.src = k(a.src, "");
                        a.width = k(a.width, 0);
                        a.height = k(a.height, 0);
                        return mb(b.themesPath + "common/blank.gif", a)
                    }).replace(/<a[^>]*name="([^"]+)"[^>]*>(?:<\/a>)?/ig,
                    function (a) {
                        var c = J(a);
                        if (c.href !== n)return a;
                        return'<img class="ke-anchor" src="' + b.themesPath + 'common/anchor.gif" data-ke-name="' + escape(c.name) + '" />'
                    }).replace(/<script([^>]*)>([\s\S]*?)<\/script>/ig,
                    function (a, b, c) {
                        return'<div class="ke-script" data-ke-script-attr="' + escape(b) + '">' + escape(c) + "</div>"
                    }).replace(/(<[^>]*)(href|src)="([^"]*)"([^>]*>)/ig,
                    function (a, b, c, d, e) {
                        if (a.match(/\sdata-ke-src="[^"]*"/i))return a;
                        return b + c + '="' + d + '" data-ke-src="' + d + '"' + e
                    }).replace(/(<[^>]+\s)(on\w+="[^"]*"[^>]*>)/ig,
                    function (a, b, c) {
                        return b + "data-ke-" + c
                    }).replace(/<table[^>]*\s+border="0"[^>]*>/ig, function (a) {
                        if (a.indexOf("ke-zeroborder") >= 0)return a;
                        return Nb(a, "ke-zeroborder")
                    })
            })
        })
    }
})(window);
