/*
Copyright (c) 2010, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.com/yui/license.html
version: 3.3.0
build: 3167
*/
YUI.add("text-accentfold",function(e){var c=e.Array,b=e.Text,a=b.Data.AccentFold,d={canFold:function(f){var g;for(g in a){if(a.hasOwnProperty(g)&&f.search(a[g])!==-1){return true;}}return false;},compare:function(g,f,h){var i=d.fold(g),j=d.fold(f);return h?!!h(i,j):i===j;},filter:function(g,f){return c.filter(g,function(h){return f(d.fold(h));});},fold:function(f){if(e.Lang.isArray(f)){return c.map(f,d.fold);}f=f.toLowerCase();e.Object.each(a,function(h,g){f=f.replace(h,g);});return f;}};b.AccentFold=d;},"3.3.0",{requires:["array-extras","text-data-accentfold"]});
