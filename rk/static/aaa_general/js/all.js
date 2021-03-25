/*rateYo V2.3.2, A simple and flexible star rating plugin
prashanth pamidi (https://github.com/prrashi)*/
!function(a){"use strict";function b(){var a=!1;return function(b){(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(b)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(b.substr(0,4)))&&(a=!0)}(navigator.userAgent||navigator.vendor||window.opera),a}function c(a,b,c){return a===b?a=b:a===c&&(a=c),a}function d(a,b,c){if(!(a>=b&&a<=c))throw Error("Invalid Rating, expected value between "+b+" and "+c);return a}function e(a){return void 0!==a}function f(a,b,c){var d=c/100*(b-a);return d=Math.round(a+d).toString(16),1===d.length&&(d="0"+d),d}function g(a,b,c){if(!a||!b)return null;c=e(c)?c:0,a=q(a),b=q(b);var d=f(a.r,b.r,c),g=f(a.b,b.b,c);return"#"+d+f(a.g,b.g,c)+g}function h(f,i){function k(a){e(a)||(a=i.rating),Z=a;var b=a/P,c=b*R;b>1&&(c+=(Math.ceil(b)-1)*T),r(i.ratedFill),c=i.rtl?100-c:c,c<0?c=0:c>100&&(c=100),X.css("width",c+"%")}function l(){U=Q*i.numStars+S*(i.numStars-1),R=Q/U*100,T=S/U*100,f.width(U),k()}function n(a){var b=i.starWidth=a;return Q=window.parseFloat(i.starWidth.replace("px","")),W.find("svg").attr({width:i.starWidth,height:b}),X.find("svg").attr({width:i.starWidth,height:b}),l(),f}function p(a){return i.spacing=a,S=parseFloat(i.spacing.replace("px","")),W.find("svg:not(:first-child)").css({"margin-left":a}),X.find("svg:not(:first-child)").css({"margin-left":a}),l(),f}function q(a){return i.normalFill=a,(i.rtl?X:W).find("svg").attr({fill:i.normalFill}),f}function r(a){if(i.multiColor){var b=Z-Y,c=b/i.maxValue*100,d=i.multiColor||{};a=g(d.startColor||o.startColor,d.endColor||o.endColor,c)}else _=a;return i.ratedFill=a,(i.rtl?W:X).find("svg").attr({fill:i.ratedFill}),f}function s(a){a=!!a,i.rtl=a,q(i.normalFill),k()}function t(a){i.multiColor=a,r(a?a:_)}function u(b){i.numStars=b,P=i.maxValue/i.numStars,W.empty(),X.empty();for(var c=0;c<i.numStars;c++)W.append(a(i.starSvg||m)),X.append(a(i.starSvg||m));return n(i.starWidth),q(i.normalFill),p(i.spacing),k(),f}function v(a){return i.maxValue=a,P=i.maxValue/i.numStars,i.rating>a&&C(a),k(),f}function w(a){return i.precision=a,C(i.rating),f}function x(a){return i.halfStar=a,f}function y(a){return i.fullStar=a,f}function z(a){var b=a%P,c=P/2,d=i.halfStar,e=i.fullStar;return e||d?(e||d&&b>c?a+=P-b:(a-=b,b>0&&(a+=c)),a):a}function A(a){var b=W.offset(),c=b.left,d=c+W.width(),e=i.maxValue,f=a.pageX,g=0;if(f<c)g=Y;else if(f>d)g=e;else{var h=(f-c)/(d-c);if(S>0){h*=100;for(var j=h;j>0;)j>R?(g+=P,j-=R+T):(g+=j/R*P,j=0)}else g=h*i.maxValue;g=z(g)}return i.rtl&&(g=e-g),parseFloat(g)}function B(a){return i.readOnly=a,f.attr("readonly",!0),N(),a||(f.removeAttr("readonly"),M()),f}function C(a){var b=a,e=i.maxValue;return"string"==typeof b&&("%"===b[b.length-1]&&(b=b.substr(0,b.length-1),e=100,v(e)),b=parseFloat(b)),d(b,Y,e),b=parseFloat(b.toFixed(i.precision)),c(parseFloat(b),Y,e),i.rating=b,k(),$&&f.trigger("rateyo.set",{rating:b}),f}function D(a){return i.onInit=a,f}function E(a){return i.onSet=a,f}function F(a){return i.onChange=a,f}function G(a){var b=A(a).toFixed(i.precision),d=i.maxValue;b=c(parseFloat(b),Y,d),k(b),f.trigger("rateyo.change",{rating:b})}function H(){b()||(k(),f.trigger("rateyo.change",{rating:i.rating}))}function I(a){var b=A(a).toFixed(i.precision);b=parseFloat(b),O.rating(b)}function J(a,b){i.onInit&&"function"==typeof i.onInit&&i.onInit.apply(this,[b.rating,O])}function K(a,b){i.onChange&&"function"==typeof i.onChange&&i.onChange.apply(this,[b.rating,O])}function L(a,b){i.onSet&&"function"==typeof i.onSet&&i.onSet.apply(this,[b.rating,O])}function M(){f.on("mousemove",G).on("mouseenter",G).on("mouseleave",H).on("click",I).on("rateyo.init",J).on("rateyo.change",K).on("rateyo.set",L)}function N(){f.off("mousemove",G).off("mouseenter",G).off("mouseleave",H).off("click",I).off("rateyo.init",J).off("rateyo.change",K).off("rateyo.set",L)}this.node=f.get(0);var O=this;f.empty().addClass("jq-ry-container");var P,Q,R,S,T,U,V=a("<div/>").addClass("jq-ry-group-wrapper").appendTo(f),W=a("<div/>").addClass("jq-ry-normal-group").addClass("jq-ry-group").appendTo(V),X=a("<div/>").addClass("jq-ry-rated-group").addClass("jq-ry-group").appendTo(V),Y=0,Z=i.rating,$=!1,_=i.ratedFill;this.rating=function(a){return e(a)?(C(a),f):i.rating},this.destroy=function(){return i.readOnly||N(),h.prototype.collection=j(f.get(0),this.collection),f.removeClass("jq-ry-container").children().remove(),f},this.method=function(a){if(!a)throw Error("Method name not specified!");if(!e(this[a]))throw Error("Method "+a+" doesn't exist!");var b=Array.prototype.slice.apply(arguments,[]),c=b.slice(1);return this[a].apply(this,c)},this.option=function(a,b){if(!e(a))return i;var c;switch(a){case"starWidth":c=n;break;case"numStars":c=u;break;case"normalFill":c=q;break;case"ratedFill":c=r;break;case"multiColor":c=t;break;case"maxValue":c=v;break;case"precision":c=w;break;case"rating":c=C;break;case"halfStar":c=x;break;case"fullStar":c=y;break;case"readOnly":c=B;break;case"spacing":c=p;break;case"rtl":c=s;break;case"onInit":c=D;break;case"onSet":c=E;break;case"onChange":c=F;break;default:throw Error("No such option as "+a)}return e(b)?c(b):i[a]},u(i.numStars),B(i.readOnly),i.rtl&&s(i.rtl),this.collection.push(this),this.rating(i.rating,!0),$=!0,f.trigger("rateyo.init",{rating:i.rating})}function i(b,c){var d;return a.each(c,function(){if(b===this.node)return d=this,!1}),d}function j(b,c){return a.each(c,function(a){if(b===this.node){var d=c.slice(0,a),e=c.slice(a+1,c.length);return c=d.concat(e),!1}}),c}function k(b){var c=h.prototype.collection,d=a(this);if(0===d.length)return d;var e=Array.prototype.slice.apply(arguments,[]);if(0===e.length)b=e[0]={};else{if(1!==e.length||"object"!=typeof e[0]){if(e.length>=1&&"string"==typeof e[0]){var f=e[0],g=e.slice(1),j=[];return a.each(d,function(a,b){var d=i(b,c);if(!d)throw Error("Trying to set options before even initialization");var e=d[f];if(!e)throw Error("Method "+f+" does not exist!");var h=e.apply(d,g);j.push(h)}),j=1===j.length?j[0]:j}throw Error("Invalid Arguments")}b=e[0]}return b=a.extend({},n,b),a.each(d,function(){var d=i(this,c);if(d)return d;var e=a(this),f={},g=a.extend({},b);return a.each(e.data(),function(a,b){if(0===a.indexOf("rateyo")){var c=a.replace(/^rateyo/,"");c=c[0].toLowerCase()+c.slice(1),f[c]=b,delete g[c]}}),new h(a(this),a.extend({},f,g))})}function l(){return k.apply(this,Array.prototype.slice.apply(arguments,[]))}var m='<?xml version="1.0" encoding="utf-8"?><svg version="1.1"xmlns="http://www.w3.org/2000/svg"viewBox="0 12.705 512 486.59"x="0px" y="0px"xml:space="preserve"><polygon points="256.814,12.705 317.205,198.566 512.631,198.566 354.529,313.435 414.918,499.295 256.814,384.427 98.713,499.295 159.102,313.435 1,198.566 196.426,198.566 "/></svg>',n={starWidth:"32px",normalFill:"gray",ratedFill:"#f39c12",numStars:5,maxValue:5,precision:1,rating:0,fullStar:!1,halfStar:!1,readOnly:!1,spacing:"0px",rtl:!1,multiColor:null,onInit:null,onChange:null,onSet:null,starSvg:null},o={startColor:"#c0392b",endColor:"#f1c40f"},p=/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i,q=function(a){if(!p.test(a))return null;var b=p.exec(a);return{r:parseInt(b[1],16),g:parseInt(b[2],16),b:parseInt(b[3],16)}};h.prototype.collection=[],window.RateYo=h,a.fn.rateYo=l}(window.jQuery);
//# sourceMappingURL=jquery.rateyo.min.js.map
!function(t){function e(r){if(i[r])return i[r].exports;var s=i[r]={i:r,l:!1,exports:{}};return t[r].call(s.exports,s,s.exports,e),s.l=!0,s.exports}var i={};e.m=t,e.c=i,e.i=function(t){return t},e.d=function(t,i,r){e.o(t,i)||Object.defineProperty(t,i,{configurable:!1,enumerable:!0,get:r})},e.n=function(t){var i=t&&t.__esModule?function(){return t.default}:function(){return t};return e.d(i,"a",i),i},e.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},e.p="",e(e.s=3)}([function(t,e,i){"use strict";function r(t,e){for(var i in t)t.hasOwnProperty(i)&&e(i,t[i])}var s=!1;try{var o=Object.defineProperty({},"passive",{get:function(){s=!0}});window.addEventListener("test",null,o)}catch(t){}t.exports.event=function(t,e,i,r){var o="on"==r?"add":"remove";e.split(" ").forEach(function(e){var r=!1;-1!=["scroll","touchstart","touchmove"].indexOf(e)&&s&&(r={passive:!0}),t[o+"EventListener"](e,i,r)})},t.exports.css=function(t,e,i){var s;if(void 0===i){if("string"==typeof e)return t.style[e];s=e}else s={},s[e]=i;r(s,function(e,i){t.style[e]=i})},t.exports.add=function(t,e){e&&t.classList.add(e)},t.exports.rm=function(t,e){e&&t.classList.remove(e)},t.exports.has=function(t,e){return!!e&&t.classList.contains(e)},t.exports.clone=function(t){var e={};return r(t||{},function(t,i){e[t]=i}),e},t.exports.qs=function(t,e){return t instanceof HTMLElement?t:(e||document).querySelector(t)},t.exports.each=r},function(t,e,i){"use strict";function r(t){var e,i,r=t&&t[0]||t,s="string"==typeof t||r instanceof HTMLElement,o=s?{root:t}:m(t),n={direction:"v",barOnCls:"_scrollbar",resizeDebounce:0,event:p,cssGuru:!1,impact:"scroller",position:"static"};o=o||{};for(var a in n)null==o[a]&&(o[a]=n[a]);e=this&&this instanceof u.jQuery,o._chain?i=o.root:e?o.root=i=this[0]:i=b(o.root||o.scroller);var h=l(i,o.direction),f=+h;if(o.index=f,f==f&&null!==h&&z[f])return z[f];o.root&&o.scroller?o.scroller=b(o.scroller,i):o.scroller=i,o.root=i;var d=c(o);return d.autoUpdate&&d.autoUpdate(),d}function s(t,e){var i=0,r=t;for(void 0!==r.length&&r!==u||(r=[r]);r[i];)e.call(this,r[i],i),i++}function o(){return(new Date).getTime()}function n(t,e,i){t._eventHandlers=t._eventHandlers||[{element:t.scroller,handler:function(e){t.scroll(e)},type:"scroll"},{element:t.root,handler:function(){t.update()},type:"transitionend animationend"},{element:t.scroller,handler:function(){t.update()},type:"keyup"},{element:t.bar,handler:function(e){e.preventDefault(),t.selection(),t.drag.now=1,t.draggingCls&&d(t.root,t.draggingCls)},type:"touchstart mousedown"},{element:document,handler:function(){t.selection(1),t.drag.now=0,t.draggingCls&&g(t.root,t.draggingCls)},type:"mouseup blur touchend"},{element:document,handler:function(e){2!=e.button&&t._pos0(e)},type:"touchstart mousedown"},{element:document,handler:function(e){t.drag.now&&t.drag(e)},type:"mousemove touchmove"},{element:u,handler:function(){t.update()},type:"resize"},{element:t.root,handler:function(){t.update()},type:"sizeChange"},{element:t.clipper,handler:function(){t.clipperOnScroll()},type:"scroll"}],s(t._eventHandlers,function(t){if(t.element)if(t.element.length&&t.element!==u)for(var r=0;r<t.element.length;r++)e(t.element[r],t.type,t.handler,i);else e(t.element,t.type,t.handler,i)})}function l(t,e,i,r){var s="data-baron-"+e+"-id";return"on"==i?t.setAttribute(s,r):"off"==i&&t.removeAttribute(s),t.getAttribute(s)}function c(t){var e=new r.prototype.constructor(t);return n(e,t.event,"on"),l(e.root,t.direction,"on",z.length),z.push(e),e.update(),e}function a(t){if(this.events&&this.events[t])for(var e=0;e<this.events[t].length;e++){var i=Array.prototype.slice.call(arguments,1);this.events[t][e].apply(this,i)}}var h=function(){return this||(0,eval)("this")}(),u=h&&h.window||h,p=i(0).event,f=i(0).css,d=i(0).add,v=i(0).has,g=i(0).rm,m=i(0).clone,b=i(0).qs,y=r,x=["left","top","right","bottom","width","height"],z=[],w={v:{x:"Y",pos:x[1],oppos:x[3],crossPos:x[0],crossOpPos:x[2],size:x[5],crossSize:x[4],crossMinSize:"min-"+x[4],crossMaxSize:"max-"+x[4],client:"clientHeight",crossClient:"clientWidth",scrollEdge:"scrollLeft",offset:"offsetHeight",crossOffset:"offsetWidth",offsetPos:"offsetTop",scroll:"scrollTop",scrollSize:"scrollHeight"},h:{x:"X",pos:x[0],oppos:x[2],crossPos:x[1],crossOpPos:x[3],size:x[4],crossSize:x[5],crossMinSize:"min-"+x[5],crossMaxSize:"max-"+x[5],client:"clientWidth",crossClient:"clientHeight",scrollEdge:"scrollTop",offset:"offsetWidth",crossOffset:"offsetHeight",offsetPos:"offsetLeft",scroll:"scrollLeft",scrollSize:"scrollWidth"}},C=15,S=/[\s\S]*Macintosh[\s\S]*\) Gecko[\s\S]*/,_=S.test(u.navigator&&u.navigator.userAgent);r.prototype={_debounce:function(t,e){var i,r,s=this,n=function(){if(s._disposed)return clearTimeout(i),void(i=s=null);var l=o()-r;l<e&&l>=0?i=setTimeout(n,e-l):(i=null,t())};return function(){r=o(),i||(i=setTimeout(n,e))}},constructor:function(t){function e(t){var e=this.barMinSize||20,i=t;i>0&&i<e&&(i=e),this.bar&&f(this.bar,this.origin.size,parseInt(i,10)+"px")}function i(t){if(this.bar){var e=f(this.bar,this.origin.pos),i=+t+"px";i&&i!=e&&f(this.bar,this.origin.pos,i)}}function r(){return p[this.origin.client]-this.barTopLimit-this.bar[this.origin.offset]}function s(t){return t*r.call(this)+this.barTopLimit}function n(t){return(t-this.barTopLimit)/r.call(this)}function l(){return!1}var c,h,p,m,y,x,z;if(x=o(),this.params=t,this.event=t.event,this.events={},this.root=t.root,this.scroller=b(t.scroller),this.bar=b(t.bar,this.root),p=this.track=b(t.track,this.root),!this.track&&this.bar&&(p=this.bar.parentNode),this.clipper=this.scroller.parentNode,this.direction=t.direction,this.rtl=t.rtl,this.origin=w[this.direction],this.barOnCls=t.barOnCls,this.scrollingCls=t.scrollingCls,this.draggingCls=t.draggingCls,this.impact=t.impact,this.position=t.position,this.rtl=t.rtl,this.barTopLimit=0,this.resizeDebounce=t.resizeDebounce,this.cursor=function(t){return t["client"+this.origin.x]||(((t.originalEvent||t).touches||{})[0]||{})["page"+this.origin.x]},this.pos=function(t){var e="page"+this.origin.x+"Offset",i=this.scroller[e]?e:this.origin.scroll;return void 0!==t&&(this.scroller[i]=t),this.scroller[i]},this.rpos=function(t){var e=this.scroller[this.origin.scrollSize]-this.scroller[this.origin.client];return(t?this.pos(t*e):this.pos())/(e||1)},this.barOn=function(t){if(this.barOnCls){var e=this.scroller[this.origin.client]>=this.scroller[this.origin.scrollSize];t||e?v(this.root,this.barOnCls)&&g(this.root,this.barOnCls):v(this.root,this.barOnCls)||d(this.root,this.barOnCls)}},this._pos0=function(t){h=this.cursor(t)-c},this.drag=function(t){var e=n.call(this,this.cursor(t)-h),i=this.scroller[this.origin.scrollSize]-this.scroller[this.origin.client];this.scroller[this.origin.scroll]=e*i},this.selection=function(t){this.event(document,"selectpos selectstart",l,t?"off":"on")},this.resize=function(){function t(){var t,i,r=e.scroller[e.origin.crossOffset],s=e.scroller[e.origin.crossClient],n=0;if(_?n=C:s>0&&0===r&&(r=s+17),r)if(e.barOn(),"scroller"==e.impact){var l=r-s+n;if("static"==e.position)t=f(e.scroller,e.origin.crossSize),i=e.clipper[e.origin.crossClient]+l+"px",t!=i&&e._setCrossSizes(e.scroller,i);else{var c={},h=e.rtl?"Left":"Right";"h"==e.direction&&(h="Bottom"),c["padding"+h]=l+"px",f(e.scroller,c)}}else t=f(e.clipper,e.origin.crossSize),i=s+"px",t!=i&&e._setCrossSizes(e.clipper,i);Array.prototype.unshift.call(arguments,"resize"),a.apply(e,arguments),x=o()}var e=this,i=void 0===e.resizeDebounce?300:e.resizeDebounce,r=0;o()-x<i&&(clearTimeout(m),r=i),r?m=setTimeout(t,r):t()},this.updatePositions=function(t){var r,o=this;o.bar&&(r=(p[o.origin.client]-o.barTopLimit)*o.scroller[o.origin.client]/o.scroller[o.origin.scrollSize],(t||parseInt(z,10)!=parseInt(r,10))&&(e.call(o,r),z=r),c=s.call(o,o.rpos()),i.call(o,c)),Array.prototype.unshift.call(arguments,"scroll"),a.apply(o,arguments)},this.scroll=function(){var t=this;t.updatePositions(),t.scrollingCls&&(y||d(t.root,t.scrollingCls),clearTimeout(y),y=setTimeout(function(){g(t.root,t.scrollingCls),y=void 0},300))},this.clipperOnScroll=function(){this.rtl?this.clipper[this.origin.scrollEdge]=this.clipper[this.origin.scrollSize]:this.clipper[this.origin.scrollEdge]=0},this._setCrossSizes=function(t,e){var i={};i[this.origin.crossSize]=e,i[this.origin.crossMinSize]=e,i[this.origin.crossMaxSize]=e,f(t,i)},this._dumbCss=function(e){if(!t.cssGuru){var i=e?"hidden":null,r=e?"none":null;f(this.clipper,{overflow:i,msOverflowStyle:r,position:"static"==this.position?"":"relative"});var s=e?"scroll":null,o="v"==this.direction?"y":"x",n={};n["overflow-"+o]=s,n["box-sizing"]="border-box",n.margin="0",n.border="0","absolute"==this.position&&(n.position="absolute",n.top="0","h"==this.direction?n.left=n.right="0":(n.bottom="0",n.right=this.rtl?"0":"",n.left=this.rtl?"":"0")),f(this.scroller,n)}},this._dumbCss(!0),_){var S="paddingRight",O={},T=u.getComputedStyle(this.scroller)[[S]];"h"==t.direction?S="paddingBottom":t.rtl&&(S="paddingLeft");var L=parseInt(T,10);L!=L&&(L=0),O[S]=C+L+"px",f(this.scroller,O)}return this},update:function(t){return a.call(this,"upd",t),this.resize(1),this.updatePositions(1),this},dispose:function(){n(this,this.event,"off"),l(this.root,this.params.direction,"off"),"v"==this.params.direction?this._setCrossSizes(this.scroller,""):this._setCrossSizes(this.clipper,""),this._dumbCss(!1),this.barOn(!0),a.call(this,"dispose"),z[this.params.index]=null,this.params=null,this._disposed=!0},on:function(t,e,i){for(var r=t.split(" "),s=0;s<r.length;s++)"init"==r[s]?e.call(this,i):(this.events[r[s]]=this.events[r[s]]||[],this.events[r[s]].push(function(t){e.call(this,t||i)}))},baron:function(t){return t.root=this.params.root,t.scroller=this.params.scroller,t.direction="v"==this.params.direction?"h":"v",t._chain=!0,r(t)}},r.prototype.constructor.prototype=r.prototype,r.noConflict=function(){return u.baron=y,r},r.version="3.0.1",r.prototype.autoUpdate=i(2)(u),r.prototype.fix=i(5),r.prototype.controls=i(4),t.exports=r},function(t,e,i){"use strict";function r(t){function e(){o.root[o.origin.offset]?r():i()}function i(){s||(s=setInterval(function(){o.root[o.origin.offset]&&(r(),o.update())},300))}function r(){clearInterval(s),s=null}var s,o=this;if(!this._au){var n=o._debounce(function(){o.update()},300);this._observer=new t(function(){e(),o.update(),n()}),this.on("init",function(){o._observer.observe(o.root,{childList:!0,subtree:!0,characterData:!0}),e()}),this.on("dispose",function(){o._observer.disconnect(),r(),delete o._observer}),this._au=!0}}t.exports=function(t){var e=t.MutationObserver||t.WebKitMutationObserver||t.MozMutationObserver||null;return function(){return e?(r.call(this,e),this):this}}},function(t,e,i){var r=i(1);window.baron=r,window.jQuery&&window.jQuery.fn&&(window.jQuery.fn.baron=r)},function(t,e,i){"use strict";var r=i(0).qs;t.exports=function(t){var e,i,s,o,n,l=this;o=t.screen||.9,t.forward&&(e=r(t.forward,this.clipper),n={element:e,handler:function(){var e=l.pos()+(t.delta||30);l.pos(e)},type:"click"},this._eventHandlers.push(n),this.event(n.element,n.type,n.handler,"on")),t.backward&&(i=r(t.backward,this.clipper),n={element:i,handler:function(){var e=l.pos()-(t.delta||30);l.pos(e)},type:"click"},this._eventHandlers.push(n),this.event(n.element,n.type,n.handler,"on")),t.track&&(s=!0===t.track?this.track:r(t.track,this.clipper))&&(n={element:s,handler:function(t){if(t.target==s){var e=t["offset"+l.origin.x],i=l.bar[l.origin.offsetPos],r=0;e<i?r=-1:e>i+l.bar[l.origin.offset]&&(r=1);var n=l.pos()+r*o*l.scroller[l.origin.client];l.pos(n)}},type:"mousedown"},this._eventHandlers.push(n),this.event(n.element,n.type,n.handler,"on"))}},function(t,e,i){"use strict";var r=(i(6),i(0).css),s=i(0).add,o=i(0).rm;t.exports=function(t){function e(t,e,i){var n=e,h=1==i?"pos":"oppos";c<(a.minView||0)&&(n=void 0),r(l[t],this.origin.pos,""),r(l[t],this.origin.oppos,""),o(l[t],a.outside),void 0!==n&&(n+="px",r(l[t],this.origin[h],n),s(l[t],a.outside))}function i(t){try{var e=document.createEvent("WheelEvent");e.initWebKitWheelEvent(t.originalEvent.wheelDeltaX,t.originalEvent.wheelDeltaY),f.dispatchEvent(e),t.preventDefault()}catch(t){}}function n(t){var e;for(var s in t)a[s]=t[s];if(a.elements instanceof HTMLElement?l=[a.elements]:"string"==typeof a.elements?l=this.scroller.querySelectorAll(a.elements):a.elements&&a.elements[0]instanceof HTMLElement&&(l=a.elements),l){c=this.scroller[this.origin.client];for(var o=0;o<l.length;o++)e={},e[this.origin.size]=l[o][this.origin.offset]+"px",l[o].parentNode!==this.scroller&&r(l[o].parentNode,e),e={},e[this.origin.crossSize]=l[o].parentNode[this.origin.crossClient]+"px",r(l[o],e),c-=l[o][this.origin.offset],p[o]=l[o].parentNode[this.origin.offsetPos],h[o]=h[o-1]||0,u[o]=u[o-1]||Math.min(p[o],0),l[o-1]&&(h[o]+=l[o-1][this.origin.offset],u[o]+=l[o-1][this.origin.offset]),0==o&&0==p[o]||(this.event(l[o],"mousewheel",i,"off"),this.event(l[o],"mousewheel",i));a.limiter&&l[0]&&(this.track&&this.track!=this.scroller?(e={},e[this.origin.pos]=l[0].parentNode[this.origin.offset]+"px",r(this.track,e)):this.barTopLimit=l[0].parentNode[this.origin.offset],this.scroll()),!1===a.limiter&&(this.barTopLimit=0)}var n={element:l,handler:function(){for(var t,e=this.parentNode,i=e.offsetTop,r=0;r<l.length;r++)l[r]===this&&(t=r);var s=i-h[t];a.scroll?a.scroll({x1:v.scroller.scrollTop,x2:s}):v.scroller.scrollTop=s},type:"click"};if(a.clickable){this._eventHandlers.push(n);for(var f=0;f<n.element.length;f++)d(n.element[f],n.type,n.handler,"on")}}var l,c,a={outside:"",inside:"",before:"",after:"",past:"",future:"",radius:0,minView:0},h=[],u=[],p=[],f=this.scroller,d=this.event,v=this;this.on("init",n,t);var g=[],m=[];return this.on("init scroll",function(){var t,i,r,n;if(l){var f;for(n=0;n<l.length;n++)t=0,p[n]-this.pos()<u[n]+a.radius?(t=1,i=h[n]):p[n]-this.pos()>u[n]+c-a.radius?(t=2,i=this.scroller[this.origin.client]-l[n][this.origin.offset]-h[n]-c):(t=3,i=void 0),r=!1,(p[n]-this.pos()<u[n]||p[n]-this.pos()>u[n]+c)&&(r=!0),t==g[n]&&r==m[n]||(e.call(this,n,i,t),g[n]=t,m[n]=r,f=!0);if(f)for(n=0;n<l.length;n++)1==g[n]&&a.past&&(s(l[n],a.past),o(l[n],a.future)),2==g[n]&&a.future&&(s(l[n],a.future),o(l[n],a.past)),3==g[n]&&(o(l[n],a.past),o(l[n],a.future),s(l[n],a.inside)),g[n]!=g[n+1]&&1==g[n]?(s(l[n],a.before),o(l[n],a.after)):g[n]!=g[n-1]&&2==g[n]?(s(l[n],a.after),o(l[n],a.before)):(o(l[n],a.before),o(l[n],a.after)),a.grad&&(m[n]?s(l[n],a.grad):o(l[n],a.grad))}}),this.on("resize upd",function(t){n.call(this,t&&t.fix)}),this}},function(t,e){t.exports=function(t,e,i){var r=console[t]||console.log,s=["Baron: "+e,i];Function.prototype.apply.call(r,console,s)}}]);
/*!
  * Bootstrap v5.0.0-beta2 (https://getbootstrap.com/)
  * Copyright 2011-2021 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
  */
