/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("history-hash-ie",function(H){if(H.UA.ie&&!H.HistoryBase.nativeHashChange){var C=H.Do,D=YUI.namespace("Env.HistoryHash"),B=H.HistoryHash,E=D._iframe,G=H.config.win,A=G.location,F="";B.getIframeHash=function(){if(!E||!E.contentWindow){return"";}var I=B.hashPrefix,J=E.contentWindow.location.hash.substr(1);return I&&J.indexOf(I)===0?J.replace(I,""):J;};B._updateIframe=function(J,I){var K=E&&E.contentWindow&&E.contentWindow.document,L=K&&K.location;if(!K||!L){return;}K.open().close();if(I){L.replace(J.charAt(0)==="#"?J:"#"+J);}else{L.hash=J;}};C.after(B._updateIframe,B,"replaceHash",B,true);if(!E){H.on("domready",function(){E=D._iframe=H.Node.getDOMNode(H.Node.create('<iframe src="javascript:0" style="display:none" height="0" width="0" tabindex="-1" title="empty"/>'));H.config.doc.documentElement.appendChild(E);B._updateIframe(B.getHash()||"#");H.on("hashchange",function(I){F=I.newHash;if(B.getIframeHash()!==F){B._updateIframe(F);}},G);H.later(50,null,function(){var I=B.getIframeHash();if(I!==F){B.setHash(I);}},null,true);});}}},"3.3.0",{requires:["history-hash","node-base"]});
