/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("align-plugin",function(c){var e="offsetWidth",d="offsetHeight",b=b;function a(f){if(f.host){this._host=f.host;}}a.prototype={to:function(j,t,l,o){this._syncArgs=c.Array(arguments);if(j.top===b){j=c.one(j).get("region");}if(j){var s=[j.left,j.top],q=[j.width,j.height],n=a.points,f=this._host,h=null,r=f.getAttrs([d,e]),k=[0-r[e],0-r[d]],p=t?n[t.charAt(0)]:h,m=(t&&t!=="cc")?n[t.charAt(1)]:h,i=l?n[l.charAt(0)]:h,g=(l&&l!=="cc")?n[l.charAt(1)]:h;if(p){s=p(s,q,t);}if(m){s=m(s,q,t);}if(i){s=i(s,k,l);}if(g){s=g(s,k,l);}if(s&&f){f.setXY(s);}this._resize(o);}return this;},sync:function(){this.to.apply(this,this._syncArgs);return this;},_resize:function(g){var f=this._handle;if(g&&!f){this._handle=c.on("resize",this._onresize,window,this);}else{if(!g&&f){f.detach();}}},_onresize:function(){var f=this;setTimeout(function(){f.sync();});},center:function(g,f){this.to(g,"cc","cc",f);return this;},destroy:function(){var f=this._handle;if(f){f.detach();}}};a.points={"t":function(f,g){return f;},"r":function(f,g){return[f[0]+g[0],f[1]];},"b":function(f,g){return[f[0],f[1]+g[1]];},"l":function(f,g){return f;},"c":function(i,k,f){var h=(f[0]==="t"||f[0]==="b")?0:1,g,j;if(f==="cc"){g=[i[0]+k[0]/2,i[1]+k[1]/2];}else{j=i[h]+k[h]/2;g=(h)?[i[0],j]:[j,i[1]];}return g;}};a.NAME="Align";a.NS="align";a.prototype.constructor=a;c.namespace("Plugin");c.Plugin.Align=a;},"3.3.0",{requires:["node-screen"]});
