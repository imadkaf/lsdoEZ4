/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("attribute-complex",function(b){var a=b.Object,c=".";b.Attribute.Complex=function(){};b.Attribute.Complex.prototype={_normAttrVals:function(g){var i={},h={},j,d,f,e;if(g){for(e in g){if(g.hasOwnProperty(e)){if(e.indexOf(c)!==-1){j=e.split(c);d=j.shift();f=h[d]=h[d]||[];f[f.length]={path:j,value:g[e]};}else{i[e]=g[e];}}}return{simple:i,complex:h};}else{return null;}},_getAttrInitVal:function(m,j,p){var e=j.value,o=j.valueFn,d,f,h,g,q,n,k;if(o){if(!o.call){o=this[o];}if(o){e=o.call(this);}}if(!j.readOnly&&p){d=p.simple;if(d&&d.hasOwnProperty(m)){e=d[m];}f=p.complex;if(f&&f.hasOwnProperty(m)){k=f[m];for(h=0,g=k.length;h<g;++h){q=k[h].path;n=k[h].value;a.setValue(e,q,n);}}}return e;}};b.mix(b.Attribute,b.Attribute.Complex,true,null,1);},"3.3.0",{requires:["attribute-base"]});
