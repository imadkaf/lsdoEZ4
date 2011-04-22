/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("anim-base",function(B){var C="running",N="startTime",L="elapsedTime",J="start",I="tween",M="end",D="node",K="paused",O="reverse",H="iterationCount",A=Number;var F={},E;B.Anim=function(){B.Anim.superclass.constructor.apply(this,arguments);B.Anim._instances[B.stamp(this)]=this;};B.Anim.NAME="anim";B.Anim._instances={};B.Anim.RE_DEFAULT_UNIT=/^width|height|top|right|bottom|left|margin.*|padding.*|border.*$/i;B.Anim.DEFAULT_UNIT="px";B.Anim.DEFAULT_EASING=function(Q,P,S,R){return S*Q/R+P;};B.Anim._intervalTime=20;B.Anim.behaviors={left:{get:function(Q,P){return Q._getOffset(P);}}};B.Anim.behaviors.top=B.Anim.behaviors.left;B.Anim.DEFAULT_SETTER=function(S,T,V,W,Y,R,U,X){var Q=S._node,P=U(Y,A(V),A(W)-A(V),R);if(T in Q._node.style||T in B.DOM.CUSTOM_STYLES){X=X||"";Q.setStyle(T,P+X);}else{if(Q._node.attributes[T]){Q.setAttribute(T,P);}else{Q.set(T,P);}}};B.Anim.DEFAULT_GETTER=function(R,P){var Q=R._node,S="";if(P in Q._node.style||P in B.DOM.CUSTOM_STYLES){S=Q.getComputedStyle(P);}else{if(Q._node.attributes[P]){S=Q.getAttribute(P);}else{S=Q.get(P);}}return S;};B.Anim.ATTRS={node:{setter:function(P){P=B.one(P);this._node=P;if(!P){}return P;}},duration:{value:1},easing:{value:B.Anim.DEFAULT_EASING,setter:function(P){if(typeof P==="string"&&B.Easing){return B.Easing[P];}}},from:{},to:{},startTime:{value:0,readOnly:true},elapsedTime:{value:0,readOnly:true},running:{getter:function(){return !!F[B.stamp(this)];},value:false,readOnly:true},iterations:{value:1},iterationCount:{value:0,readOnly:true},direction:{value:"normal"},paused:{readOnly:true,value:false},reverse:{value:false}};B.Anim.run=function(){var Q=B.Anim._instances;for(var P in Q){if(Q[P].run){Q[P].run();}}};B.Anim.pause=function(){for(var P in F){if(F[P].pause){F[P].pause();}}B.Anim._stopTimer();};B.Anim.stop=function(){for(var P in F){if(F[P].stop){F[P].stop();}}B.Anim._stopTimer();};B.Anim._startTimer=function(){if(!E){E=setInterval(B.Anim._runFrame,B.Anim._intervalTime);}};B.Anim._stopTimer=function(){clearInterval(E);E=0;};B.Anim._runFrame=function(){var P=true;for(var Q in F){if(F[Q]._runFrame){P=false;F[Q]._runFrame();}}if(P){B.Anim._stopTimer();}};B.Anim.RE_UNITS=/^(-?\d*\.?\d*){1}(em|ex|px|in|cm|mm|pt|pc|%)*$/;var G={run:function(){if(this.get(K)){this._resume();}else{if(!this.get(C)){this._start();}}return this;},pause:function(){if(this.get(C)){this._pause();}return this;},stop:function(P){if(this.get(C)||this.get(K)){this._end(P);}return this;},_added:false,_start:function(){this._set(N,new Date()-this.get(L));this._actualFrames=0;if(!this.get(K)){this._initAnimAttr();}F[B.stamp(this)]=this;B.Anim._startTimer();this.fire(J);},_pause:function(){this._set(N,null);this._set(K,true);delete F[B.stamp(this)];this.fire("pause");},_resume:function(){this._set(K,false);F[B.stamp(this)]=this;this._set(N,new Date()-this.get(L));B.Anim._startTimer();this.fire("resume");},_end:function(P){var Q=this.get("duration")*1000;if(P){this._runAttrs(Q,Q,this.get(O));}this._set(N,null);this._set(L,0);this._set(K,false);delete F[B.stamp(this)];this.fire(M,{elapsed:this.get(L)});},_runFrame:function(){var T=this._runtimeAttr.duration,R=new Date()-this.get(N),Q=this.get(O),P=(R>=T),S,U;this._runAttrs(R,T,Q);this._actualFrames+=1;this._set(L,R);this.fire(I);if(P){this._lastFrame();}},_runAttrs:function(Z,Y,V){var W=this._runtimeAttr,R=B.Anim.behaviors,X=W.easing,P=Y,T=false,Q,S,U;if(Z>=Y){T=true;}if(V){Z=Y-Z;P=0;}for(U in W){if(W[U].to){Q=W[U];S=(U in R&&"set" in R[U])?R[U].set:B.Anim.DEFAULT_SETTER;if(!T){S(this,U,Q.from,Q.to,Z,Y,X,Q.unit);}else{S(this,U,Q.from,Q.to,P,Y,X,Q.unit);}}}},_lastFrame:function(){var P=this.get("iterations"),Q=this.get(H);Q+=1;if(P==="infinite"||Q<P){if(this.get("direction")==="alternate"){this.set(O,!this.get(O));}this.fire("iteration");}else{Q=0;this._end();}this._set(N,new Date());this._set(H,Q);},_initAnimAttr:function(){var W=this.get("from")||{},V=this.get("to")||{},P={duration:this.get("duration")*1000,easing:this.get("easing")},R=B.Anim.behaviors,U=this.get(D),T,S,Q;B.each(V,function(a,Y){if(typeof a==="function"){a=a.call(this,U);}S=W[Y];if(S===undefined){S=(Y in R&&"get" in R[Y])?R[Y].get(this,Y):B.Anim.DEFAULT_GETTER(this,Y);}else{if(typeof S==="function"){S=S.call(this,U);}}var X=B.Anim.RE_UNITS.exec(S);var Z=B.Anim.RE_UNITS.exec(a);S=X?X[1]:S;Q=Z?Z[1]:a;T=Z?Z[2]:X?X[2]:"";if(!T&&B.Anim.RE_DEFAULT_UNIT.test(Y)){T=B.Anim.DEFAULT_UNIT;}if(!S||!Q){B.error('invalid "from" or "to" for "'+Y+'"',"Anim");return;}P[Y]={from:S,to:Q,unit:T};},this);this._runtimeAttr=P;},_getOffset:function(Q){var S=this._node,T=S.getComputedStyle(Q),R=(Q==="left")?"getX":"getY",U=(Q==="left")?"setX":"setY";if(T==="auto"){var P=S.getStyle("position");if(P==="absolute"||P==="fixed"){T=S[R]();S[U](T);}else{T=0;}}return T;},destructor:function(){delete B.Anim._instances[B.stamp(this)];}};B.extend(B.Anim,B.Base,G);},"3.3.0",{requires:["base-base","node-style"]});
