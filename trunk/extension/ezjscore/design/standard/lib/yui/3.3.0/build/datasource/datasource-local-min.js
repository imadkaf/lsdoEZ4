/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("datasource-local",function(C){var B=C.Lang,A=function(){A.superclass.constructor.apply(this,arguments);};C.mix(A,{NAME:"dataSourceLocal",ATTRS:{source:{value:null}},_tId:0,transactions:{},issueCallback:function(G,F){var E=(G.error||G.response.error);if(E){G.error=G.error||G.response.error;F.fire("error",G);}if(G.callback){var D=(E&&G.callback.failure)||G.callback.success;if(D){D(G);}}}});C.extend(A,C.Base,{initializer:function(D){this._initEvents();},_initEvents:function(){this.publish("request",{defaultFn:C.bind("_defRequestFn",this),queuable:true});this.publish("data",{defaultFn:C.bind("_defDataFn",this),queuable:true});this.publish("response",{defaultFn:C.bind("_defResponseFn",this),queuable:true});},_defRequestFn:function(E){var D=this.get("source");if(B.isUndefined(D)){E.error=new Error("Local source undefined");}this.fire("data",C.mix({data:D},E));},_defDataFn:function(G){var E=G.data,F=G.meta,D={results:(B.isArray(E))?E:[E],meta:(F)?F:{}};this.fire("response",C.mix({response:D},G));},_defResponseFn:function(D){A.issueCallback(D,this);},sendRequest:function(D){D=D||{};var E=A._tId++;this.fire("request",{tId:E,request:D.request,callback:D.callback,cfg:D.cfg||{}});return E;}});C.namespace("DataSource").Local=A;},"3.3.0",{requires:["base"]});
