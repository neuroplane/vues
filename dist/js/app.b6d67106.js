(function(e){function t(t){for(var r,o,s=t[0],u=t[1],l=t[2],c=0,p=[];c<s.length;c++)o=s[c],Object.prototype.hasOwnProperty.call(a,o)&&a[o]&&p.push(a[o][0]),a[o]=0;for(r in u)Object.prototype.hasOwnProperty.call(u,r)&&(e[r]=u[r]);d&&d(t);while(p.length)p.shift()();return i.push.apply(i,l||[]),n()}function n(){for(var e,t=0;t<i.length;t++){for(var n=i[t],r=!0,o=1;o<n.length;o++){var s=n[o];0!==a[s]&&(r=!1)}r&&(i.splice(t--,1),e=u(u.s=n[0]))}return e}var r={},o={app:0},a={app:0},i=[];function s(e){return u.p+"js/"+({about:"about"}[e]||e)+"."+{about:"b039d822"}[e]+".js"}function u(t){if(r[t])return r[t].exports;var n=r[t]={i:t,l:!1,exports:{}};return e[t].call(n.exports,n,n.exports,u),n.l=!0,n.exports}u.e=function(e){var t=[],n={about:1};o[e]?t.push(o[e]):0!==o[e]&&n[e]&&t.push(o[e]=new Promise((function(t,n){for(var r="css/"+({about:"about"}[e]||e)+"."+{about:"ab32b291"}[e]+".css",a=u.p+r,i=document.getElementsByTagName("link"),s=0;s<i.length;s++){var l=i[s],c=l.getAttribute("data-href")||l.getAttribute("href");if("stylesheet"===l.rel&&(c===r||c===a))return t()}var p=document.getElementsByTagName("style");for(s=0;s<p.length;s++){l=p[s],c=l.getAttribute("data-href");if(c===r||c===a)return t()}var d=document.createElement("link");d.rel="stylesheet",d.type="text/css",d.onload=t,d.onerror=function(t){var r=t&&t.target&&t.target.src||a,i=new Error("Loading CSS chunk "+e+" failed.\n("+r+")");i.code="CSS_CHUNK_LOAD_FAILED",i.request=r,delete o[e],d.parentNode.removeChild(d),n(i)},d.href=a;var h=document.getElementsByTagName("head")[0];h.appendChild(d)})).then((function(){o[e]=0})));var r=a[e];if(0!==r)if(r)t.push(r[2]);else{var i=new Promise((function(t,n){r=a[e]=[t,n]}));t.push(r[2]=i);var l,c=document.createElement("script");c.charset="utf-8",c.timeout=120,u.nc&&c.setAttribute("nonce",u.nc),c.src=s(e);var p=new Error;l=function(t){c.onerror=c.onload=null,clearTimeout(d);var n=a[e];if(0!==n){if(n){var r=t&&("load"===t.type?"missing":t.type),o=t&&t.target&&t.target.src;p.message="Loading chunk "+e+" failed.\n("+r+": "+o+")",p.name="ChunkLoadError",p.type=r,p.request=o,n[1](p)}a[e]=void 0}};var d=setTimeout((function(){l({type:"timeout",target:c})}),12e4);c.onerror=c.onload=l,document.head.appendChild(c)}return Promise.all(t)},u.m=e,u.c=r,u.d=function(e,t,n){u.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:n})},u.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},u.t=function(e,t){if(1&t&&(e=u(e)),8&t)return e;if(4&t&&"object"===typeof e&&e&&e.__esModule)return e;var n=Object.create(null);if(u.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)u.d(n,r,function(t){return e[t]}.bind(null,r));return n},u.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return u.d(t,"a",t),t},u.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},u.p="/",u.oe=function(e){throw console.error(e),e};var l=window["webpackJsonp"]=window["webpackJsonp"]||[],c=l.push.bind(l);l.push=t,l=l.slice();for(var p=0;p<l.length;p++)t(l[p]);var d=c;i.push([0,"chunk-vendors"]),n()})({0:function(e,t,n){e.exports=n("56d7")},"56d7":function(e,t,n){"use strict";n.r(t);n("e260"),n("e6cf"),n("cca6"),n("a79d");var r=n("2b0e"),o=(n("d3b7"),n("bc3a")),a=n.n(o),i={},s=a.a.create(i);s.interceptors.request.use((function(e){return e}),(function(e){return Promise.reject(e)})),s.interceptors.response.use((function(e){return e}),(function(e){return Promise.reject(e)})),Plugin.install=function(e,t){e.axios=s,window.axios=s,Object.defineProperties(e.prototype,{axios:{get:function(){return s}},$axios:{get:function(){return s}}})},r["a"].use(Plugin);Plugin;var u=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-app",[e.user?n("v-navigation-drawer",{attrs:{absolute:"",temporary:"",app:""},model:{value:e.drawer,callback:function(t){e.drawer=t},expression:"drawer"}},[n("v-list",{attrs:{dense:"",nav:""}},[n("v-list-group",{attrs:{"prepend-icon":"mdi-menu","sub-group":""},scopedSlots:e._u([{key:"activator",fn:function(){return[n("v-list-item-title",[e._v("Меню")])]},proxy:!0}],null,!1,2402935965)},e._l(e.items,(function(t){return n("v-list-item",{key:t.title,attrs:{link:"",to:t.url},model:{value:e.group,callback:function(t){e.group=t},expression:"group"}},[n("v-list-item-icon",[n("v-icon",[e._v(e._s(t.icon))])],1),n("v-list-item-content",[n("v-list-item-title",[e._v("\n            "+e._s(t.title)+"\n          ")])],1)],1)})),1),n("v-list-item",[n("v-date-picker",{staticClass:"mt-5",attrs:{type:"month","full-width":"",locale:"ru",color:"blue",min:"2021-04","no-title":""},on:{change:e.alertdate},model:{value:e.picker,callback:function(t){e.picker=t},expression:"picker"}})],1)],1)],1):e._e(),e.user?n("v-app-bar",{attrs:{dense:"",app:""}},[n("v-app-bar-nav-icon",{on:{click:function(t){e.drawer=!0}}}),n("v-spacer"),n("v-btn",{attrs:{small:"",plain:""},on:{click:e.doLogout}},[n("v-icon",[e._v("mdi-exit-to-app")])],1)],1):e._e(),n("v-main",[n("v-container",{attrs:{fluid:""}},[e.user?e._e():n("div",[n("login",{on:{done:e.HandleLoginOrRegisterComplete}})],1),n("router-view")],1)],1)],1)},l=[],c=n("1da1"),p=(n("96cf"),n("ac1f"),n("1276"),function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-container",[n("v-form",[n("v-text-field",{attrs:{dense:"","prepend-inner-icon":"mdi-account",outlined:"",type:"text",placeholder:"логин"},model:{value:e.login,callback:function(t){e.login=t},expression:"login"}}),n("v-text-field",{attrs:{dense:"","prepend-inner-icon":"mdi-lock",outlined:"",type:"password",placeholder:"пароль"},on:{keyup:function(t){return!t.type.indexOf("key")&&e._k(t.keyCode,"enter",13,t.key,"Enter")?null:e.doLogin()}},model:{value:e.password,callback:function(t){e.password=t},expression:"password"}}),n("v-btn",{staticClass:"btn btn-sm btn-primary btn-block",attrs:{block:"",variant:"primary"},on:{click:function(t){return e.doLogin()}}},[e._v("Вход")]),e.alert?n("v-alert",{attrs:{variant:"danger",show:""}},[n("small",[e._v(e._s(this.alertmessage))])]):e._e()],1)],1)}),d=[],h={data:function(){return{chartShow:!1,alert:!1,alertmessage:null,login:null,password:null,options:{},series:[{name:"solved",data:[]}]}},mounted:function(){},beforeMount:function(){},methods:{doLogin:function(){var e=this;return Object(c["a"])(regeneratorRuntime.mark((function t(){var n;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return t.prev=0,t.next=3,e.$api.post("login",{login:e.login,password:e.password},{skipTokenCheck:!0});case 3:n=t.sent,e.$cookie.set("token",n.token),e.$emit("done"),e.$router.push("/users"),t.next=14;break;case 9:t.prev=9,t.t0=t["catch"](0),e.alertmessage=t.t0.message,e.alert=!0,console.log(t.t0.message);case 14:case"end":return t.stop()}}),t,null,[[0,9]])})))()}}},f=h,m=n("2877"),g=n("6544"),v=n.n(g),b=n("0798"),k=n("8336"),y=n("a523"),_=n("4bd4"),w=n("8654"),x=Object(m["a"])(f,p,d,!1,null,null,null),O=x.exports;v()(x,{VAlert:b["a"],VBtn:k["a"],VContainer:y["a"],VForm:_["a"],VTextField:w["a"]});var $={components:{Login:O},data:function(){return{done:[!1,!1,!1],mouseMonth:null,picker:(new Date).toISOString().substr(0,10),items:[{title:"Основная",icon:"mdi-credit-card-outline",url:"main"},{title:"КТУ",icon:"mdi-file-table-box-multiple",url:"ktu"},{title:"Сотрудники",icon:"mdi-account-group",url:"users"},{title:"Ввод данных",icon:"mdi-database-plus",url:"inputdata"},{title:"Смены",icon:"mdi-calendar",url:"workhours"}],right:null,show_reg:!1,token:null,user:null,role:null,role_parent:null,role_child:null,drawer:!1,group:null,actualdate:null,report_date:null,month_date:null,year_date:null,day_date:1}},beforeMount:function(){this.token=this.$cookie.get("token"),"undefined"===this.token&&(this.token=null),this.alertdate(),console.log("token",this.token),this.token&&this.getUser()},methods:{alertdate:function(){this.month_date=this.picker.split("-")[1],this.year_date=this.picker.split("-")[0],this.actualdate=new Date(this.picker.split("-")[0],this.picker.split("-")[1]-1,1),this.report_date=this.actualdate.getFullYear()+"-"+this.actualdate.getMonth()+"-"+this.actualdate.getDate(),this.$storage.set("report_date",this.report_date),this.$storage.set("month_date",this.month_date),this.$storage.set("year_date",this.year_date),this.$storage.set("day_date",this.day_date),console.log(this.year_date+"-"+this.month_date+"-"+this.day_date),console.log(this.$storage.state.report_date)},doLogout:function(){this.$cookie.delete("token"),this.$storage.set("logged_in",!1),this.user=null,this.token=null,this.$router.push("/")},HandleLoginOrRegisterComplete:function(){this.token=this.$cookie.get("token"),this.getUser()},getUser:function(){var e=this;return Object(c["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(e.token){t.next=2;break}return t.abrupt("return");case 2:return t.prev=2,t.next=5,e.$api.get("users/me");case 5:e.user=t.sent,e.$storage.set("user",e.user),t.next=12;break;case 9:t.prev=9,t.t0=t["catch"](2),401===t.t0.code?(e.$alerterr("Токен устарел, перелогиньтесь."),e.doLogout()):e.$alerterr(t.t0.message);case 12:case"end":return t.stop()}}),t,null,[[2,9]])})))()}}},j=$,P=n("7496"),V=n("40dc"),L=n("5bc1"),S=n("2e4b"),T=n("132d"),C=n("8860"),E=n("56b0"),A=n("da13"),I=n("5d23"),M=n("34c3"),N=n("f6c4"),R=n("f774"),q=n("2fa4"),B=Object(m["a"])(j,u,l,!1,null,null,null),D=B.exports;v()(B,{VApp:P["a"],VAppBar:V["a"],VAppBarNavIcon:L["a"],VBtn:k["a"],VContainer:y["a"],VDatePicker:S["a"],VIcon:T["a"],VList:C["a"],VListGroup:E["a"],VListItem:A["a"],VListItemContent:I["a"],VListItemIcon:M["a"],VListItemTitle:I["b"],VMain:N["a"],VNavigationDrawer:R["a"],VSpacer:q["a"]});var J=n("f309"),U=n("2992"),F=n.n(U);r["a"].use(J["a"]);var G=new J["a"]({theme:{dark:!0},locales:{ru:F.a},current:"ru"}),H=(n("3ca3"),n("ddb0"),n("8c4f"));r["a"].use(H["a"]);var K=[{path:"/about",name:"About",component:function(){return n.e("about").then(n.bind(null,"f820"))}},{path:"/",name:"Start",component:function(){return n.e("about").then(n.bind(null,"bb51"))}},{path:"/main",name:"Main",component:function(){return n.e("about").then(n.bind(null,"cd56"))}},{path:"/ktu",name:"Ktu",component:function(){return n.e("about").then(n.bind(null,"f625"))}},{path:"/users",name:"Users",component:function(){return n.e("about").then(n.bind(null,"ed81"))}},{path:"/inputdata",name:"Inputdata",component:function(){return n.e("about").then(n.bind(null,"0b70"))}},{path:"/workhours",name:"Workhours",component:function(){return n.e("about").then(n.bind(null,"ba4a"))}}],z=new H["a"]({routes:K}),W=z,Y=n("00e7"),Q=n.n(Y),X=(n("bf40"),n("bee2")),Z=n("d4ec"),ee=n("262e"),te=n("2caf"),ne=n("9072"),re=(n("b0c0"),n("99af"),function(e){Object(ee["a"])(n,e);var t=Object(te["a"])(n);function n(e,r){var o;return Object(Z["a"])(this,n),o=t.call(this,e),o.name="ApiError",o.code=r,o}return n}(Object(ne["a"])(Error))),oe=function(){function e(t){Object(Z["a"])(this,e),this.vue=t,this.host="https://x125.ru/api/public";var n=t.cookie.get("token");n&&"undefined"!==n&&(this.token=n)}return Object(X["a"])(e,[{key:"__check_token",value:function(){var e=this;return new Promise((function(t,n){e.token=e.vue.cookie.get("token"),e.token||n(new Error("token missing")),t(null)}))}},{key:"post",value:function(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},n=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};return this.__request("POST",e,t,n)}},{key:"get",value:function(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},n=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};return this.__request("GET",e,t,n)}},{key:"__request",value:function(e,t){var n=this,r=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{},o=arguments.length>3&&void 0!==arguments[3]?arguments[3]:{};return function(){var t=Object(c["a"])(regeneratorRuntime.mark((function t(r,i){var s,u;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(s={},o.skipTokenCheck){t.next=5;break}return t.next=4,n.__check_token();case 4:s["Authorization"]="Token "+n.token;case 5:return u="".concat(n.host,"/").concat(r),console.log("[ ".concat(e," Request ]"),u,JSON.stringify(i)),t.abrupt("return",a()({method:e,url:u,data:"POST"===e?i:null,params:"GET"===e?i:null,headers:s}).then((function(e){return e.data})).catch((function(e){throw new re(e.response.data.message,e.response.status)})));case 8:case"end":return t.stop()}}),t)})));return function(e,n){return t.apply(this,arguments)}}()(t,r)}}]),e}(),ae={install:function(e){e.prototype.$api=new oe(e)}},ie=new r["a"]({data:{state:{user:null}},methods:{set:function(e,t){return JSON.stringify(this.state[e])===JSON.stringify(t)?new Promise((function(e){e()})):(this.state[e]=t,console.log("$storage.set "+e,t),new Promise((function(e){e(t)})))}}}),se={install:function(e){e.prototype.$storage=ie,e.prototype.$global=ie.state,e.prototype.$setGlobal=ie.set}};function ue(){return function(e){this.$bvToast.toast(e.message||e,{title:"Ошибка ",variant:"danger",solid:!0}),console.error(e)}}var le={install:function(e){e.prototype.$alerterr=ue()}};r["a"].use(Q.a),r["a"].use(ae),r["a"].use(se),r["a"].use(le),r["a"].use(G),r["a"].config.productionTip=!1,new r["a"]({vuetify:G,router:W,render:function(e){return e(D)}}).$mount("#app")}});
//# sourceMappingURL=app.b6d67106.js.map