!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?module.exports=e():"function"==typeof define&&define.amd?define(e):(t="undefined"!=typeof globalThis?globalThis:t||self).bootstrap=e()}(this,(function(){"use strict";function t(t,e){for(var n=0;n<e.length;n++){var i=e[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}function e(e,n,i){return n&&t(e.prototype,n),i&&t(e,i),e}function n(){return(n=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var n=arguments[e];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(t[i]=n[i])}return t}).apply(this,arguments)}function i(t,e){var n,i;t.prototype=Object.create(e.prototype),t.prototype.constructor=t,n=t,i=e,(Object.setPrototypeOf||function(t,e){return t.__proto__=e,t})(n,i)}var o,r,s=function(t){do{t+=Math.floor(1e6*Math.random())}while(document.getElementById(t));return t},a=function(t){var e=t.getAttribute("data-bs-target");if(!e||"#"===e){var n=t.getAttribute("href");if(!n||!n.includes("#")&&!n.startsWith("."))return null;n.includes("#")&&!n.startsWith("#")&&(n="#"+n.split("#")[1]),e=n&&"#"!==n?n.trim():null}return e},l=function(t){var e=a(t);return e&&document.querySelector(e)?e:null},c=function(t){var e=a(t);return e?document.querySelector(e):null},u=function(t){if(!t)return 0;var e=window.getComputedStyle(t),n=e.transitionDuration,i=e.transitionDelay,o=Number.parseFloat(n),r=Number.parseFloat(i);return o||r?(n=n.split(",")[0],i=i.split(",")[0],1e3*(Number.parseFloat(n)+Number.parseFloat(i))):0},f=function(t){t.dispatchEvent(new Event("transitionend"))},d=function(t){return(t[0]||t).nodeType},h=function(t,e){var n=!1,i=e+5;t.addEventListener("transitionend",(function e(){n=!0,t.removeEventListener("transitionend",e)})),setTimeout((function(){n||f(t)}),i)},p=function(t,e,n){Object.keys(n).forEach((function(i){var o,r=n[i],s=e[i],a=s&&d(s)?"element":null==(o=s)?""+o:{}.toString.call(o).match(/\s([a-z]+)/i)[1].toLowerCase();if(!new RegExp(r).test(a))throw new TypeError(t.toUpperCase()+': Option "'+i+'" provided type "'+a+'" but expected type "'+r+'".')}))},g=function(t){if(!t)return!1;if(t.style&&t.parentNode&&t.parentNode.style){var e=getComputedStyle(t),n=getComputedStyle(t.parentNode);return"none"!==e.display&&"none"!==n.display&&"hidden"!==e.visibility}return!1},m=function(){return function(){}},v=function(t){return t.offsetHeight},_=function(){var t=window.jQuery;return t&&!document.body.hasAttribute("data-bs-no-jquery")?t:null},b="rtl"===document.documentElement.dir,y=function(t,e){var n;n=function(){var n=_();if(n){var i=n.fn[t];n.fn[t]=e.jQueryInterface,n.fn[t].Constructor=e,n.fn[t].noConflict=function(){return n.fn[t]=i,e.jQueryInterface}}},"loading"===document.readyState?document.addEventListener("DOMContentLoaded",n):n()},w=(o={},r=1,{set:function(t,e,n){void 0===t.bsKey&&(t.bsKey={key:e,id:r},r++),o[t.bsKey.id]=n},get:function(t,e){if(!t||void 0===t.bsKey)return null;var n=t.bsKey;return n.key===e?o[n.id]:null},delete:function(t,e){if(void 0!==t.bsKey){var n=t.bsKey;n.key===e&&(delete o[n.id],delete t.bsKey)}}}),E=function(t,e,n){w.set(t,e,n)},T=function(t,e){return w.get(t,e)},k=/[^.]*(?=\..*)\.|.*/,A=/\..*/,L=/::\d+$/,O={},D=1,x={mouseenter:"mouseover",mouseleave:"mouseout"},C=new Set(["click","dblclick","mouseup","mousedown","contextmenu","mousewheel","DOMMouseScroll","mouseover","mouseout","mousemove","selectstart","selectend","keydown","keypress","keyup","orientationchange","touchstart","touchmove","touchend","touchcancel","pointerdown","pointermove","pointerup","pointerleave","pointercancel","gesturestart","gesturechange","gestureend","focus","blur","change","reset","select","submit","focusin","focusout","load","unload","beforeunload","resize","move","DOMContentLoaded","readystatechange","error","abort","scroll"]);function S(t,e){return e&&e+"::"+D++||t.uidEvent||D++}function j(t){var e=S(t);return t.uidEvent=e,O[e]=O[e]||{},O[e]}function N(t,e,n){void 0===n&&(n=null);for(var i=Object.keys(t),o=0,r=i.length;o<r;o++){var s=t[i[o]];if(s.originalHandler===e&&s.delegationSelector===n)return s}return null}function P(t,e,n){var i="string"==typeof e,o=i?n:e,r=t.replace(A,""),s=x[r];return s&&(r=s),C.has(r)||(r=t),[i,o,r]}function I(t,e,n,i,o){if("string"==typeof e&&t){n||(n=i,i=null);var r=P(e,n,i),s=r[0],a=r[1],l=r[2],c=j(t),u=c[l]||(c[l]={}),f=N(u,a,s?n:null);if(f)f.oneOff=f.oneOff&&o;else{var d=S(a,e.replace(k,"")),h=s?function(t,e,n){return function i(o){for(var r=t.querySelectorAll(e),s=o.target;s&&s!==this;s=s.parentNode)for(var a=r.length;a--;)if(r[a]===s)return o.delegateTarget=s,i.oneOff&&B.off(t,o.type,n),n.apply(s,[o]);return null}}(t,n,i):function(t,e){return function n(i){return i.delegateTarget=t,n.oneOff&&B.off(t,i.type,e),e.apply(t,[i])}}(t,n);h.delegationSelector=s?n:null,h.originalHandler=a,h.oneOff=o,h.uidEvent=d,u[d]=h,t.addEventListener(l,h,s)}}}function M(t,e,n,i,o){var r=N(e[n],i,o);r&&(t.removeEventListener(n,r,Boolean(o)),delete e[n][r.uidEvent])}var B={on:function(t,e,n,i){I(t,e,n,i,!1)},one:function(t,e,n,i){I(t,e,n,i,!0)},off:function(t,e,n,i){if("string"==typeof e&&t){var o=P(e,n,i),r=o[0],s=o[1],a=o[2],l=a!==e,c=j(t),u=e.startsWith(".");if(void 0===s){u&&Object.keys(c).forEach((function(n){!function(t,e,n,i){var o=e[n]||{};Object.keys(o).forEach((function(r){if(r.includes(i)){var s=o[r];M(t,e,n,s.originalHandler,s.delegationSelector)}}))}(t,c,n,e.slice(1))}));var f=c[a]||{};Object.keys(f).forEach((function(n){var i=n.replace(L,"");if(!l||e.includes(i)){var o=f[n];M(t,c,a,o.originalHandler,o.delegationSelector)}}))}else{if(!c||!c[a])return;M(t,c,a,s,r?n:null)}}},trigger:function(t,e,n){if("string"!=typeof e||!t)return null;var i,o=_(),r=e.replace(A,""),s=e!==r,a=C.has(r),l=!0,c=!0,u=!1,f=null;return s&&o&&(i=o.Event(e,n),o(t).trigger(i),l=!i.isPropagationStopped(),c=!i.isImmediatePropagationStopped(),u=i.isDefaultPrevented()),a?(f=document.createEvent("HTMLEvents")).initEvent(r,l,!0):f=new CustomEvent(e,{bubbles:l,cancelable:!0}),void 0!==n&&Object.keys(n).forEach((function(t){Object.defineProperty(f,t,{get:function(){return n[t]}})})),u&&f.preventDefault(),c&&t.dispatchEvent(f),f.defaultPrevented&&void 0!==i&&i.preventDefault(),f}},H=function(){function t(t){t&&(this._element=t,E(t,this.constructor.DATA_KEY,this))}return t.prototype.dispose=function(){var t,e;t=this._element,e=this.constructor.DATA_KEY,w.delete(t,e),this._element=null},t.getInstance=function(t){return T(t,this.DATA_KEY)},e(t,null,[{key:"VERSION",get:function(){return"5.0.0-beta2"}}]),t}(),R=function(t){function n(){return t.apply(this,arguments)||this}i(n,t);var o=n.prototype;return o.close=function(t){var e=t?this._getRootElement(t):this._element,n=this._triggerCloseEvent(e);null===n||n.defaultPrevented||this._removeElement(e)},o._getRootElement=function(t){return c(t)||t.closest(".alert")},o._triggerCloseEvent=function(t){return B.trigger(t,"close.bs.alert")},o._removeElement=function(t){var e=this;if(t.classList.remove("show"),t.classList.contains("fade")){var n=u(t);B.one(t,"transitionend",(function(){return e._destroyElement(t)})),h(t,n)}else this._destroyElement(t)},o._destroyElement=function(t){t.parentNode&&t.parentNode.removeChild(t),B.trigger(t,"closed.bs.alert")},n.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.alert");e||(e=new n(this)),"close"===t&&e[t](this)}))},n.handleDismiss=function(t){return function(e){e&&e.preventDefault(),t.close(this)}},e(n,null,[{key:"DATA_KEY",get:function(){return"bs.alert"}}]),n}(H);B.on(document,"click.bs.alert.data-api",'[data-bs-dismiss="alert"]',R.handleDismiss(new R)),y("alert",R);var W=function(t){function n(){return t.apply(this,arguments)||this}return i(n,t),n.prototype.toggle=function(){this._element.setAttribute("aria-pressed",this._element.classList.toggle("active"))},n.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.button");e||(e=new n(this)),"toggle"===t&&e[t]()}))},e(n,null,[{key:"DATA_KEY",get:function(){return"bs.button"}}]),n}(H);function K(t){return"true"===t||"false"!==t&&(t===Number(t).toString()?Number(t):""===t||"null"===t?null:t)}function U(t){return t.replace(/[A-Z]/g,(function(t){return"-"+t.toLowerCase()}))}B.on(document,"click.bs.button.data-api",'[data-bs-toggle="button"]',(function(t){t.preventDefault();var e=t.target.closest('[data-bs-toggle="button"]'),n=T(e,"bs.button");n||(n=new W(e)),n.toggle()})),y("button",W);var z={setDataAttribute:function(t,e,n){t.setAttribute("data-bs-"+U(e),n)},removeDataAttribute:function(t,e){t.removeAttribute("data-bs-"+U(e))},getDataAttributes:function(t){if(!t)return{};var e={};return Object.keys(t.dataset).filter((function(t){return t.startsWith("bs")})).forEach((function(n){var i=n.replace(/^bs/,"");i=i.charAt(0).toLowerCase()+i.slice(1,i.length),e[i]=K(t.dataset[n])})),e},getDataAttribute:function(t,e){return K(t.getAttribute("data-bs-"+U(e)))},offset:function(t){var e=t.getBoundingClientRect();return{top:e.top+document.body.scrollTop,left:e.left+document.body.scrollLeft}},position:function(t){return{top:t.offsetTop,left:t.offsetLeft}}},F=function(t,e){var n;return void 0===e&&(e=document.documentElement),(n=[]).concat.apply(n,Element.prototype.querySelectorAll.call(e,t))},Y=function(t,e){return void 0===e&&(e=document.documentElement),Element.prototype.querySelector.call(e,t)},q=function(t,e){var n;return(n=[]).concat.apply(n,t.children).filter((function(t){return t.matches(e)}))},V=function(t,e){for(var n=t.previousElementSibling;n;){if(n.matches(e))return[n];n=n.previousElementSibling}return[]},X={interval:5e3,keyboard:!0,slide:!1,pause:"hover",wrap:!0,touch:!0},Q={interval:"(number|boolean)",keyboard:"boolean",slide:"(boolean|string)",pause:"(string|boolean)",wrap:"boolean",touch:"boolean"},$=function(t){function o(e,n){var i;return(i=t.call(this,e)||this)._items=null,i._interval=null,i._activeElement=null,i._isPaused=!1,i._isSliding=!1,i.touchTimeout=null,i.touchStartX=0,i.touchDeltaX=0,i._config=i._getConfig(n),i._indicatorsElement=Y(".carousel-indicators",i._element),i._touchSupported="ontouchstart"in document.documentElement||navigator.maxTouchPoints>0,i._pointerEvent=Boolean(window.PointerEvent),i._addEventListeners(),i}i(o,t);var r=o.prototype;return r.next=function(){this._isSliding||this._slide("next")},r.nextWhenVisible=function(){!document.hidden&&g(this._element)&&this.next()},r.prev=function(){this._isSliding||this._slide("prev")},r.pause=function(t){t||(this._isPaused=!0),Y(".carousel-item-next, .carousel-item-prev",this._element)&&(f(this._element),this.cycle(!0)),clearInterval(this._interval),this._interval=null},r.cycle=function(t){t||(this._isPaused=!1),this._interval&&(clearInterval(this._interval),this._interval=null),this._config&&this._config.interval&&!this._isPaused&&(this._updateInterval(),this._interval=setInterval((document.visibilityState?this.nextWhenVisible:this.next).bind(this),this._config.interval))},r.to=function(t){var e=this;this._activeElement=Y(".active.carousel-item",this._element);var n=this._getItemIndex(this._activeElement);if(!(t>this._items.length-1||t<0))if(this._isSliding)B.one(this._element,"slid.bs.carousel",(function(){return e.to(t)}));else{if(n===t)return this.pause(),void this.cycle();var i=t>n?"next":"prev";this._slide(i,this._items[t])}},r.dispose=function(){t.prototype.dispose.call(this),B.off(this._element,".bs.carousel"),this._items=null,this._config=null,this._interval=null,this._isPaused=null,this._isSliding=null,this._activeElement=null,this._indicatorsElement=null},r._getConfig=function(t){return t=n({},X,t),p("carousel",t,Q),t},r._handleSwipe=function(){var t=Math.abs(this.touchDeltaX);if(!(t<=40)){var e=t/this.touchDeltaX;this.touchDeltaX=0,e>0&&(b?this.next():this.prev()),e<0&&(b?this.prev():this.next())}},r._addEventListeners=function(){var t=this;this._config.keyboard&&B.on(this._element,"keydown.bs.carousel",(function(e){return t._keydown(e)})),"hover"===this._config.pause&&(B.on(this._element,"mouseenter.bs.carousel",(function(e){return t.pause(e)})),B.on(this._element,"mouseleave.bs.carousel",(function(e){return t.cycle(e)}))),this._config.touch&&this._touchSupported&&this._addTouchEventListeners()},r._addTouchEventListeners=function(){var t=this,e=function(e){!t._pointerEvent||"pen"!==e.pointerType&&"touch"!==e.pointerType?t._pointerEvent||(t.touchStartX=e.touches[0].clientX):t.touchStartX=e.clientX},n=function(e){!t._pointerEvent||"pen"!==e.pointerType&&"touch"!==e.pointerType||(t.touchDeltaX=e.clientX-t.touchStartX),t._handleSwipe(),"hover"===t._config.pause&&(t.pause(),t.touchTimeout&&clearTimeout(t.touchTimeout),t.touchTimeout=setTimeout((function(e){return t.cycle(e)}),500+t._config.interval))};F(".carousel-item img",this._element).forEach((function(t){B.on(t,"dragstart.bs.carousel",(function(t){return t.preventDefault()}))})),this._pointerEvent?(B.on(this._element,"pointerdown.bs.carousel",(function(t){return e(t)})),B.on(this._element,"pointerup.bs.carousel",(function(t){return n(t)})),this._element.classList.add("pointer-event")):(B.on(this._element,"touchstart.bs.carousel",(function(t){return e(t)})),B.on(this._element,"touchmove.bs.carousel",(function(e){return function(e){e.touches&&e.touches.length>1?t.touchDeltaX=0:t.touchDeltaX=e.touches[0].clientX-t.touchStartX}(e)})),B.on(this._element,"touchend.bs.carousel",(function(t){return n(t)})))},r._keydown=function(t){/input|textarea/i.test(t.target.tagName)||("ArrowLeft"===t.key?(t.preventDefault(),b?this.next():this.prev()):"ArrowRight"===t.key&&(t.preventDefault(),b?this.prev():this.next()))},r._getItemIndex=function(t){return this._items=t&&t.parentNode?F(".carousel-item",t.parentNode):[],this._items.indexOf(t)},r._getItemByDirection=function(t,e){var n="next"===t,i="prev"===t,o=this._getItemIndex(e),r=this._items.length-1;if((i&&0===o||n&&o===r)&&!this._config.wrap)return e;var s=(o+("prev"===t?-1:1))%this._items.length;return-1===s?this._items[this._items.length-1]:this._items[s]},r._triggerSlideEvent=function(t,e){var n=this._getItemIndex(t),i=this._getItemIndex(Y(".active.carousel-item",this._element));return B.trigger(this._element,"slide.bs.carousel",{relatedTarget:t,direction:e,from:i,to:n})},r._setActiveIndicatorElement=function(t){if(this._indicatorsElement){var e=Y(".active",this._indicatorsElement);e.classList.remove("active"),e.removeAttribute("aria-current");for(var n=F("[data-bs-target]",this._indicatorsElement),i=0;i<n.length;i++)if(Number.parseInt(n[i].getAttribute("data-bs-slide-to"),10)===this._getItemIndex(t)){n[i].classList.add("active"),n[i].setAttribute("aria-current","true");break}}},r._updateInterval=function(){var t=this._activeElement||Y(".active.carousel-item",this._element);if(t){var e=Number.parseInt(t.getAttribute("data-bs-interval"),10);e?(this._config.defaultInterval=this._config.defaultInterval||this._config.interval,this._config.interval=e):this._config.interval=this._config.defaultInterval||this._config.interval}},r._slide=function(t,e){var n=this,i=Y(".active.carousel-item",this._element),o=this._getItemIndex(i),r=e||i&&this._getItemByDirection(t,i),s=this._getItemIndex(r),a=Boolean(this._interval),l="next"===t?"carousel-item-start":"carousel-item-end",c="next"===t?"carousel-item-next":"carousel-item-prev",f="next"===t?"left":"right";if(r&&r.classList.contains("active"))this._isSliding=!1;else if(!this._triggerSlideEvent(r,f).defaultPrevented&&i&&r){if(this._isSliding=!0,a&&this.pause(),this._setActiveIndicatorElement(r),this._activeElement=r,this._element.classList.contains("slide")){r.classList.add(c),v(r),i.classList.add(l),r.classList.add(l);var d=u(i);B.one(i,"transitionend",(function(){r.classList.remove(l,c),r.classList.add("active"),i.classList.remove("active",c,l),n._isSliding=!1,setTimeout((function(){B.trigger(n._element,"slid.bs.carousel",{relatedTarget:r,direction:f,from:o,to:s})}),0)})),h(i,d)}else i.classList.remove("active"),r.classList.add("active"),this._isSliding=!1,B.trigger(this._element,"slid.bs.carousel",{relatedTarget:r,direction:f,from:o,to:s});a&&this.cycle()}},o.carouselInterface=function(t,e){var i=T(t,"bs.carousel"),r=n({},X,z.getDataAttributes(t));"object"==typeof e&&(r=n({},r,e));var s="string"==typeof e?e:r.slide;if(i||(i=new o(t,r)),"number"==typeof e)i.to(e);else if("string"==typeof s){if(void 0===i[s])throw new TypeError('No method named "'+s+'"');i[s]()}else r.interval&&r.ride&&(i.pause(),i.cycle())},o.jQueryInterface=function(t){return this.each((function(){o.carouselInterface(this,t)}))},o.dataApiClickHandler=function(t){var e=c(this);if(e&&e.classList.contains("carousel")){var i=n({},z.getDataAttributes(e),z.getDataAttributes(this)),r=this.getAttribute("data-bs-slide-to");r&&(i.interval=!1),o.carouselInterface(e,i),r&&T(e,"bs.carousel").to(r),t.preventDefault()}},e(o,null,[{key:"Default",get:function(){return X}},{key:"DATA_KEY",get:function(){return"bs.carousel"}}]),o}(H);B.on(document,"click.bs.carousel.data-api","[data-bs-slide], [data-bs-slide-to]",$.dataApiClickHandler),B.on(window,"load.bs.carousel.data-api",(function(){for(var t=F('[data-bs-ride="carousel"]'),e=0,n=t.length;e<n;e++)$.carouselInterface(t[e],T(t[e],"bs.carousel"))})),y("carousel",$);var G={toggle:!0,parent:""},Z={toggle:"boolean",parent:"(string|element)"},J=function(t){function o(e,n){var i;(i=t.call(this,e)||this)._isTransitioning=!1,i._config=i._getConfig(n),i._triggerArray=F('[data-bs-toggle="collapse"][href="#'+e.id+'"],[data-bs-toggle="collapse"][data-bs-target="#'+e.id+'"]');for(var o=F('[data-bs-toggle="collapse"]'),r=0,s=o.length;r<s;r++){var a=o[r],c=l(a),u=F(c).filter((function(t){return t===e}));null!==c&&u.length&&(i._selector=c,i._triggerArray.push(a))}return i._parent=i._config.parent?i._getParent():null,i._config.parent||i._addAriaAndCollapsedClass(i._element,i._triggerArray),i._config.toggle&&i.toggle(),i}i(o,t);var r=o.prototype;return r.toggle=function(){this._element.classList.contains("show")?this.hide():this.show()},r.show=function(){var t=this;if(!this._isTransitioning&&!this._element.classList.contains("show")){var e,n;this._parent&&0===(e=F(".show, .collapsing",this._parent).filter((function(e){return"string"==typeof t._config.parent?e.getAttribute("data-bs-parent")===t._config.parent:e.classList.contains("collapse")}))).length&&(e=null);var i=Y(this._selector);if(e){var r=e.find((function(t){return i!==t}));if((n=r?T(r,"bs.collapse"):null)&&n._isTransitioning)return}if(!B.trigger(this._element,"show.bs.collapse").defaultPrevented){e&&e.forEach((function(t){i!==t&&o.collapseInterface(t,"hide"),n||E(t,"bs.collapse",null)}));var s=this._getDimension();this._element.classList.remove("collapse"),this._element.classList.add("collapsing"),this._element.style[s]=0,this._triggerArray.length&&this._triggerArray.forEach((function(t){t.classList.remove("collapsed"),t.setAttribute("aria-expanded",!0)})),this.setTransitioning(!0);var a="scroll"+(s[0].toUpperCase()+s.slice(1)),l=u(this._element);B.one(this._element,"transitionend",(function(){t._element.classList.remove("collapsing"),t._element.classList.add("collapse","show"),t._element.style[s]="",t.setTransitioning(!1),B.trigger(t._element,"shown.bs.collapse")})),h(this._element,l),this._element.style[s]=this._element[a]+"px"}}},r.hide=function(){var t=this;if(!this._isTransitioning&&this._element.classList.contains("show")&&!B.trigger(this._element,"hide.bs.collapse").defaultPrevented){var e=this._getDimension();this._element.style[e]=this._element.getBoundingClientRect()[e]+"px",v(this._element),this._element.classList.add("collapsing"),this._element.classList.remove("collapse","show");var n=this._triggerArray.length;if(n>0)for(var i=0;i<n;i++){var o=this._triggerArray[i],r=c(o);r&&!r.classList.contains("show")&&(o.classList.add("collapsed"),o.setAttribute("aria-expanded",!1))}this.setTransitioning(!0),this._element.style[e]="";var s=u(this._element);B.one(this._element,"transitionend",(function(){t.setTransitioning(!1),t._element.classList.remove("collapsing"),t._element.classList.add("collapse"),B.trigger(t._element,"hidden.bs.collapse")})),h(this._element,s)}},r.setTransitioning=function(t){this._isTransitioning=t},r.dispose=function(){t.prototype.dispose.call(this),this._config=null,this._parent=null,this._triggerArray=null,this._isTransitioning=null},r._getConfig=function(t){return(t=n({},G,t)).toggle=Boolean(t.toggle),p("collapse",t,Z),t},r._getDimension=function(){return this._element.classList.contains("width")?"width":"height"},r._getParent=function(){var t=this,e=this._config.parent;return d(e)?void 0===e.jquery&&void 0===e[0]||(e=e[0]):e=Y(e),F('[data-bs-toggle="collapse"][data-bs-parent="'+e+'"]',e).forEach((function(e){var n=c(e);t._addAriaAndCollapsedClass(n,[e])})),e},r._addAriaAndCollapsedClass=function(t,e){if(t&&e.length){var n=t.classList.contains("show");e.forEach((function(t){n?t.classList.remove("collapsed"):t.classList.add("collapsed"),t.setAttribute("aria-expanded",n)}))}},o.collapseInterface=function(t,e){var i=T(t,"bs.collapse"),r=n({},G,z.getDataAttributes(t),"object"==typeof e&&e?e:{});if(!i&&r.toggle&&"string"==typeof e&&/show|hide/.test(e)&&(r.toggle=!1),i||(i=new o(t,r)),"string"==typeof e){if(void 0===i[e])throw new TypeError('No method named "'+e+'"');i[e]()}},o.jQueryInterface=function(t){return this.each((function(){o.collapseInterface(this,t)}))},e(o,null,[{key:"Default",get:function(){return G}},{key:"DATA_KEY",get:function(){return"bs.collapse"}}]),o}(H);B.on(document,"click.bs.collapse.data-api",'[data-bs-toggle="collapse"]',(function(t){("A"===t.target.tagName||t.delegateTarget&&"A"===t.delegateTarget.tagName)&&t.preventDefault();var e=z.getDataAttributes(this),n=l(this);F(n).forEach((function(t){var n,i=T(t,"bs.collapse");i?(null===i._parent&&"string"==typeof e.parent&&(i._config.parent=e.parent,i._parent=i._getParent()),n="toggle"):n=e,J.collapseInterface(t,n)}))})),y("collapse",J);var tt="top",et="bottom",nt="right",it="left",ot=[tt,et,nt,it],rt=ot.reduce((function(t,e){return t.concat([e+"-start",e+"-end"])}),[]),st=[].concat(ot,["auto"]).reduce((function(t,e){return t.concat([e,e+"-start",e+"-end"])}),[]),at=["beforeRead","read","afterRead","beforeMain","main","afterMain","beforeWrite","write","afterWrite"];function lt(t){return t?(t.nodeName||"").toLowerCase():null}function ct(t){if("[object Window]"!==t.toString()){var e=t.ownerDocument;return e&&e.defaultView||window}return t}function ut(t){return t instanceof ct(t).Element||t instanceof Element}function ft(t){return t instanceof ct(t).HTMLElement||t instanceof HTMLElement}var dt={name:"applyStyles",enabled:!0,phase:"write",fn:function(t){var e=t.state;Object.keys(e.elements).forEach((function(t){var n=e.styles[t]||{},i=e.attributes[t]||{},o=e.elements[t];ft(o)&&lt(o)&&(Object.assign(o.style,n),Object.keys(i).forEach((function(t){var e=i[t];!1===e?o.removeAttribute(t):o.setAttribute(t,!0===e?"":e)})))}))},effect:function(t){var e=t.state,n={popper:{position:e.options.strategy,left:"0",top:"0",margin:"0"},arrow:{position:"absolute"},reference:{}};return Object.assign(e.elements.popper.style,n.popper),e.elements.arrow&&Object.assign(e.elements.arrow.style,n.arrow),function(){Object.keys(e.elements).forEach((function(t){var i=e.elements[t],o=e.attributes[t]||{},r=Object.keys(e.styles.hasOwnProperty(t)?e.styles[t]:n[t]).reduce((function(t,e){return t[e]="",t}),{});ft(i)&&lt(i)&&(Object.assign(i.style,r),Object.keys(o).forEach((function(t){i.removeAttribute(t)})))}))}},requires:["computeStyles"]};function ht(t){return t.split("-")[0]}function pt(t){return{x:t.offsetLeft,y:t.offsetTop,width:t.offsetWidth,height:t.offsetHeight}}function gt(t,e){var n,i=e.getRootNode&&e.getRootNode();if(t.contains(e))return!0;if(i&&((n=i)instanceof ct(n).ShadowRoot||n instanceof ShadowRoot)){var o=e;do{if(o&&t.isSameNode(o))return!0;o=o.parentNode||o.host}while(o)}return!1}function mt(t){return ct(t).getComputedStyle(t)}function vt(t){return["table","td","th"].indexOf(lt(t))>=0}function _t(t){return((ut(t)?t.ownerDocument:t.document)||window.document).documentElement}function bt(t){return"html"===lt(t)?t:t.assignedSlot||t.parentNode||t.host||_t(t)}function yt(t){if(!ft(t)||"fixed"===mt(t).position)return null;var e=t.offsetParent;if(e){var n=_t(e);if("body"===lt(e)&&"static"===mt(e).position&&"static"!==mt(n).position)return n}return e}function wt(t){for(var e=ct(t),n=yt(t);n&&vt(n)&&"static"===mt(n).position;)n=yt(n);return n&&"body"===lt(n)&&"static"===mt(n).position?e:n||function(t){for(var e=bt(t);ft(e)&&["html","body"].indexOf(lt(e))<0;){var n=mt(e);if("none"!==n.transform||"none"!==n.perspective||n.willChange&&"auto"!==n.willChange)return e;e=e.parentNode}return null}(t)||e}function Et(t){return["top","bottom"].indexOf(t)>=0?"x":"y"}function Tt(t,e,n){return Math.max(t,Math.min(e,n))}function kt(t){return Object.assign(Object.assign({},{top:0,right:0,bottom:0,left:0}),t)}function At(t,e){return e.reduce((function(e,n){return e[n]=t,e}),{})}var Lt={name:"arrow",enabled:!0,phase:"main",fn:function(t){var e,n=t.state,i=t.name,o=n.elements.arrow,r=n.modifiersData.popperOffsets,s=ht(n.placement),a=Et(s),l=[it,nt].indexOf(s)>=0?"height":"width";if(o&&r){var c=n.modifiersData[i+"#persistent"].padding,u=pt(o),f="y"===a?tt:it,d="y"===a?et:nt,h=n.rects.reference[l]+n.rects.reference[a]-r[a]-n.rects.popper[l],p=r[a]-n.rects.reference[a],g=wt(o),m=g?"y"===a?g.clientHeight||0:g.clientWidth||0:0,v=h/2-p/2,_=c[f],b=m-u[l]-c[d],y=m/2-u[l]/2+v,w=Tt(_,y,b),E=a;n.modifiersData[i]=((e={})[E]=w,e.centerOffset=w-y,e)}},effect:function(t){var e=t.state,n=t.options,i=t.name,o=n.element,r=void 0===o?"[data-popper-arrow]":o,s=n.padding,a=void 0===s?0:s;null!=r&&("string"!=typeof r||(r=e.elements.popper.querySelector(r)))&&gt(e.elements.popper,r)&&(e.elements.arrow=r,e.modifiersData[i+"#persistent"]={padding:kt("number"!=typeof a?a:At(a,ot))})},requires:["popperOffsets"],requiresIfExists:["preventOverflow"]},Ot={top:"auto",right:"auto",bottom:"auto",left:"auto"};function Dt(t){var e,n=t.popper,i=t.popperRect,o=t.placement,r=t.offsets,s=t.position,a=t.gpuAcceleration,l=t.adaptive,c=t.roundOffsets?function(t){var e=t.x,n=t.y,i=window.devicePixelRatio||1;return{x:Math.round(e*i)/i||0,y:Math.round(n*i)/i||0}}(r):r,u=c.x,f=void 0===u?0:u,d=c.y,h=void 0===d?0:d,p=r.hasOwnProperty("x"),g=r.hasOwnProperty("y"),m=it,v=tt,_=window;if(l){var b=wt(n);b===ct(n)&&(b=_t(n)),o===tt&&(v=et,h-=b.clientHeight-i.height,h*=a?1:-1),o===it&&(m=nt,f-=b.clientWidth-i.width,f*=a?1:-1)}var y,w=Object.assign({position:s},l&&Ot);return a?Object.assign(Object.assign({},w),{},((y={})[v]=g?"0":"",y[m]=p?"0":"",y.transform=(_.devicePixelRatio||1)<2?"translate("+f+"px, "+h+"px)":"translate3d("+f+"px, "+h+"px, 0)",y)):Object.assign(Object.assign({},w),{},((e={})[v]=g?h+"px":"",e[m]=p?f+"px":"",e.transform="",e))}var xt={name:"computeStyles",enabled:!0,phase:"beforeWrite",fn:function(t){var e=t.state,n=t.options,i=n.gpuAcceleration,o=void 0===i||i,r=n.adaptive,s=void 0===r||r,a=n.roundOffsets,l=void 0===a||a,c={placement:ht(e.placement),popper:e.elements.popper,popperRect:e.rects.popper,gpuAcceleration:o};null!=e.modifiersData.popperOffsets&&(e.styles.popper=Object.assign(Object.assign({},e.styles.popper),Dt(Object.assign(Object.assign({},c),{},{offsets:e.modifiersData.popperOffsets,position:e.options.strategy,adaptive:s,roundOffsets:l})))),null!=e.modifiersData.arrow&&(e.styles.arrow=Object.assign(Object.assign({},e.styles.arrow),Dt(Object.assign(Object.assign({},c),{},{offsets:e.modifiersData.arrow,position:"absolute",adaptive:!1,roundOffsets:l})))),e.attributes.popper=Object.assign(Object.assign({},e.attributes.popper),{},{"data-popper-placement":e.placement})},data:{}},Ct={passive:!0},St={name:"eventListeners",enabled:!0,phase:"write",fn:function(){},effect:function(t){var e=t.state,n=t.instance,i=t.options,o=i.scroll,r=void 0===o||o,s=i.resize,a=void 0===s||s,l=ct(e.elements.popper),c=[].concat(e.scrollParents.reference,e.scrollParents.popper);return r&&c.forEach((function(t){t.addEventListener("scroll",n.update,Ct)})),a&&l.addEventListener("resize",n.update,Ct),function(){r&&c.forEach((function(t){t.removeEventListener("scroll",n.update,Ct)})),a&&l.removeEventListener("resize",n.update,Ct)}},data:{}},jt={left:"right",right:"left",bottom:"top",top:"bottom"};function Nt(t){return t.replace(/left|right|bottom|top/g,(function(t){return jt[t]}))}var Pt={start:"end",end:"start"};function It(t){return t.replace(/start|end/g,(function(t){return Pt[t]}))}function Mt(t){var e=t.getBoundingClientRect();return{width:e.width,height:e.height,top:e.top,right:e.right,bottom:e.bottom,left:e.left,x:e.left,y:e.top}}function Bt(t){var e=ct(t);return{scrollLeft:e.pageXOffset,scrollTop:e.pageYOffset}}function Ht(t){return Mt(_t(t)).left+Bt(t).scrollLeft}function Rt(t){var e=mt(t),n=e.overflow,i=e.overflowX,o=e.overflowY;return/auto|scroll|overlay|hidden/.test(n+o+i)}function Wt(t,e){void 0===e&&(e=[]);var n=function t(e){return["html","body","#document"].indexOf(lt(e))>=0?e.ownerDocument.body:ft(e)&&Rt(e)?e:t(bt(e))}(t),i="body"===lt(n),o=ct(n),r=i?[o].concat(o.visualViewport||[],Rt(n)?n:[]):n,s=e.concat(r);return i?s:s.concat(Wt(bt(r)))}function Kt(t){return Object.assign(Object.assign({},t),{},{left:t.x,top:t.y,right:t.x+t.width,bottom:t.y+t.height})}function Ut(t,e){return"viewport"===e?Kt(function(t){var e=ct(t),n=_t(t),i=e.visualViewport,o=n.clientWidth,r=n.clientHeight,s=0,a=0;return i&&(o=i.width,r=i.height,/^((?!chrome|android).)*safari/i.test(navigator.userAgent)||(s=i.offsetLeft,a=i.offsetTop)),{width:o,height:r,x:s+Ht(t),y:a}}(t)):ft(e)?function(t){var e=Mt(t);return e.top=e.top+t.clientTop,e.left=e.left+t.clientLeft,e.bottom=e.top+t.clientHeight,e.right=e.left+t.clientWidth,e.width=t.clientWidth,e.height=t.clientHeight,e.x=e.left,e.y=e.top,e}(e):Kt(function(t){var e=_t(t),n=Bt(t),i=t.ownerDocument.body,o=Math.max(e.scrollWidth,e.clientWidth,i?i.scrollWidth:0,i?i.clientWidth:0),r=Math.max(e.scrollHeight,e.clientHeight,i?i.scrollHeight:0,i?i.clientHeight:0),s=-n.scrollLeft+Ht(t),a=-n.scrollTop;return"rtl"===mt(i||e).direction&&(s+=Math.max(e.clientWidth,i?i.clientWidth:0)-o),{width:o,height:r,x:s,y:a}}(_t(t)))}function zt(t){return t.split("-")[1]}function Ft(t){var e,n=t.reference,i=t.element,o=t.placement,r=o?ht(o):null,s=o?zt(o):null,a=n.x+n.width/2-i.width/2,l=n.y+n.height/2-i.height/2;switch(r){case tt:e={x:a,y:n.y-i.height};break;case et:e={x:a,y:n.y+n.height};break;case nt:e={x:n.x+n.width,y:l};break;case it:e={x:n.x-i.width,y:l};break;default:e={x:n.x,y:n.y}}var c=r?Et(r):null;if(null!=c){var u="y"===c?"height":"width";switch(s){case"start":e[c]=e[c]-(n[u]/2-i[u]/2);break;case"end":e[c]=e[c]+(n[u]/2-i[u]/2)}}return e}function Yt(t,e){void 0===e&&(e={});var n=e,i=n.placement,o=void 0===i?t.placement:i,r=n.boundary,s=void 0===r?"clippingParents":r,a=n.rootBoundary,l=void 0===a?"viewport":a,c=n.elementContext,u=void 0===c?"popper":c,f=n.altBoundary,d=void 0!==f&&f,h=n.padding,p=void 0===h?0:h,g=kt("number"!=typeof p?p:At(p,ot)),m="popper"===u?"reference":"popper",v=t.elements.reference,_=t.rects.popper,b=t.elements[d?m:u],y=function(t,e,n){var i="clippingParents"===e?function(t){var e=Wt(bt(t)),n=["absolute","fixed"].indexOf(mt(t).position)>=0&&ft(t)?wt(t):t;return ut(n)?e.filter((function(t){return ut(t)&&gt(t,n)&&"body"!==lt(t)})):[]}(t):[].concat(e),o=[].concat(i,[n]),r=o[0],s=o.reduce((function(e,n){var i=Ut(t,n);return e.top=Math.max(i.top,e.top),e.right=Math.min(i.right,e.right),e.bottom=Math.min(i.bottom,e.bottom),e.left=Math.max(i.left,e.left),e}),Ut(t,r));return s.width=s.right-s.left,s.height=s.bottom-s.top,s.x=s.left,s.y=s.top,s}(ut(b)?b:b.contextElement||_t(t.elements.popper),s,l),w=Mt(v),E=Ft({reference:w,element:_,strategy:"absolute",placement:o}),T=Kt(Object.assign(Object.assign({},_),E)),k="popper"===u?T:w,A={top:y.top-k.top+g.top,bottom:k.bottom-y.bottom+g.bottom,left:y.left-k.left+g.left,right:k.right-y.right+g.right},L=t.modifiersData.offset;if("popper"===u&&L){var O=L[o];Object.keys(A).forEach((function(t){var e=[nt,et].indexOf(t)>=0?1:-1,n=[tt,et].indexOf(t)>=0?"y":"x";A[t]+=O[n]*e}))}return A}function qt(t,e){void 0===e&&(e={});var n=e,i=n.placement,o=n.boundary,r=n.rootBoundary,s=n.padding,a=n.flipVariations,l=n.allowedAutoPlacements,c=void 0===l?st:l,u=zt(i),f=u?a?rt:rt.filter((function(t){return zt(t)===u})):ot,d=f.filter((function(t){return c.indexOf(t)>=0}));0===d.length&&(d=f);var h=d.reduce((function(e,n){return e[n]=Yt(t,{placement:n,boundary:o,rootBoundary:r,padding:s})[ht(n)],e}),{});return Object.keys(h).sort((function(t,e){return h[t]-h[e]}))}var Vt={name:"flip",enabled:!0,phase:"main",fn:function(t){var e=t.state,n=t.options,i=t.name;if(!e.modifiersData[i]._skip){for(var o=n.mainAxis,r=void 0===o||o,s=n.altAxis,a=void 0===s||s,l=n.fallbackPlacements,c=n.padding,u=n.boundary,f=n.rootBoundary,d=n.altBoundary,h=n.flipVariations,p=void 0===h||h,g=n.allowedAutoPlacements,m=e.options.placement,v=ht(m),_=l||(v!==m&&p?function(t){if("auto"===ht(t))return[];var e=Nt(t);return[It(t),e,It(e)]}(m):[Nt(m)]),b=[m].concat(_).reduce((function(t,n){return t.concat("auto"===ht(n)?qt(e,{placement:n,boundary:u,rootBoundary:f,padding:c,flipVariations:p,allowedAutoPlacements:g}):n)}),[]),y=e.rects.reference,w=e.rects.popper,E=new Map,T=!0,k=b[0],A=0;A<b.length;A++){var L=b[A],O=ht(L),D="start"===zt(L),x=[tt,et].indexOf(O)>=0,C=x?"width":"height",S=Yt(e,{placement:L,boundary:u,rootBoundary:f,altBoundary:d,padding:c}),j=x?D?nt:it:D?et:tt;y[C]>w[C]&&(j=Nt(j));var N=Nt(j),P=[];if(r&&P.push(S[O]<=0),a&&P.push(S[j]<=0,S[N]<=0),P.every((function(t){return t}))){k=L,T=!1;break}E.set(L,P)}if(T)for(var I=function(t){var e=b.find((function(e){var n=E.get(e);if(n)return n.slice(0,t).every((function(t){return t}))}));if(e)return k=e,"break"},M=p?3:1;M>0&&"break"!==I(M);M--);e.placement!==k&&(e.modifiersData[i]._skip=!0,e.placement=k,e.reset=!0)}},requiresIfExists:["offset"],data:{_skip:!1}};function Xt(t,e,n){return void 0===n&&(n={x:0,y:0}),{top:t.top-e.height-n.y,right:t.right-e.width+n.x,bottom:t.bottom-e.height+n.y,left:t.left-e.width-n.x}}function Qt(t){return[tt,nt,et,it].some((function(e){return t[e]>=0}))}var $t={name:"hide",enabled:!0,phase:"main",requiresIfExists:["preventOverflow"],fn:function(t){var e=t.state,n=t.name,i=e.rects.reference,o=e.rects.popper,r=e.modifiersData.preventOverflow,s=Yt(e,{elementContext:"reference"}),a=Yt(e,{altBoundary:!0}),l=Xt(s,i),c=Xt(a,o,r),u=Qt(l),f=Qt(c);e.modifiersData[n]={referenceClippingOffsets:l,popperEscapeOffsets:c,isReferenceHidden:u,hasPopperEscaped:f},e.attributes.popper=Object.assign(Object.assign({},e.attributes.popper),{},{"data-popper-reference-hidden":u,"data-popper-escaped":f})}},Gt={name:"offset",enabled:!0,phase:"main",requires:["popperOffsets"],fn:function(t){var e=t.state,n=t.options,i=t.name,o=n.offset,r=void 0===o?[0,0]:o,s=st.reduce((function(t,n){return t[n]=function(t,e,n){var i=ht(t),o=[it,tt].indexOf(i)>=0?-1:1,r="function"==typeof n?n(Object.assign(Object.assign({},e),{},{placement:t})):n,s=r[0],a=r[1];return s=s||0,a=(a||0)*o,[it,nt].indexOf(i)>=0?{x:a,y:s}:{x:s,y:a}}(n,e.rects,r),t}),{}),a=s[e.placement],l=a.x,c=a.y;null!=e.modifiersData.popperOffsets&&(e.modifiersData.popperOffsets.x+=l,e.modifiersData.popperOffsets.y+=c),e.modifiersData[i]=s}},Zt={name:"popperOffsets",enabled:!0,phase:"read",fn:function(t){var e=t.state,n=t.name;e.modifiersData[n]=Ft({reference:e.rects.reference,element:e.rects.popper,strategy:"absolute",placement:e.placement})},data:{}},Jt={name:"preventOverflow",enabled:!0,phase:"main",fn:function(t){var e=t.state,n=t.options,i=t.name,o=n.mainAxis,r=void 0===o||o,s=n.altAxis,a=void 0!==s&&s,l=n.boundary,c=n.rootBoundary,u=n.altBoundary,f=n.padding,d=n.tether,h=void 0===d||d,p=n.tetherOffset,g=void 0===p?0:p,m=Yt(e,{boundary:l,rootBoundary:c,padding:f,altBoundary:u}),v=ht(e.placement),_=zt(e.placement),b=!_,y=Et(v),w="x"===y?"y":"x",E=e.modifiersData.popperOffsets,T=e.rects.reference,k=e.rects.popper,A="function"==typeof g?g(Object.assign(Object.assign({},e.rects),{},{placement:e.placement})):g,L={x:0,y:0};if(E){if(r){var O="y"===y?tt:it,D="y"===y?et:nt,x="y"===y?"height":"width",C=E[y],S=E[y]+m[O],j=E[y]-m[D],N=h?-k[x]/2:0,P="start"===_?T[x]:k[x],I="start"===_?-k[x]:-T[x],M=e.elements.arrow,B=h&&M?pt(M):{width:0,height:0},H=e.modifiersData["arrow#persistent"]?e.modifiersData["arrow#persistent"].padding:{top:0,right:0,bottom:0,left:0},R=H[O],W=H[D],K=Tt(0,T[x],B[x]),U=b?T[x]/2-N-K-R-A:P-K-R-A,z=b?-T[x]/2+N+K+W+A:I+K+W+A,F=e.elements.arrow&&wt(e.elements.arrow),Y=F?"y"===y?F.clientTop||0:F.clientLeft||0:0,q=e.modifiersData.offset?e.modifiersData.offset[e.placement][y]:0,V=E[y]+U-q-Y,X=E[y]+z-q,Q=Tt(h?Math.min(S,V):S,C,h?Math.max(j,X):j);E[y]=Q,L[y]=Q-C}if(a){var $="x"===y?tt:it,G="x"===y?et:nt,Z=E[w],J=Tt(Z+m[$],Z,Z-m[G]);E[w]=J,L[w]=J-Z}e.modifiersData[i]=L}},requiresIfExists:["offset"]};function te(t,e,n){void 0===n&&(n=!1);var i,o,r=_t(e),s=Mt(t),a=ft(e),l={scrollLeft:0,scrollTop:0},c={x:0,y:0};return(a||!a&&!n)&&(("body"!==lt(e)||Rt(r))&&(l=(i=e)!==ct(i)&&ft(i)?{scrollLeft:(o=i).scrollLeft,scrollTop:o.scrollTop}:Bt(i)),ft(e)?((c=Mt(e)).x+=e.clientLeft,c.y+=e.clientTop):r&&(c.x=Ht(r))),{x:s.left+l.scrollLeft-c.x,y:s.top+l.scrollTop-c.y,width:s.width,height:s.height}}var ee={placement:"bottom",modifiers:[],strategy:"absolute"};function ne(){for(var t=arguments.length,e=new Array(t),n=0;n<t;n++)e[n]=arguments[n];return!e.some((function(t){return!(t&&"function"==typeof t.getBoundingClientRect)}))}function ie(t){void 0===t&&(t={});var e=t,n=e.defaultModifiers,i=void 0===n?[]:n,o=e.defaultOptions,r=void 0===o?ee:o;return function(t,e,n){void 0===n&&(n=r);var o,s,a={placement:"bottom",orderedModifiers:[],options:Object.assign(Object.assign({},ee),r),modifiersData:{},elements:{reference:t,popper:e},attributes:{},styles:{}},l=[],c=!1,u={state:a,setOptions:function(n){f(),a.options=Object.assign(Object.assign(Object.assign({},r),a.options),n),a.scrollParents={reference:ut(t)?Wt(t):t.contextElement?Wt(t.contextElement):[],popper:Wt(e)};var o,s,c=function(t){var e=function(t){var e=new Map,n=new Set,i=[];return t.forEach((function(t){e.set(t.name,t)})),t.forEach((function(t){n.has(t.name)||function t(o){n.add(o.name),[].concat(o.requires||[],o.requiresIfExists||[]).forEach((function(i){if(!n.has(i)){var o=e.get(i);o&&t(o)}})),i.push(o)}(t)})),i}(t);return at.reduce((function(t,n){return t.concat(e.filter((function(t){return t.phase===n})))}),[])}((o=[].concat(i,a.options.modifiers),s=o.reduce((function(t,e){var n=t[e.name];return t[e.name]=n?Object.assign(Object.assign(Object.assign({},n),e),{},{options:Object.assign(Object.assign({},n.options),e.options),data:Object.assign(Object.assign({},n.data),e.data)}):e,t}),{}),Object.keys(s).map((function(t){return s[t]}))));return a.orderedModifiers=c.filter((function(t){return t.enabled})),a.orderedModifiers.forEach((function(t){var e=t.name,n=t.options,i=void 0===n?{}:n,o=t.effect;if("function"==typeof o){var r=o({state:a,name:e,instance:u,options:i});l.push(r||function(){})}})),u.update()},forceUpdate:function(){if(!c){var t=a.elements,e=t.reference,n=t.popper;if(ne(e,n)){a.rects={reference:te(e,wt(n),"fixed"===a.options.strategy),popper:pt(n)},a.reset=!1,a.placement=a.options.placement,a.orderedModifiers.forEach((function(t){return a.modifiersData[t.name]=Object.assign({},t.data)}));for(var i=0;i<a.orderedModifiers.length;i++)if(!0!==a.reset){var o=a.orderedModifiers[i],r=o.fn,s=o.options,l=void 0===s?{}:s,f=o.name;"function"==typeof r&&(a=r({state:a,options:l,name:f,instance:u})||a)}else a.reset=!1,i=-1}}},update:(o=function(){return new Promise((function(t){u.forceUpdate(),t(a)}))},function(){return s||(s=new Promise((function(t){Promise.resolve().then((function(){s=void 0,t(o())}))}))),s}),destroy:function(){f(),c=!0}};if(!ne(t,e))return u;function f(){l.forEach((function(t){return t()})),l=[]}return u.setOptions(n).then((function(t){!c&&n.onFirstUpdate&&n.onFirstUpdate(t)})),u}}var oe=ie(),re=ie({defaultModifiers:[St,Zt,xt,dt]}),se=ie({defaultModifiers:[St,Zt,xt,dt,Gt,Vt,Jt,Lt,$t]}),ae=Object.freeze({__proto__:null,popperGenerator:ie,detectOverflow:Yt,createPopperBase:oe,createPopper:se,createPopperLite:re,top:tt,bottom:et,right:nt,left:it,auto:"auto",basePlacements:ot,start:"start",end:"end",clippingParents:"clippingParents",viewport:"viewport",popper:"popper",reference:"reference",variationPlacements:rt,placements:st,beforeRead:"beforeRead",read:"read",afterRead:"afterRead",beforeMain:"beforeMain",main:"main",afterMain:"afterMain",beforeWrite:"beforeWrite",write:"write",afterWrite:"afterWrite",modifierPhases:at,applyStyles:dt,arrow:Lt,computeStyles:xt,eventListeners:St,flip:Vt,hide:$t,offset:Gt,popperOffsets:Zt,preventOverflow:Jt}),le=new RegExp("ArrowUp|ArrowDown|Escape"),ce=b?"top-end":"top-start",ue=b?"top-start":"top-end",fe=b?"bottom-end":"bottom-start",de=b?"bottom-start":"bottom-end",he=b?"left-start":"right-start",pe=b?"right-start":"left-start",ge={offset:[0,2],flip:!0,boundary:"clippingParents",reference:"toggle",display:"dynamic",popperConfig:null},me={offset:"(array|string|function)",flip:"boolean",boundary:"(string|element)",reference:"(string|element|object)",display:"string",popperConfig:"(null|object|function)"},ve=function(t){function o(e,n){var i;return(i=t.call(this,e)||this)._popper=null,i._config=i._getConfig(n),i._menu=i._getMenuElement(),i._inNavbar=i._detectNavbar(),i._addEventListeners(),i}i(o,t);var r=o.prototype;return r.toggle=function(){if(!this._element.disabled&&!this._element.classList.contains("disabled")){var t=this._element.classList.contains("show");o.clearMenus(),t||this.show()}},r.show=function(){if(!(this._element.disabled||this._element.classList.contains("disabled")||this._menu.classList.contains("show"))){var t=o.getParentFromElement(this._element),e={relatedTarget:this._element};if(!B.trigger(this._element,"show.bs.dropdown",e).defaultPrevented){if(this._inNavbar)z.setDataAttribute(this._menu,"popper","none");else{if(void 0===ae)throw new TypeError("Bootstrap's dropdowns require Popper (https://popper.js.org)");var n=this._element;"parent"===this._config.reference?n=t:d(this._config.reference)?(n=this._config.reference,void 0!==this._config.reference.jquery&&(n=this._config.reference[0])):"object"==typeof this._config.reference&&(n=this._config.reference);var i=this._getPopperConfig(),r=i.modifiers.find((function(t){return"applyStyles"===t.name&&!1===t.enabled}));this._popper=se(n,this._menu,i),r&&z.setDataAttribute(this._menu,"popper","static")}var s;"ontouchstart"in document.documentElement&&!t.closest(".navbar-nav")&&(s=[]).concat.apply(s,document.body.children).forEach((function(t){return B.on(t,"mouseover",null,(function(){}))})),this._element.focus(),this._element.setAttribute("aria-expanded",!0),this._menu.classList.toggle("show"),this._element.classList.toggle("show"),B.trigger(this._element,"shown.bs.dropdown",e)}}},r.hide=function(){if(!this._element.disabled&&!this._element.classList.contains("disabled")&&this._menu.classList.contains("show")){var t={relatedTarget:this._element};B.trigger(this._element,"hide.bs.dropdown",t).defaultPrevented||(this._popper&&this._popper.destroy(),this._menu.classList.toggle("show"),this._element.classList.toggle("show"),z.removeDataAttribute(this._menu,"popper"),B.trigger(this._element,"hidden.bs.dropdown",t))}},r.dispose=function(){t.prototype.dispose.call(this),B.off(this._element,".bs.dropdown"),this._menu=null,this._popper&&(this._popper.destroy(),this._popper=null)},r.update=function(){this._inNavbar=this._detectNavbar(),this._popper&&this._popper.update()},r._addEventListeners=function(){var t=this;B.on(this._element,"click.bs.dropdown",(function(e){e.preventDefault(),e.stopPropagation(),t.toggle()}))},r._getConfig=function(t){if(t=n({},this.constructor.Default,z.getDataAttributes(this._element),t),p("dropdown",t,this.constructor.DefaultType),"object"==typeof t.reference&&!d(t.reference)&&"function"!=typeof t.reference.getBoundingClientRect)throw new TypeError("dropdown".toUpperCase()+': Option "reference" provided type "object" without a required "getBoundingClientRect" method.');return t},r._getMenuElement=function(){return function(t,e){for(var n=t.nextElementSibling;n;){if(n.matches(e))return[n];n=n.nextElementSibling}return[]}(this._element,".dropdown-menu")[0]},r._getPlacement=function(){var t=this._element.parentNode;if(t.classList.contains("dropend"))return he;if(t.classList.contains("dropstart"))return pe;var e="end"===getComputedStyle(this._menu).getPropertyValue("--bs-position").trim();return t.classList.contains("dropup")?e?ue:ce:e?de:fe},r._detectNavbar=function(){return null!==this._element.closest(".navbar")},r._getOffset=function(){var t=this,e=this._config.offset;return"string"==typeof e?e.split(",").map((function(t){return Number.parseInt(t,10)})):"function"==typeof e?function(n){return e(n,t._element)}:e},r._getPopperConfig=function(){var t={placement:this._getPlacement(),modifiers:[{name:"preventOverflow",options:{altBoundary:this._config.flip,boundary:this._config.boundary}},{name:"offset",options:{offset:this._getOffset()}}]};return"static"===this._config.display&&(t.modifiers=[{name:"applyStyles",enabled:!1}]),n({},t,"function"==typeof this._config.popperConfig?this._config.popperConfig(t):this._config.popperConfig)},o.dropdownInterface=function(t,e){var n=T(t,"bs.dropdown");if(n||(n=new o(t,"object"==typeof e?e:null)),"string"==typeof e){if(void 0===n[e])throw new TypeError('No method named "'+e+'"');n[e]()}},o.jQueryInterface=function(t){return this.each((function(){o.dropdownInterface(this,t)}))},o.clearMenus=function(t){if(!t||2!==t.button&&("keyup"!==t.type||"Tab"===t.key))for(var e=F('[data-bs-toggle="dropdown"]'),n=0,i=e.length;n<i;n++){var o=T(e[n],"bs.dropdown"),r={relatedTarget:e[n]};if(t&&"click"===t.type&&(r.clickEvent=t),o){var s,a=o._menu;if(e[n].classList.contains("show")&&!(t&&("click"===t.type&&/input|textarea/i.test(t.target.tagName)||"keyup"===t.type&&"Tab"===t.key)&&a.contains(t.target)||B.trigger(e[n],"hide.bs.dropdown",r).defaultPrevented))"ontouchstart"in document.documentElement&&(s=[]).concat.apply(s,document.body.children).forEach((function(t){return B.off(t,"mouseover",null,(function(){}))})),e[n].setAttribute("aria-expanded","false"),o._popper&&o._popper.destroy(),a.classList.remove("show"),e[n].classList.remove("show"),z.removeDataAttribute(a,"popper"),B.trigger(e[n],"hidden.bs.dropdown",r)}}},o.getParentFromElement=function(t){return c(t)||t.parentNode},o.dataApiKeydownHandler=function(t){if(!(/input|textarea/i.test(t.target.tagName)?"Space"===t.key||"Escape"!==t.key&&("ArrowDown"!==t.key&&"ArrowUp"!==t.key||t.target.closest(".dropdown-menu")):!le.test(t.key))&&(t.preventDefault(),t.stopPropagation(),!this.disabled&&!this.classList.contains("disabled"))){var e=o.getParentFromElement(this),n=this.classList.contains("show");if("Escape"===t.key)return(this.matches('[data-bs-toggle="dropdown"]')?this:V(this,'[data-bs-toggle="dropdown"]')[0]).focus(),void o.clearMenus();if(n||"ArrowUp"!==t.key&&"ArrowDown"!==t.key)if(n&&"Space"!==t.key){var i=F(".dropdown-menu .dropdown-item:not(.disabled):not(:disabled)",e).filter(g);if(i.length){var r=i.indexOf(t.target);"ArrowUp"===t.key&&r>0&&r--,"ArrowDown"===t.key&&r<i.length-1&&r++,i[r=-1===r?0:r].focus()}}else o.clearMenus();else(this.matches('[data-bs-toggle="dropdown"]')?this:V(this,'[data-bs-toggle="dropdown"]')[0]).click()}},e(o,null,[{key:"Default",get:function(){return ge}},{key:"DefaultType",get:function(){return me}},{key:"DATA_KEY",get:function(){return"bs.dropdown"}}]),o}(H);B.on(document,"keydown.bs.dropdown.data-api",'[data-bs-toggle="dropdown"]',ve.dataApiKeydownHandler),B.on(document,"keydown.bs.dropdown.data-api",".dropdown-menu",ve.dataApiKeydownHandler),B.on(document,"click.bs.dropdown.data-api",ve.clearMenus),B.on(document,"keyup.bs.dropdown.data-api",ve.clearMenus),B.on(document,"click.bs.dropdown.data-api",'[data-bs-toggle="dropdown"]',(function(t){t.preventDefault(),t.stopPropagation(),ve.dropdownInterface(this,"toggle")})),B.on(document,"click.bs.dropdown.data-api",".dropdown form",(function(t){return t.stopPropagation()})),y("dropdown",ve);var _e={backdrop:!0,keyboard:!0,focus:!0},be={backdrop:"(boolean|string)",keyboard:"boolean",focus:"boolean"},ye=function(t){function o(e,n){var i;return(i=t.call(this,e)||this)._config=i._getConfig(n),i._dialog=Y(".modal-dialog",e),i._backdrop=null,i._isShown=!1,i._isBodyOverflowing=!1,i._ignoreBackdropClick=!1,i._isTransitioning=!1,i._scrollbarWidth=0,i}i(o,t);var r=o.prototype;return r.toggle=function(t){return this._isShown?this.hide():this.show(t)},r.show=function(t){var e=this;if(!this._isShown&&!this._isTransitioning){this._element.classList.contains("fade")&&(this._isTransitioning=!0);var n=B.trigger(this._element,"show.bs.modal",{relatedTarget:t});this._isShown||n.defaultPrevented||(this._isShown=!0,this._checkScrollbar(),this._setScrollbar(),this._adjustDialog(),this._setEscapeEvent(),this._setResizeEvent(),B.on(this._element,"click.dismiss.bs.modal",'[data-bs-dismiss="modal"]',(function(t){return e.hide(t)})),B.on(this._dialog,"mousedown.dismiss.bs.modal",(function(){B.one(e._element,"mouseup.dismiss.bs.modal",(function(t){t.target===e._element&&(e._ignoreBackdropClick=!0)}))})),this._showBackdrop((function(){return e._showElement(t)})))}},r.hide=function(t){var e=this;if(t&&t.preventDefault(),this._isShown&&!this._isTransitioning&&!B.trigger(this._element,"hide.bs.modal").defaultPrevented){this._isShown=!1;var n=this._element.classList.contains("fade");if(n&&(this._isTransitioning=!0),this._setEscapeEvent(),this._setResizeEvent(),B.off(document,"focusin.bs.modal"),this._element.classList.remove("show"),B.off(this._element,"click.dismiss.bs.modal"),B.off(this._dialog,"mousedown.dismiss.bs.modal"),n){var i=u(this._element);B.one(this._element,"transitionend",(function(t){return e._hideModal(t)})),h(this._element,i)}else this._hideModal()}},r.dispose=function(){[window,this._element,this._dialog].forEach((function(t){return B.off(t,".bs.modal")})),t.prototype.dispose.call(this),B.off(document,"focusin.bs.modal"),this._config=null,this._dialog=null,this._backdrop=null,this._isShown=null,this._isBodyOverflowing=null,this._ignoreBackdropClick=null,this._isTransitioning=null,this._scrollbarWidth=null},r.handleUpdate=function(){this._adjustDialog()},r._getConfig=function(t){return t=n({},_e,t),p("modal",t,be),t},r._showElement=function(t){var e=this,n=this._element.classList.contains("fade"),i=Y(".modal-body",this._dialog);this._element.parentNode&&this._element.parentNode.nodeType===Node.ELEMENT_NODE||document.body.appendChild(this._element),this._element.style.display="block",this._element.removeAttribute("aria-hidden"),this._element.setAttribute("aria-modal",!0),this._element.setAttribute("role","dialog"),this._element.scrollTop=0,i&&(i.scrollTop=0),n&&v(this._element),this._element.classList.add("show"),this._config.focus&&this._enforceFocus();var o=function(){e._config.focus&&e._element.focus(),e._isTransitioning=!1,B.trigger(e._element,"shown.bs.modal",{relatedTarget:t})};if(n){var r=u(this._dialog);B.one(this._dialog,"transitionend",o),h(this._dialog,r)}else o()},r._enforceFocus=function(){var t=this;B.off(document,"focusin.bs.modal"),B.on(document,"focusin.bs.modal",(function(e){document===e.target||t._element===e.target||t._element.contains(e.target)||t._element.focus()}))},r._setEscapeEvent=function(){var t=this;this._isShown?B.on(this._element,"keydown.dismiss.bs.modal",(function(e){t._config.keyboard&&"Escape"===e.key?(e.preventDefault(),t.hide()):t._config.keyboard||"Escape"!==e.key||t._triggerBackdropTransition()})):B.off(this._element,"keydown.dismiss.bs.modal")},r._setResizeEvent=function(){var t=this;this._isShown?B.on(window,"resize.bs.modal",(function(){return t._adjustDialog()})):B.off(window,"resize.bs.modal")},r._hideModal=function(){var t=this;this._element.style.display="none",this._element.setAttribute("aria-hidden",!0),this._element.removeAttribute("aria-modal"),this._element.removeAttribute("role"),this._isTransitioning=!1,this._showBackdrop((function(){document.body.classList.remove("modal-open"),t._resetAdjustments(),t._resetScrollbar(),B.trigger(t._element,"hidden.bs.modal")}))},r._removeBackdrop=function(){this._backdrop.parentNode.removeChild(this._backdrop),this._backdrop=null},r._showBackdrop=function(t){var e=this,n=this._element.classList.contains("fade")?"fade":"";if(this._isShown&&this._config.backdrop){if(this._backdrop=document.createElement("div"),this._backdrop.className="modal-backdrop",n&&this._backdrop.classList.add(n),document.body.appendChild(this._backdrop),B.on(this._element,"click.dismiss.bs.modal",(function(t){e._ignoreBackdropClick?e._ignoreBackdropClick=!1:t.target===t.currentTarget&&("static"===e._config.backdrop?e._triggerBackdropTransition():e.hide())})),n&&v(this._backdrop),this._backdrop.classList.add("show"),!n)return void t();var i=u(this._backdrop);B.one(this._backdrop,"transitionend",t),h(this._backdrop,i)}else if(!this._isShown&&this._backdrop){this._backdrop.classList.remove("show");var o=function(){e._removeBackdrop(),t()};if(this._element.classList.contains("fade")){var r=u(this._backdrop);B.one(this._backdrop,"transitionend",o),h(this._backdrop,r)}else o()}else t()},r._triggerBackdropTransition=function(){var t=this;if(!B.trigger(this._element,"hidePrevented.bs.modal").defaultPrevented){var e=this._element.scrollHeight>document.documentElement.clientHeight;e||(this._element.style.overflowY="hidden"),this._element.classList.add("modal-static");var n=u(this._dialog);B.off(this._element,"transitionend"),B.one(this._element,"transitionend",(function(){t._element.classList.remove("modal-static"),e||(B.one(t._element,"transitionend",(function(){t._element.style.overflowY=""})),h(t._element,n))})),h(this._element,n),this._element.focus()}},r._adjustDialog=function(){var t=this._element.scrollHeight>document.documentElement.clientHeight;(!this._isBodyOverflowing&&t&&!b||this._isBodyOverflowing&&!t&&b)&&(this._element.style.paddingLeft=this._scrollbarWidth+"px"),(this._isBodyOverflowing&&!t&&!b||!this._isBodyOverflowing&&t&&b)&&(this._element.style.paddingRight=this._scrollbarWidth+"px")},r._resetAdjustments=function(){this._element.style.paddingLeft="",this._element.style.paddingRight=""},r._checkScrollbar=function(){var t=document.body.getBoundingClientRect();this._isBodyOverflowing=Math.round(t.left+t.right)<window.innerWidth,this._scrollbarWidth=this._getScrollbarWidth()},r._setScrollbar=function(){var t=this;this._isBodyOverflowing&&(this._setElementAttributes(".fixed-top, .fixed-bottom, .is-fixed, .sticky-top","paddingRight",(function(e){return e+t._scrollbarWidth})),this._setElementAttributes(".sticky-top","marginRight",(function(e){return e-t._scrollbarWidth})),this._setElementAttributes("body","paddingRight",(function(e){return e+t._scrollbarWidth}))),document.body.classList.add("modal-open")},r._setElementAttributes=function(t,e,n){F(t).forEach((function(t){var i=t.style[e],o=window.getComputedStyle(t)[e];z.setDataAttribute(t,e,i),t.style[e]=n(Number.parseFloat(o))+"px"}))},r._resetScrollbar=function(){this._resetElementAttributes(".fixed-top, .fixed-bottom, .is-fixed, .sticky-top","paddingRight"),this._resetElementAttributes(".sticky-top","marginRight"),this._resetElementAttributes("body","paddingRight")},r._resetElementAttributes=function(t,e){F(t).forEach((function(t){var n=z.getDataAttribute(t,e);void 0===n&&t===document.body?t.style[e]="":(z.removeDataAttribute(t,e),t.style[e]=n)}))},r._getScrollbarWidth=function(){var t=document.createElement("div");t.className="modal-scrollbar-measure",document.body.appendChild(t);var e=t.getBoundingClientRect().width-t.clientWidth;return document.body.removeChild(t),e},o.jQueryInterface=function(t,e){return this.each((function(){var i=T(this,"bs.modal"),r=n({},_e,z.getDataAttributes(this),"object"==typeof t&&t?t:{});if(i||(i=new o(this,r)),"string"==typeof t){if(void 0===i[t])throw new TypeError('No method named "'+t+'"');i[t](e)}}))},e(o,null,[{key:"Default",get:function(){return _e}},{key:"DATA_KEY",get:function(){return"bs.modal"}}]),o}(H);B.on(document,"click.bs.modal.data-api",'[data-bs-toggle="modal"]',(function(t){var e=this,i=c(this);"A"!==this.tagName&&"AREA"!==this.tagName||t.preventDefault(),B.one(i,"show.bs.modal",(function(t){t.defaultPrevented||B.one(i,"hidden.bs.modal",(function(){g(e)&&e.focus()}))}));var o=T(i,"bs.modal");if(!o){var r=n({},z.getDataAttributes(i),z.getDataAttributes(this));o=new ye(i,r)}o.toggle(this)})),y("modal",ye);var we=new Set(["background","cite","href","itemtype","longdesc","poster","src","xlink:href"]),Ee=/^(?:(?:https?|mailto|ftp|tel|file):|[^#&/:?]*(?:[#/?]|$))/gi,Te=/^data:(?:image\/(?:bmp|gif|jpeg|jpg|png|tiff|webp)|video\/(?:mpeg|mp4|ogg|webm)|audio\/(?:mp3|oga|ogg|opus));base64,[\d+/a-z]+=*$/i;function ke(t,e,n){var i;if(!t.length)return t;if(n&&"function"==typeof n)return n(t);for(var o=(new window.DOMParser).parseFromString(t,"text/html"),r=Object.keys(e),s=(i=[]).concat.apply(i,o.body.querySelectorAll("*")),a=function(t,n){var i,o=s[t],a=o.nodeName.toLowerCase();if(!r.includes(a))return o.parentNode.removeChild(o),"continue";var l=(i=[]).concat.apply(i,o.attributes),c=[].concat(e["*"]||[],e[a]||[]);l.forEach((function(t){(function(t,e){var n=t.nodeName.toLowerCase();if(e.includes(n))return!we.has(n)||Boolean(Ee.test(t.nodeValue)||Te.test(t.nodeValue));for(var i=e.filter((function(t){return t instanceof RegExp})),o=0,r=i.length;o<r;o++)if(i[o].test(n))return!0;return!1})(t,c)||o.removeAttribute(t.nodeName)}))},l=0,c=s.length;l<c;l++)a(l);return o.body.innerHTML}var Ae=new RegExp("(^|\\s)bs-tooltip\\S+","g"),Le=new Set(["sanitize","allowList","sanitizeFn"]),Oe={animation:"boolean",template:"string",title:"(string|element|function)",trigger:"string",delay:"(number|object)",html:"boolean",selector:"(string|boolean)",placement:"(string|function)",offset:"(array|string|function)",container:"(string|element|boolean)",fallbackPlacements:"array",boundary:"(string|element)",customClass:"(string|function)",sanitize:"boolean",sanitizeFn:"(null|function)",allowList:"object",popperConfig:"(null|object|function)"},De={AUTO:"auto",TOP:"top",RIGHT:b?"left":"right",BOTTOM:"bottom",LEFT:b?"right":"left"},xe={animation:!0,template:'<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',trigger:"hover focus",title:"",delay:0,html:!1,selector:!1,placement:"top",offset:[0,0],container:!1,fallbackPlacements:["top","right","bottom","left"],boundary:"clippingParents",customClass:"",sanitize:!0,sanitizeFn:null,allowList:{"*":["class","dir","id","lang","role",/^aria-[\w-]*$/i],a:["target","href","title","rel"],area:[],b:[],br:[],col:[],code:[],div:[],em:[],hr:[],h1:[],h2:[],h3:[],h4:[],h5:[],h6:[],i:[],img:["src","srcset","alt","title","width","height"],li:[],ol:[],p:[],pre:[],s:[],small:[],span:[],sub:[],sup:[],strong:[],u:[],ul:[]},popperConfig:null},Ce={HIDE:"hide.bs.tooltip",HIDDEN:"hidden.bs.tooltip",SHOW:"show.bs.tooltip",SHOWN:"shown.bs.tooltip",INSERTED:"inserted.bs.tooltip",CLICK:"click.bs.tooltip",FOCUSIN:"focusin.bs.tooltip",FOCUSOUT:"focusout.bs.tooltip",MOUSEENTER:"mouseenter.bs.tooltip",MOUSELEAVE:"mouseleave.bs.tooltip"},Se=function(t){function o(e,n){var i;if(void 0===ae)throw new TypeError("Bootstrap's tooltips require Popper (https://popper.js.org)");return(i=t.call(this,e)||this)._isEnabled=!0,i._timeout=0,i._hoverState="",i._activeTrigger={},i._popper=null,i.config=i._getConfig(n),i.tip=null,i._setListeners(),i}i(o,t);var r=o.prototype;return r.enable=function(){this._isEnabled=!0},r.disable=function(){this._isEnabled=!1},r.toggleEnabled=function(){this._isEnabled=!this._isEnabled},r.toggle=function(t){if(this._isEnabled)if(t){var e=this._initializeOnDelegatedTarget(t);e._activeTrigger.click=!e._activeTrigger.click,e._isWithActiveTrigger()?e._enter(null,e):e._leave(null,e)}else{if(this.getTipElement().classList.contains("show"))return void this._leave(null,this);this._enter(null,this)}},r.dispose=function(){clearTimeout(this._timeout),B.off(this._element,this.constructor.EVENT_KEY),B.off(this._element.closest(".modal"),"hide.bs.modal",this._hideModalHandler),this.tip&&this.tip.parentNode&&this.tip.parentNode.removeChild(this.tip),this._isEnabled=null,this._timeout=null,this._hoverState=null,this._activeTrigger=null,this._popper&&this._popper.destroy(),this._popper=null,this.config=null,this.tip=null,t.prototype.dispose.call(this)},r.show=function(){var t=this;if("none"===this._element.style.display)throw new Error("Please use show on visible elements");if(this.isWithContent()&&this._isEnabled){var e=B.trigger(this._element,this.constructor.Event.SHOW),n=function t(e){if(!document.documentElement.attachShadow)return null;if("function"==typeof e.getRootNode){var n=e.getRootNode();return n instanceof ShadowRoot?n:null}return e instanceof ShadowRoot?e:e.parentNode?t(e.parentNode):null}(this._element),i=null===n?this._element.ownerDocument.documentElement.contains(this._element):n.contains(this._element);if(!e.defaultPrevented&&i){var o=this.getTipElement(),r=s(this.constructor.NAME);o.setAttribute("id",r),this._element.setAttribute("aria-describedby",r),this.setContent(),this.config.animation&&o.classList.add("fade");var a="function"==typeof this.config.placement?this.config.placement.call(this,o,this._element):this.config.placement,l=this._getAttachment(a);this._addAttachmentClass(l);var c=this._getContainer();E(o,this.constructor.DATA_KEY,this),this._element.ownerDocument.documentElement.contains(this.tip)||c.appendChild(o),B.trigger(this._element,this.constructor.Event.INSERTED),this._popper=se(this._element,o,this._getPopperConfig(l)),o.classList.add("show");var f,d,p="function"==typeof this.config.customClass?this.config.customClass():this.config.customClass;p&&(f=o.classList).add.apply(f,p.split(" ")),"ontouchstart"in document.documentElement&&(d=[]).concat.apply(d,document.body.children).forEach((function(t){B.on(t,"mouseover",(function(){}))}));var g=function(){var e=t._hoverState;t._hoverState=null,B.trigger(t._element,t.constructor.Event.SHOWN),"out"===e&&t._leave(null,t)};if(this.tip.classList.contains("fade")){var m=u(this.tip);B.one(this.tip,"transitionend",g),h(this.tip,m)}else g()}}},r.hide=function(){var t=this;if(this._popper){var e=this.getTipElement(),n=function(){"show"!==t._hoverState&&e.parentNode&&e.parentNode.removeChild(e),t._cleanTipClass(),t._element.removeAttribute("aria-describedby"),B.trigger(t._element,t.constructor.Event.HIDDEN),t._popper&&(t._popper.destroy(),t._popper=null)};if(!B.trigger(this._element,this.constructor.Event.HIDE).defaultPrevented){var i;if(e.classList.remove("show"),"ontouchstart"in document.documentElement&&(i=[]).concat.apply(i,document.body.children).forEach((function(t){return B.off(t,"mouseover",m)})),this._activeTrigger.click=!1,this._activeTrigger.focus=!1,this._activeTrigger.hover=!1,this.tip.classList.contains("fade")){var o=u(e);B.one(e,"transitionend",n),h(e,o)}else n();this._hoverState=""}}},r.update=function(){null!==this._popper&&this._popper.update()},r.isWithContent=function(){return Boolean(this.getTitle())},r.getTipElement=function(){if(this.tip)return this.tip;var t=document.createElement("div");return t.innerHTML=this.config.template,this.tip=t.children[0],this.tip},r.setContent=function(){var t=this.getTipElement();this.setElementContent(Y(".tooltip-inner",t),this.getTitle()),t.classList.remove("fade","show")},r.setElementContent=function(t,e){if(null!==t)return"object"==typeof e&&d(e)?(e.jquery&&(e=e[0]),void(this.config.html?e.parentNode!==t&&(t.innerHTML="",t.appendChild(e)):t.textContent=e.textContent)):void(this.config.html?(this.config.sanitize&&(e=ke(e,this.config.allowList,this.config.sanitizeFn)),t.innerHTML=e):t.textContent=e)},r.getTitle=function(){var t=this._element.getAttribute("data-bs-original-title");return t||(t="function"==typeof this.config.title?this.config.title.call(this._element):this.config.title),t},r.updateAttachment=function(t){return"right"===t?"end":"left"===t?"start":t},r._initializeOnDelegatedTarget=function(t,e){var n=this.constructor.DATA_KEY;return(e=e||T(t.delegateTarget,n))||(e=new this.constructor(t.delegateTarget,this._getDelegateConfig()),E(t.delegateTarget,n,e)),e},r._getOffset=function(){var t=this,e=this.config.offset;return"string"==typeof e?e.split(",").map((function(t){return Number.parseInt(t,10)})):"function"==typeof e?function(n){return e(n,t._element)}:e},r._getPopperConfig=function(t){var e=this,i={placement:t,modifiers:[{name:"flip",options:{altBoundary:!0,fallbackPlacements:this.config.fallbackPlacements}},{name:"offset",options:{offset:this._getOffset()}},{name:"preventOverflow",options:{boundary:this.config.boundary}},{name:"arrow",options:{element:"."+this.constructor.NAME+"-arrow"}},{name:"onChange",enabled:!0,phase:"afterWrite",fn:function(t){return e._handlePopperPlacementChange(t)}}],onFirstUpdate:function(t){t.options.placement!==t.placement&&e._handlePopperPlacementChange(t)}};return n({},i,"function"==typeof this.config.popperConfig?this.config.popperConfig(i):this.config.popperConfig)},r._addAttachmentClass=function(t){this.getTipElement().classList.add("bs-tooltip-"+this.updateAttachment(t))},r._getContainer=function(){return!1===this.config.container?document.body:d(this.config.container)?this.config.container:Y(this.config.container)},r._getAttachment=function(t){return De[t.toUpperCase()]},r._setListeners=function(){var t=this;this.config.trigger.split(" ").forEach((function(e){if("click"===e)B.on(t._element,t.constructor.Event.CLICK,t.config.selector,(function(e){return t.toggle(e)}));else if("manual"!==e){var n="hover"===e?t.constructor.Event.MOUSEENTER:t.constructor.Event.FOCUSIN,i="hover"===e?t.constructor.Event.MOUSELEAVE:t.constructor.Event.FOCUSOUT;B.on(t._element,n,t.config.selector,(function(e){return t._enter(e)})),B.on(t._element,i,t.config.selector,(function(e){return t._leave(e)}))}})),this._hideModalHandler=function(){t._element&&t.hide()},B.on(this._element.closest(".modal"),"hide.bs.modal",this._hideModalHandler),this.config.selector?this.config=n({},this.config,{trigger:"manual",selector:""}):this._fixTitle()},r._fixTitle=function(){var t=this._element.getAttribute("title"),e=typeof this._element.getAttribute("data-bs-original-title");(t||"string"!==e)&&(this._element.setAttribute("data-bs-original-title",t||""),!t||this._element.getAttribute("aria-label")||this._element.textContent||this._element.setAttribute("aria-label",t),this._element.setAttribute("title",""))},r._enter=function(t,e){e=this._initializeOnDelegatedTarget(t,e),t&&(e._activeTrigger["focusin"===t.type?"focus":"hover"]=!0),e.getTipElement().classList.contains("show")||"show"===e._hoverState?e._hoverState="show":(clearTimeout(e._timeout),e._hoverState="show",e.config.delay&&e.config.delay.show?e._timeout=setTimeout((function(){"show"===e._hoverState&&e.show()}),e.config.delay.show):e.show())},r._leave=function(t,e){e=this._initializeOnDelegatedTarget(t,e),t&&(e._activeTrigger["focusout"===t.type?"focus":"hover"]=!1),e._isWithActiveTrigger()||(clearTimeout(e._timeout),e._hoverState="out",e.config.delay&&e.config.delay.hide?e._timeout=setTimeout((function(){"out"===e._hoverState&&e.hide()}),e.config.delay.hide):e.hide())},r._isWithActiveTrigger=function(){for(var t in this._activeTrigger)if(this._activeTrigger[t])return!0;return!1},r._getConfig=function(t){var e=z.getDataAttributes(this._element);return Object.keys(e).forEach((function(t){Le.has(t)&&delete e[t]})),t&&"object"==typeof t.container&&t.container.jquery&&(t.container=t.container[0]),"number"==typeof(t=n({},this.constructor.Default,e,"object"==typeof t&&t?t:{})).delay&&(t.delay={show:t.delay,hide:t.delay}),"number"==typeof t.title&&(t.title=t.title.toString()),"number"==typeof t.content&&(t.content=t.content.toString()),p("tooltip",t,this.constructor.DefaultType),t.sanitize&&(t.template=ke(t.template,t.allowList,t.sanitizeFn)),t},r._getDelegateConfig=function(){var t={};if(this.config)for(var e in this.config)this.constructor.Default[e]!==this.config[e]&&(t[e]=this.config[e]);return t},r._cleanTipClass=function(){var t=this.getTipElement(),e=t.getAttribute("class").match(Ae);null!==e&&e.length>0&&e.map((function(t){return t.trim()})).forEach((function(e){return t.classList.remove(e)}))},r._handlePopperPlacementChange=function(t){var e=t.state;e&&(this.tip=e.elements.popper,this._cleanTipClass(),this._addAttachmentClass(this._getAttachment(e.placement)))},o.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.tooltip"),n="object"==typeof t&&t;if((e||!/dispose|hide/.test(t))&&(e||(e=new o(this,n)),"string"==typeof t)){if(void 0===e[t])throw new TypeError('No method named "'+t+'"');e[t]()}}))},e(o,null,[{key:"Default",get:function(){return xe}},{key:"NAME",get:function(){return"tooltip"}},{key:"DATA_KEY",get:function(){return"bs.tooltip"}},{key:"Event",get:function(){return Ce}},{key:"EVENT_KEY",get:function(){return".bs.tooltip"}},{key:"DefaultType",get:function(){return Oe}}]),o}(H);y("tooltip",Se);var je=new RegExp("(^|\\s)bs-popover\\S+","g"),Ne=n({},Se.Default,{placement:"right",offset:[0,8],trigger:"click",content:"",template:'<div class="popover" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'}),Pe=n({},Se.DefaultType,{content:"(string|element|function)"}),Ie={HIDE:"hide.bs.popover",HIDDEN:"hidden.bs.popover",SHOW:"show.bs.popover",SHOWN:"shown.bs.popover",INSERTED:"inserted.bs.popover",CLICK:"click.bs.popover",FOCUSIN:"focusin.bs.popover",FOCUSOUT:"focusout.bs.popover",MOUSEENTER:"mouseenter.bs.popover",MOUSELEAVE:"mouseleave.bs.popover"},Me=function(t){function n(){return t.apply(this,arguments)||this}i(n,t);var o=n.prototype;return o.isWithContent=function(){return this.getTitle()||this._getContent()},o.setContent=function(){var t=this.getTipElement();this.setElementContent(Y(".popover-header",t),this.getTitle());var e=this._getContent();"function"==typeof e&&(e=e.call(this._element)),this.setElementContent(Y(".popover-body",t),e),t.classList.remove("fade","show")},o._addAttachmentClass=function(t){this.getTipElement().classList.add("bs-popover-"+this.updateAttachment(t))},o._getContent=function(){return this._element.getAttribute("data-bs-content")||this.config.content},o._cleanTipClass=function(){var t=this.getTipElement(),e=t.getAttribute("class").match(je);null!==e&&e.length>0&&e.map((function(t){return t.trim()})).forEach((function(e){return t.classList.remove(e)}))},n.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.popover"),i="object"==typeof t?t:null;if((e||!/dispose|hide/.test(t))&&(e||(e=new n(this,i),E(this,"bs.popover",e)),"string"==typeof t)){if(void 0===e[t])throw new TypeError('No method named "'+t+'"');e[t]()}}))},e(n,null,[{key:"Default",get:function(){return Ne}},{key:"NAME",get:function(){return"popover"}},{key:"DATA_KEY",get:function(){return"bs.popover"}},{key:"Event",get:function(){return Ie}},{key:"EVENT_KEY",get:function(){return".bs.popover"}},{key:"DefaultType",get:function(){return Pe}}]),n}(Se);y("popover",Me);var Be={offset:10,method:"auto",target:""},He={offset:"number",method:"string",target:"(string|element)"},Re=function(t){function o(e,n){var i;return(i=t.call(this,e)||this)._scrollElement="BODY"===e.tagName?window:e,i._config=i._getConfig(n),i._selector=i._config.target+" .nav-link, "+i._config.target+" .list-group-item, "+i._config.target+" .dropdown-item",i._offsets=[],i._targets=[],i._activeTarget=null,i._scrollHeight=0,B.on(i._scrollElement,"scroll.bs.scrollspy",(function(){return i._process()})),i.refresh(),i._process(),i}i(o,t);var r=o.prototype;return r.refresh=function(){var t=this,e=this._scrollElement===this._scrollElement.window?"offset":"position",n="auto"===this._config.method?e:this._config.method,i="position"===n?this._getScrollTop():0;this._offsets=[],this._targets=[],this._scrollHeight=this._getScrollHeight(),F(this._selector).map((function(t){var e=l(t),o=e?Y(e):null;if(o){var r=o.getBoundingClientRect();if(r.width||r.height)return[z[n](o).top+i,e]}return null})).filter((function(t){return t})).sort((function(t,e){return t[0]-e[0]})).forEach((function(e){t._offsets.push(e[0]),t._targets.push(e[1])}))},r.dispose=function(){t.prototype.dispose.call(this),B.off(this._scrollElement,".bs.scrollspy"),this._scrollElement=null,this._config=null,this._selector=null,this._offsets=null,this._targets=null,this._activeTarget=null,this._scrollHeight=null},r._getConfig=function(t){if("string"!=typeof(t=n({},Be,"object"==typeof t&&t?t:{})).target&&d(t.target)){var e=t.target.id;e||(e=s("scrollspy"),t.target.id=e),t.target="#"+e}return p("scrollspy",t,He),t},r._getScrollTop=function(){return this._scrollElement===window?this._scrollElement.pageYOffset:this._scrollElement.scrollTop},r._getScrollHeight=function(){return this._scrollElement.scrollHeight||Math.max(document.body.scrollHeight,document.documentElement.scrollHeight)},r._getOffsetHeight=function(){return this._scrollElement===window?window.innerHeight:this._scrollElement.getBoundingClientRect().height},r._process=function(){var t=this._getScrollTop()+this._config.offset,e=this._getScrollHeight(),n=this._config.offset+e-this._getOffsetHeight();if(this._scrollHeight!==e&&this.refresh(),t>=n){var i=this._targets[this._targets.length-1];this._activeTarget!==i&&this._activate(i)}else{if(this._activeTarget&&t<this._offsets[0]&&this._offsets[0]>0)return this._activeTarget=null,void this._clear();for(var o=this._offsets.length;o--;)this._activeTarget!==this._targets[o]&&t>=this._offsets[o]&&(void 0===this._offsets[o+1]||t<this._offsets[o+1])&&this._activate(this._targets[o])}},r._activate=function(t){this._activeTarget=t,this._clear();var e=this._selector.split(",").map((function(e){return e+'[data-bs-target="'+t+'"],'+e+'[href="'+t+'"]'})),n=Y(e.join(","));n.classList.contains("dropdown-item")?(Y(".dropdown-toggle",n.closest(".dropdown")).classList.add("active"),n.classList.add("active")):(n.classList.add("active"),function(t,e){for(var n=[],i=t.parentNode;i&&i.nodeType===Node.ELEMENT_NODE&&3!==i.nodeType;)i.matches(e)&&n.push(i),i=i.parentNode;return n}(n,".nav, .list-group").forEach((function(t){V(t,".nav-link, .list-group-item").forEach((function(t){return t.classList.add("active")})),V(t,".nav-item").forEach((function(t){q(t,".nav-link").forEach((function(t){return t.classList.add("active")}))}))}))),B.trigger(this._scrollElement,"activate.bs.scrollspy",{relatedTarget:t})},r._clear=function(){F(this._selector).filter((function(t){return t.classList.contains("active")})).forEach((function(t){return t.classList.remove("active")}))},o.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.scrollspy");if(e||(e=new o(this,"object"==typeof t&&t)),"string"==typeof t){if(void 0===e[t])throw new TypeError('No method named "'+t+'"');e[t]()}}))},e(o,null,[{key:"Default",get:function(){return Be}},{key:"DATA_KEY",get:function(){return"bs.scrollspy"}}]),o}(H);B.on(window,"load.bs.scrollspy.data-api",(function(){F('[data-bs-spy="scroll"]').forEach((function(t){return new Re(t,z.getDataAttributes(t))}))})),y("scrollspy",Re);var We=function(t){function n(){return t.apply(this,arguments)||this}i(n,t);var o=n.prototype;return o.show=function(){var t=this;if(!(this._element.parentNode&&this._element.parentNode.nodeType===Node.ELEMENT_NODE&&this._element.classList.contains("active")||this._element.classList.contains("disabled"))){var e,n=c(this._element),i=this._element.closest(".nav, .list-group");if(i){var o="UL"===i.nodeName||"OL"===i.nodeName?":scope > li > .active":".active";e=(e=F(o,i))[e.length-1]}var r=e?B.trigger(e,"hide.bs.tab",{relatedTarget:this._element}):null;if(!(B.trigger(this._element,"show.bs.tab",{relatedTarget:e}).defaultPrevented||null!==r&&r.defaultPrevented)){this._activate(this._element,i);var s=function(){B.trigger(e,"hidden.bs.tab",{relatedTarget:t._element}),B.trigger(t._element,"shown.bs.tab",{relatedTarget:e})};n?this._activate(n,n.parentNode,s):s()}}},o._activate=function(t,e,n){var i=this,o=(!e||"UL"!==e.nodeName&&"OL"!==e.nodeName?q(e,".active"):F(":scope > li > .active",e))[0],r=n&&o&&o.classList.contains("fade"),s=function(){return i._transitionComplete(t,o,n)};if(o&&r){var a=u(o);o.classList.remove("show"),B.one(o,"transitionend",s),h(o,a)}else s()},o._transitionComplete=function(t,e,n){if(e){e.classList.remove("active");var i=Y(":scope > .dropdown-menu .active",e.parentNode);i&&i.classList.remove("active"),"tab"===e.getAttribute("role")&&e.setAttribute("aria-selected",!1)}t.classList.add("active"),"tab"===t.getAttribute("role")&&t.setAttribute("aria-selected",!0),v(t),t.classList.contains("fade")&&t.classList.add("show"),t.parentNode&&t.parentNode.classList.contains("dropdown-menu")&&(t.closest(".dropdown")&&F(".dropdown-toggle").forEach((function(t){return t.classList.add("active")})),t.setAttribute("aria-expanded",!0)),n&&n()},n.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.tab")||new n(this);if("string"==typeof t){if(void 0===e[t])throw new TypeError('No method named "'+t+'"');e[t]()}}))},e(n,null,[{key:"DATA_KEY",get:function(){return"bs.tab"}}]),n}(H);B.on(document,"click.bs.tab.data-api",'[data-bs-toggle="tab"], [data-bs-toggle="pill"], [data-bs-toggle="list"]',(function(t){t.preventDefault(),(T(this,"bs.tab")||new We(this)).show()})),y("tab",We);var Ke={animation:"boolean",autohide:"boolean",delay:"number"},Ue={animation:!0,autohide:!0,delay:5e3},ze=function(t){function o(e,n){var i;return(i=t.call(this,e)||this)._config=i._getConfig(n),i._timeout=null,i._setListeners(),i}i(o,t);var r=o.prototype;return r.show=function(){var t=this;if(!B.trigger(this._element,"show.bs.toast").defaultPrevented){this._clearTimeout(),this._config.animation&&this._element.classList.add("fade");var e=function(){t._element.classList.remove("showing"),t._element.classList.add("show"),B.trigger(t._element,"shown.bs.toast"),t._config.autohide&&(t._timeout=setTimeout((function(){t.hide()}),t._config.delay))};if(this._element.classList.remove("hide"),v(this._element),this._element.classList.add("showing"),this._config.animation){var n=u(this._element);B.one(this._element,"transitionend",e),h(this._element,n)}else e()}},r.hide=function(){var t=this;if(this._element.classList.contains("show")&&!B.trigger(this._element,"hide.bs.toast").defaultPrevented){var e=function(){t._element.classList.add("hide"),B.trigger(t._element,"hidden.bs.toast")};if(this._element.classList.remove("show"),this._config.animation){var n=u(this._element);B.one(this._element,"transitionend",e),h(this._element,n)}else e()}},r.dispose=function(){this._clearTimeout(),this._element.classList.contains("show")&&this._element.classList.remove("show"),B.off(this._element,"click.dismiss.bs.toast"),t.prototype.dispose.call(this),this._config=null},r._getConfig=function(t){return t=n({},Ue,z.getDataAttributes(this._element),"object"==typeof t&&t?t:{}),p("toast",t,this.constructor.DefaultType),t},r._setListeners=function(){var t=this;B.on(this._element,"click.dismiss.bs.toast",'[data-bs-dismiss="toast"]',(function(){return t.hide()}))},r._clearTimeout=function(){clearTimeout(this._timeout),this._timeout=null},o.jQueryInterface=function(t){return this.each((function(){var e=T(this,"bs.toast");if(e||(e=new o(this,"object"==typeof t&&t)),"string"==typeof t){if(void 0===e[t])throw new TypeError('No method named "'+t+'"');e[t](this)}}))},e(o,null,[{key:"DefaultType",get:function(){return Ke}},{key:"Default",get:function(){return Ue}},{key:"DATA_KEY",get:function(){return"bs.toast"}}]),o}(H);return y("toast",ze),{Alert:R,Button:W,Carousel:$,Collapse:J,Dropdown:ve,Modal:ye,Popover:Me,ScrollSpy:Re,Tab:We,Toast:ze,Tooltip:Se}}));
//# sourceMappingURL=bootstrap.bundle.min.js.map
/*!
 * Lazy Load - JavaScript plugin for lazy loading images
 *
 * Copyright (c) 2007-2017 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   https://appelsiini.net/projects/lazyload
 *
 * Version: 2.0.0-beta.2
 *
 */

(function (root, factory) {
    if (typeof exports === "object") {
        module.exports = factory(root);
    } else if (typeof define === "function" && define.amd) {
        define([], factory(root));
    } else {
        root.LazyLoad = factory(root);
    }
}) (typeof global !== "undefined" ? global : this.window || this.global, function (root) {

    "use strict";

    var defaults = {
        src: "data-src",
        srcset: "data-srcset",
        selector: ".lazyload"
    };

    /**
    * Merge two or more objects. Returns a new object.
    * @private
    * @param {Boolean}  deep     If true, do a deep (or recursive) merge [optional]
    * @param {Object}   objects  The objects to merge together
    * @returns {Object}          Merged values of defaults and options
    */
    var extend = function ()  {

        var extended = {};
        var deep = false;
        var i = 0;
        var length = arguments.length;

        /* Check if a deep merge */
        if (Object.prototype.toString.call(arguments[0]) === "[object Boolean]") {
            deep = arguments[0];
            i++;
        }

        /* Merge the object into the extended object */
        var merge = function (obj) {
            for (var prop in obj) {
                if (Object.prototype.hasOwnProperty.call(obj, prop)) {
                    /* If deep merge and property is an object, merge properties */
                    if (deep && Object.prototype.toString.call(obj[prop]) === "[object Object]") {
                        extended[prop] = extend(true, extended[prop], obj[prop]);
                    } else {
                        extended[prop] = obj[prop];
                    }
                }
            }
        };

        /* Loop through each object and conduct a merge */
        for (; i < length; i++) {
            var obj = arguments[i];
            merge(obj);
        }

        return extended;
    };

    function LazyLoad(images, options) {
        this.settings = extend(defaults, options || {});
        this.images = images || document.querySelectorAll(this.settings.selector);
        this.observer = null;
        this.init();
    }

    LazyLoad.prototype = {
        init: function() {

            /* Without observers load everything and bail out early. */
            if (!root.IntersectionObserver) {
                this.loadImages();
                return;
            }

            var self = this;
            var observerConfig = {
                root: null,
                rootMargin: "0px",
                threshold: [0]
            };

            this.observer = new IntersectionObserver(function(entries) {
                entries.forEach(function (entry) {
                    if (entry.intersectionRatio > 0) {
                        self.observer.unobserve(entry.target);
                        var src = entry.target.getAttribute(self.settings.src);
                        var srcset = entry.target.getAttribute(self.settings.srcset);
                        if ("img" === entry.target.tagName.toLowerCase()) {
                            if (src) {
                                entry.target.src = src;
                            }
                            if (srcset) {
                                entry.target.srcset = srcset;
                            }
                        } else {
                            entry.target.style.backgroundImage = "url(" + src + ")";
                        }
                    }
                });
            }, observerConfig);

            this.images.forEach(function (image) {
                self.observer.observe(image);
            });
        },

        loadAndDestroy: function () {
            if (!this.settings) { return; }
            this.loadImages();
            this.destroy();
        },

        loadImages: function () {
            if (!this.settings) { return; }

            var self = this;
            Array.prototype.forEach.call(this.images, function(image){
                var src = image.getAttribute(self.settings.src);
                var srcset = image.getAttribute(self.settings.srcset);
                if ("img" === image.tagName.toLowerCase()) {
                    if (src) {
                        image.src = src;
                    }
                    if (srcset) {
                        image.srcset = srcset;
                    }
                } else {
                    image.style.backgroundImage = "url(" + src + ")";
                }
            });
        },

        destroy: function () {
            if (!this.settings) { return; }
            this.observer.disconnect();
            this.settings = null;
        }
    };

    root.lazyload = function(images, options) {
        return new LazyLoad(images, options);
    };

    if (root.jQuery) {
        var $ = root.jQuery;
        $.fn.lazyload = function (options) {
            options = options || {};
            options.attribute = options.attribute || "data-src";
            new LazyLoad($.makeArray(this), options);
            return this;
        };
    }

    return LazyLoad;
});

window.onload = function() 
{	
	
	if($('.wrap-table-scroll').length) {
 		baron({
			root: $('.wrap-table-scroll')[0],
			scroller: '.table-scroll',
			bar: '.table-scroll__bar',
			direction: 'h'
		}).autoUpdate();
	}

	if($('.wrap-menu-scroll').length) {
 		baron({
			root: $('.wrap-menu-scroll')[0],
			scroller: '.menu-scroll',
			bar: '.menu-scroll__bar',
			direction: 'h'
		}).autoUpdate();
	}

};


// code for changing language and setting cookie
function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
// position menu
function menuNavFun() {
	let menuNavTop = $('.menu-nav-static-js').offset().top;
	let headerHeight = $('.main-header').outerHeight();
	let windowTop = $(window).scrollTop();
	let menuNavTopMain = menuNavTop - headerHeight;
	let widthMenuSub = $('.menu-nav-static-js').width();
	if(menuNavTopMain < windowTop ) {
		$('.menu-nav-wrap').css({
			'top': headerHeight, 
			'position': 'fixed',
			'width': widthMenuSub
		});
	}else {
		$('.menu-nav-wrap').css({
			'top': '0', 
			'position': 'relative',
			'width': 'auto'
		});
	}
}
$(window).resize(function() {
	if($('.menu-nav-static-js').length) {
		menuNavFun();
	}
});

if($('.menu-nav-static-js').length) {
	menuNavFun();
	$(window).scroll(function(){
		menuNavFun();
	});
}
// END position menu




//START menu scroll


$('.menu-nav li').on('click', function (e) {
	menuFunction($(this));
	e.preventDefault();
});


function menuFunction(thisLi) {

	$('#productname').val('');
	let target = thisLi.attr('data-target'),
		menu = target;
	$target = $('.section-menu[data-idproduct="' + target + '"]');

	let topScroll = $('.main-header').outerHeight() + $('.menu-nav-static-js').outerHeight() + 30;
	let sectionMenuPosition = $target.offset().top;

	console.log(sectionMenuPosition);
	console.log(topScroll);
	console.log(sectionMenuPosition - topScroll);

	$('html, body').stop().animate({
		'scrollTop': sectionMenuPosition - topScroll
	}, 500, 'swing', function () {
		window.location.hash = target;
		onScroll();
	});

}

function scrollHorizontalMenu(item) {
	let itemPosition = item.position().left;
	$('.menu-scroll').scrollLeft(itemPosition);
}


function onScroll(event){
	let scrollPos = $(window).scrollTop();
	let topScroll = $('.main-header').outerHeight() + $('.menu-nav-static-js').outerHeight() - $('.menu-img-top').outerHeight() + 30;
	$('.menu-nav li').each(function () {
		let currLink = $(this);
		let target = currLink.attr("data-target");
		let refElement = $('.section-menu[data-idproduct="' + target + '"]');
		let scrollPositon = refElement.position().top - topScroll;
		
		if (scrollPositon <= scrollPos) {
			if(currLink.hasClass('active')) {

			}else {
				$('.menu-nav li').removeClass("active");
				currLink.addClass("active");
				scrollHorizontalMenu(currLink);
			}
		}
		else{
			currLink.removeClass("active");
		}
		if($('.menu-nav li.active').length == 0) {
			$('.menu-nav li:first-child').addClass("active");
		}
	});
}


$(window).on("scroll", onScroll);

//END menu scroll



if($('.menu-nav-business-new-js').length){


	function showBusinessSidebar() {
		jQuery('.business-page').removeClass('no-sidebar-business-page');
	}


	function menuNavBusinessNewJsClickFunSub() {
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();
		jQuery('.products-list2').html("");
		var thisId = jQuery('.menu-nav-business-new-js > li > .click').attr('id');

		var businessSubCategoryIDs = "";
		jQuery('.menu-nav-business-new-js > li > .click + ul .click').each(function(){
			var businessSubCategoryID = jQuery(this).attr('id');
			businessSubCategoryIDs = businessSubCategoryIDs + businessSubCategoryID + ',';

		});

		var pageBusinessFilterURL;

		if(businessSubCategoryIDs.length) {
			businessSubCategoryIDs = businessSubCategoryIDs.substring(0, businessSubCategoryIDs.length - 1);
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId + "&businessSubCategoryID=" + businessSubCategoryIDs;

		}else {

			console.log('businessSubCategoryIDs false ');
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
		}

		pageBusinessFilter(pageBusinessFilterURL);

	}


	function menuNavBusinessNewJsClickFun(thisFun) {
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();
		var thisId = thisFun.attr('id');
		jQuery('.menu-nav-business-new-js a').removeClass('click');
		jQuery('.stores-list').html("");
		thisFun.addClass('click');
		var businessFilterLink;

		var pageBusinessFilterURL;
		if (thisId == 'all') {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId;
		}else {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
		}

		console.log('main pageBusinessFilter');
		pageBusinessFilter(pageBusinessFilterURL);

	}

	var companyId = $('#companyId').val();
	var longitude_var = $('#longitude').val();
	var latitude_var = $('#latitude').val();
	var pageBusinessURL;


	if(longitude_var && latitude_var ) {
		pageBusinessURL = "/businesscategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId;
	}else {
		pageBusinessURL = "/businesscategories?companyId=" + companyId;
	}

	jQuery.ajax({
		type: "GET",
		url: pageBusinessURL,
		success: function(response) {

			if(response.length) {
				if(response.length < 2) {

					$('.menu-nav-business-new-js li:first-child').removeClass('click').hide();
					$('.menu-nav-business-new-js li:first-child a').removeClass('click');
					$('.menu-nav-business-new-js').append('<li><a href="#" class="click" id=' + response[0].id + '>' + response[0].name + '</a></li>');


					var thisLink = $('.menu-nav-business-new-js > li:nth-child(2) > a');
					var businessCategoryID = response[0].id;
					var businesssubCategoriesUrl;

					if(longitude_var && latitude_var ) {
						businesssubCategoriesUrl = "/businesssubcategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
					}else {
						businesssubCategoriesUrl = "/businesssubcategories?companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
					}


					jQuery.ajax({
						type: "GET",
						url: businesssubCategoriesUrl,
						success: function(response) {
							var htmlUl = "";
							for (var i = 0; i < response.length; i++) {
								if ( (response[i].name != 'Any') && (response[i].name != thisLink.text()) ){
									htmlUl = htmlUl + '<li><a href="#" id=' + response[i].id + ' data-businessCategoryId="' + response[i].businessCategoryId + '">' + response[i].name + '</a></li>';
								}
							}
							if(htmlUl != "") {
								thisLink.parent().append('<ul>' + htmlUl + '</ul>');

								showBusinessSidebar();
							}
						},
						dataType: 'json'
					});

				}else {

					showBusinessSidebar();

					for (var i = 0; i < response.length; i++) {
						$('.menu-nav-business-new-js').append('<li><a href="#" id=' + response[i].id + '>' + response[i].name + '</a></li>');

			
					}

				}
			}
			
		},
		error: function (error) {
		    console.log(error);
		},
		dataType: 'json'
	});









	var varClickRestname;




	jQuery('#business-restname').on('input',function(e){
		clearTimeout(varClickRestname);
		varClickRestname = setTimeout(function(){ 
			clickRestname();
		}, 800);
	});


	function clickRestname() {


		jQuery(".radio-option").each(function(i) {
			jQuery(this).removeClass('click');	
		});
		var restaurantName = document.getElementById("business-restname").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (restaurantName != '') {
			if (filterURL.indexOf("?") >= 0) {
				filterURL = filterURL + "&name="+restaurantName;
				jQuery('.business-search-list').show();
				jQuery('.business-search-button-close').show();
				
			} else {
				filterURL = filterURL + "?name="+restaurantName;
			}
		}else {
			jQuery('.business-search-list').hide();
			jQuery('.business-search-button-close').hide();
		}
		jQuery(".business-search-list").html("");
		
		// queue up an ajax request
		jQuery.ajaxQueue({
			url: filterURL,
			type: 'GET',
			success: function(response) {
				if (response.status == 'failure') {
					//alert("Failed to Delete");
				} else {
					if (response.firstBranchId != '0') {
						jQuery(".business-search-list").html(response.branchHTML);
					} else {

						jQuery(".business-search-list").html("<div class='no-result-filter'>No Results</div>");
					}
				}
			},
			dataType: 'json'
		});

	}


	jQuery(document).on("scroll", onScrollAjax);

	$.fn.isOnScreen = function(){
	    var win = jQuery(window);
	    
	    var viewport = {
	        top : win.scrollTop(),
	        left : win.scrollLeft()
	    };
	    viewport.right = viewport.left + win.width();
	    viewport.bottom = viewport.top + win.height();
	    
	    var bounds = this.offset();
	    bounds.right = bounds.left + this.outerWidth();
	    bounds.bottom = bounds.top + this.outerHeight();
	    
	    return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
	};

	var timeout;
	var lastScrollTop = 0;
	var oldLink = "";
	var oldLiCol = 30;
	var oldLiColNew = 0;


	function onScrollAjax() {


		console.log('assds');

		var st = jQuery(this).scrollTop();
	   	if (st > lastScrollTop && jQuery('#load-restaurant-link').length > 0){

	    	if (jQuery('#load-restaurant-link').isOnScreen() == true) {

	    		clearTimeout(timeout);  
	    		timeout = setTimeout(function() {
	    			oldLiCol = jQuery('.stores-list > li').length;

	    			if(oldLiCol != oldLiColNew) {
	    				oldLiColNew = jQuery('.stores-list > li').length;
		    			scrollAjax(oldLiCol);
		    		}
			   	}, 50);
			   	
	    	}
	   } else {
	   }
	   lastScrollTop = st;
	}


	jQuery(document).ready(function() {
		var loading = jQuery("#loadingDiv");
        jQuery(document).ajaxStart(function () {
            loading.show();
        });

        jQuery(document).ajaxStop(function () {
            loading.hide();
        });
    });


	function scrollAjax(oldLi) {


		var pageURLfilter;
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();


		var thisId = jQuery('.menu-nav-business-new-js > li > .click').attr('id');

		var businessSubCategoryIDs = "";
		jQuery('.menu-nav-business-new-js > li > .click + ul .click').each(function(){
			var businessSubCategoryID = jQuery(this).attr('id');
			businessSubCategoryIDs = businessSubCategoryIDs + businessSubCategoryID + ',';
		});


		latitude

		if (thisId == 'all') {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId;
		}else {
			if(businessSubCategoryIDs.length) {
				businessSubCategoryIDs = businessSubCategoryIDs.substring(0, businessSubCategoryIDs.length - 1);
				pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId + "&businessSubCategoryID=" + businessSubCategoryIDs;
			}else {
				pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
			}
		}



		console.log(oldLi);

		loadResuts(pageBusinessFilterURL);
	}



	function loadResuts(pageURL){
		// console.log(pageURL);
		jQuery.ajax({
	    	type: "GET",
	    	url: pageURL,
	    	success: function(response) {
	    		console.log(response);


	    		var varStore = "";
	    		for (var i = 0; response.length > i; i++) {
	    	

		    		var openText = '';
		    		var openTextClass = '';
		    		var reviewCount = 0;
					var nowBranchOpenForASAP, branchOnlineForASAP, nowBranchOpenForPreOrdering, branchOnlineForPreOrdering, nowBranchOpenForASAP, nowBranchOpenForPreOrdering;

		    		
		    		

		    		var averageReviewScore = 0;
		    		for (var b = 0; response[i].locationMetaDatas.length > b; b++) {
		    			if(response[i].locationMetaDatas[b].paramName == "reviewCount" ) {
		    				reviewCount = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "averageReviewScore" ) {
		    				averageReviewScore = response[i].locationMetaDatas[b].paramValue;
		    			}

		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForASAP" ) {
							nowBranchOpenForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "branchOnlineForASAP" ) {
							branchOnlineForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}


		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForPreOrdering" ) {
							nowBranchOpenForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "branchOnlineForPreOrdering" ) {
							branchOnlineForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}


		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForASAP" ) {
							nowBranchOpenForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForPreOrdering" ) {
							nowBranchOpenForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}


		    		}


					if(nowBranchOpenForASAP == "true" && branchOnlineForASAP == "true") {
						openText = jQuery('#labelStoreOpen').val();
						openTextClass = "status-menu-open";
					}else if(nowBranchOpenForPreOrdering == "true" && branchOnlineForPreOrdering == "true") {
						openText = jQuery('#labelStoreOrderforlater').val();
						openTextClass = "status-menu-pre";
					}else if(nowBranchOpenForASAP != "true" && nowBranchOpenForPreOrdering != "true") {
						openText = jQuery('#labelStoreClose').val();
						openTextClass = "status-menu-close";
					}else {
						// offline
						openText = jQuery('#labelStoreOffline').val();
						openTextClass = "status-menu-offline";
					}


					var ratingText = '<div class="rating-section"><span><span class="branch-rate" id="branchRating-' + response[i].id + '" data-rate="' + averageReviewScore + '"></span></span> <span>' + reviewCount + '</span></div>';

					if(response[i].hasReviews == false) {
						ratingText = "";
					}


		    		varStore = varStore + '<li id="' + response[i].id + '" onclick="location.href=\'' + '/store/' + response[i].urlPath + '\';"><a href="' + '/store/' + response[i].urlPath + '" class="one-store"><div class="store-img-wrap-main"><div class="store-img-wrap"><div style="background-image: url(' + response[i].locationWebLogoUrl + ');"></div></div><span class="status-menu ' + openTextClass + '">' + openText + '</span></div><h2 class="store-title">' + response[i].name + '</h2>' + ratingText + '</a></li>';




	    		}		
		    	jQuery("#load-restaurant-list ul").append(varStore);


		    	jQuery(".branch-rate").each(function(){
					var that = this;
					var raingVar = 0;
					if(parseInt(jQuery(that).data("rate"))) {
						raingVar = parseInt(jQuery(that).data("rate"));
					}else {
						jQuery(this).parent().next().html('0');
					}
					jQuery(that).rateYo({rating : raingVar, readOnly : true, starWidth : '14px'})	
				});

	    	},
	    	dataType: 'json'
	    });
	}


	function pageBusinessFilter(pageBusinessFilterURL) {
		jQuery('.stores-list').html('');
		loadResuts(pageBusinessFilterURL);
	}

	
	jQuery('.business-search-button-close').click(function(){
		jQuery('.business-search-list').hide();
		jQuery('.business-search-button-close').hide();
		jQuery('#business-restname').val('');
		return false
	});







	jQuery('body').on('click','.filter-button-sidebar a', function(){
		jQuery('.wrap-sidebar-filter').show();
		setTimeout(function(){
			jQuery('html').addClass('sidebar-filter-active');
		}, 100);
		setTimeout(function(){
			jQuery('.filter-button-sidebar a').removeClass('disable-btn');
		}, 300);
		return false 
	});
	jQuery('body').on('click','.close-sidebar-filter', function(){
		jQuery('html').removeClass('sidebar-filter-active');
		jQuery('.wrap-sidebar-filter').hide();
		return false 
	});


	jQuery('body').on('click','.menu-nav-business-new-js > li ul a', function(){
		jQuery(this).toggleClass('click');
		menuNavBusinessNewJsClickFunSub();
	});


	jQuery('body').on('click','.menu-nav-business-new-js > li >  a', function(){
		$('.menu-nav-business-new-js > li ul').remove();
		menuNavBusinessNewJsClickFun(jQuery(this));
		var thisLink = jQuery(this);
		var businessCategoryID = jQuery(this).attr('id');
		var companyId = jQuery('#companyId').val();
		var longitude_var = $('#longitude').val();
		var latitude_var = $('#latitude').val();

		if(businessCategoryID != 'all') {

			var businesssubCategoriesUrl;

			if(longitude_var && latitude_var ) {
				businesssubCategoriesUrl = "/businesssubcategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
			}else {
				businesssubCategoriesUrl = "/businesssubcategories?companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
			}


			jQuery.ajax({
				type: "GET",
				url: businesssubCategoriesUrl,
				success: function(response) {
					var htmlUl = "";
					for (var i = 0; i < response.length; i++) {
						if ( (response[i].name != 'Any') && (response[i].name != thisLink.text()) ){
							htmlUl = htmlUl + '<li><a href="#" id=' + response[i].id + ' data-businessCategoryId="' + response[i].businessCategoryId + '">' + response[i].name + '</a></li>';
						}
					}
					if(htmlUl != "") {
						thisLink.parent().append('<ul>' + htmlUl + '</ul>');
					}
				},
				dataType: 'json'
			});
		}
		return false
	});



}


