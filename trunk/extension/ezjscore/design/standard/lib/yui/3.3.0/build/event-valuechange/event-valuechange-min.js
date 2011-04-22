/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("event-valuechange",function(D){var B=D.Array,C="value",A={POLL_INTERVAL:50,TIMEOUT:10000,_history:{},_intervals:{},_notifiers:{},_timeouts:{},_poll:function(I,F,J){var H=I._node,E=H&&H.value,K=A._history[F],G;if(!H){A._stopPolling(I,F);return;}if(E!==K){A._history[F]=E;G={_event:J,newVal:E,prevVal:K};B.each(A._notifiers[F],function(L){L.fire(G);});A._refreshTimeout(I,F);}},_refreshTimeout:function(F,E){A._stopTimeout(F,E);A._timeouts[E]=setTimeout(function(){A._stopPolling(F,E);},A.TIMEOUT);},_startPolling:function(F,E,H,G){if(!E){E=D.stamp(F);}if(!G&&A._intervals[E]){return;}A._stopPolling(F,E);A._intervals[E]=setInterval(function(){A._poll(F,E,H);},A.POLL_INTERVAL);A._refreshTimeout(F,E,H);},_stopPolling:function(F,E){if(!E){E=D.stamp(F);}A._intervals[E]=clearInterval(A._intervals[E]);A._stopTimeout(F,E);},_stopTimeout:function(F,E){if(!E){E=D.stamp(F);}A._timeouts[E]=clearTimeout(A._timeouts[E]);},_onBlur:function(E){A._stopPolling(E.currentTarget);},_onFocus:function(F){var E=F.currentTarget;A._history[D.stamp(E)]=E.get(C);A._startPolling(E,null,F);},_onKeyDown:function(E){A._startPolling(E.currentTarget,null,E);},_onKeyUp:function(E){if(E.charCode===229||E.charCode===197){A._startPolling(E.currentTarget,null,E,true);}},_onMouseDown:function(E){A._startPolling(E.currentTarget,null,E);},_onSubscribe:function(I,H,G){var F=D.stamp(I),E=A._notifiers[F];A._history[F]=I.get(C);G._handles=I.on({blur:A._onBlur,focus:A._onFocus,keydown:A._onKeyDown,keyup:A._onKeyUp,mousedown:A._onMouseDown});if(!E){E=A._notifiers[F]=[];}E.push(G);},_onUnsubscribe:function(J,I,H){var G=D.stamp(J),E=A._notifiers[G],F=B.indexOf(E,H);H._handles.detach();if(F!==-1){E.splice(F,1);if(!E.length){A._stopPolling(J,G);delete A._notifiers[G];delete A._history[G];}}}};D.Event.define("valueChange",{detach:A._onUnsubscribe,on:A._onSubscribe,publishConfig:{emitFacade:true}});D.ValueChange=A;},"3.3.0",{requires:["event-focus","event-synthetic"]});