$(function() {
$(".dropdown-language .dropdown-item").click(function(){
	setCookie("languageCookie", jQuery(this).attr('data-language'), 365);
	location.reload();
})
$(".clickable-row").click(function() {
	window.document.location = $(this).data("href");
});
if($('.lazyload').length) {
	lazyload();
}
$("[data-modal-ajax]").on('show.bs.modal', function (e) {

	// login, register, forgot password
	const modalsAuthorization = ['loginModal', 'forgotloginModal', 'registerModal'];
	let thisModalId = $(this).attr('id');
	for (var i = 0; i < modalsAuthorization.length; i++) {
		if(thisModalId == modalsAuthorization[i]) {
			if($('body').hasClass('modal-open')){
				$('.modal').modal('hide');
			}
		}
	}

	// ajax modal
	let link = $(e.relatedTarget);
	let thisModal = $(this);
	thisModal.addClass('spinner-active');


	if(link.length) {
		thisModal.find(".modal-content").load(link.attr("data-modal-href"), function(responseText, textStatus, XMLHttpRequest) {
			console.log('XMLHttpRequest.responseText');
			// console.log(XMLHttpRequest.responseText);
			thisModal.removeClass('spinner-active');
		});
	}

});

$("[data-modal-ajax]").on('hide.bs.modal', function (e) {
	$(this).find('.modal-content').html('');
	$(this).addClass('spinner-active');
});



$('.menu-button-wrap').click(function(){
	$('html').toggleClass('menu-open');
});
});
