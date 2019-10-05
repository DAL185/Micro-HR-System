webpackJsonp([1],{"/LNZ":function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a={render:function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",[i("div",{staticStyle:{"text-align":"left"}},[i("el-input",{staticStyle:{width:"300px"},attrs:{placeholder:"position"==e.state?"Add Position...":"Add Title...",size:"mini","prefix-icon":"el-icon-plus"},nativeOn:{keyup:function(t){if(!("button"in t)&&e._k(t.keyCode,"enter",13,t.key))return null;e.addPosition(t)}},model:{value:e.positionName,callback:function(t){e.positionName=t},expression:"positionName"}}),e._v(" "),"jobtitle"==e.state?i("el-select",{attrs:{size:"mini",placeholder:"Title Level"},model:{value:e.titleLevel,callback:function(t){e.titleLevel=t},expression:"titleLevel"}},e._l(e.titleLevels,function(e){return i("el-option",{key:e,attrs:{label:e,value:e}})})):e._e(),e._v(" "),i("el-button",{attrs:{type:"primary",icon:"el-icon-plus",size:"mini"},on:{click:e.addPosition}},[e._v("Add")])],1),e._v(" "),i("div",{staticStyle:{"margin-top":"10px"}},[i("el-table",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticStyle:{width:"80%"},attrs:{data:e.posData,size:"mini",stripe:"",border:""},on:{"selection-change":e.handleSelectionChange}},[i("el-table-column",{attrs:{type:"selection",width:"55",align:"left"}}),e._v(" "),i("el-table-column",{attrs:{prop:"id",label:"Number",width:"80",align:"left"}}),e._v(" "),i("el-table-column",{attrs:{prop:"name",label:"position"==e.state?"Position Name":"Title Name",width:"180",align:"left"}}),e._v(" "),"jobtitle"==e.state?i("el-table-column",{attrs:{prop:"titleLevel",label:"Title Level",width:"180",align:"left"}}):e._e(),e._v(" "),i("el-table-column",{attrs:{width:"180",label:"Created Time",align:"left"},scopedSlots:e._u([{key:"default",fn:function(t){return[e._v(e._s(e._f("formatDate")(t.row.createDate)))]}}])}),e._v(" "),i("el-table-column",{attrs:{label:"Operating",align:"left"},scopedSlots:e._u([{key:"default",fn:function(t){return[i("el-button",{attrs:{size:"mini"},on:{click:function(i){e.handleEdit(t.$index,t.row)}}},[e._v("Edit\n          ")]),e._v(" "),i("el-button",{attrs:{size:"mini",type:"danger"},on:{click:function(i){e.handleDelete(t.$index,t.row)}}},[e._v("Delete\n          ")])]}}])})],1)],1),e._v(" "),i("div",{staticStyle:{"text-align":"left","margin-top":"10px"}},[e.posData.length>0?i("el-button",{attrs:{type:"danger",size:"mini",disabled:0==e.multipleSelection.length},on:{click:e.deleteMany}},[e._v("Batch Delete\n    ")]):e._e()],1),e._v(" "),i("div",{staticStyle:{"text-align":"left"}},[i("el-dialog",{attrs:{title:"position"==e.state?"Edit Position":"Edit Title",visible:e.dialogVisible,width:"25%"},on:{"update:visible":function(t){e.dialogVisible=t}}},[i("el-input",{attrs:{size:"mini",placeholder:"Please input new position..."},model:{value:e.updatePosName,callback:function(t){e.updatePosName=t},expression:"updatePosName"}}),e._v(" "),"jobtitle"==e.state?i("el-select",{staticStyle:{"margin-top":"10px"},attrs:{size:"mini",placeholder:"Title Level"},model:{value:e.updateTitleLevel,callback:function(t){e.updateTitleLevel=t},expression:"updateTitleLevel"}},e._l(e.titleLevels,function(e){return i("el-option",{key:e,attrs:{label:e,value:e}})})):e._e(),e._v(" "),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{attrs:{size:"mini"},on:{click:function(t){e.dialogVisible=!1}}},[e._v("Cancel")]),e._v(" "),i("el-button",{attrs:{type:"primary",size:"mini"},on:{click:e.updatePosNameExec}},[e._v("Confirm")])],1)],1)],1)])},staticRenderFns:[]},n=i("VU/8")({mounted:function(){this.loadTableData()},methods:{updatePosNameExec:function(){var e=this;if(this.isNotNullORBlank(this.updatePosName)){this.loading=!0;var t=this;this.putRequest("position"==this.state?"/system/basic/position":"/system/basic/joblevel",{name:this.updatePosName,id:this.updatePosId,titleLevel:this.updateTitleLevel}).then(function(i){t.loading=!1,i&&200==i.status&&(e.dialogVisible=!1,i.data,t.loadTableData())})}else this.$message.warning("position"==this.state?"Position cannot be empty!":"Title cannot be empty!")},deleteMany:function(){var e=this,t=this;this.$confirm("Delete"+this.multipleSelection.length+"rows, continue?","reminder",{confirmButtonText:"Confirm",cancelButtonText:"Cancel",type:"warning"}).then(function(){var e="";t.multipleSelection.forEach(function(t){e=e+t.id+","}),t.doDelete(e)}).catch(function(){e.$message({type:"info",message:"Delete Canceled"})})},addPosition:function(){if(this.isNotNullORBlank(this.positionName))if("jobtitle"!=this.state||this.isNotNullORBlank(this.titleLevel)){var e=this;this.loading=!0,this.postRequest("position"==this.state?"/system/basic/position":"/system/basic/joblevel",{name:this.positionName,titleLevel:this.titleLevel}).then(function(t){e.loading=!1,t&&200==t.status&&(t.data,e.loadTableData(),e.positionName="",e.titleLevel="")})}else this.$message.warning("Please select title level!");else this.$message.warning("position"==this.state?"Position cannot be empty!":"Title cannot be empty!")},handleSelectionChange:function(e){this.multipleSelection=e},handleEdit:function(e,t){this.updatePosName=t.name,this.updatePosId=t.id,this.updateTitleLevel=t.titleLevel,this.dialogVisible=!0},handleDelete:function(e,t){var i=this,a=this;this.$confirm("Delete["+t.name+"], continue?","reminder",{confirmButtonText:"Confirm",cancelButtonText:"Cancel",type:"warning"}).then(function(){a.doDelete(t.id)}).catch(function(){i.$message({type:"info",message:"Delete Canceled"})})},doDelete:function(e){var t=this;t.loading=!0;var i="position"==this.state?"/system/basic/position/":"/system/basic/joblevel/";this.deleteRequest(i+e).then(function(e){t.loading=!1,e&&200==e.status&&t.loadTableData()})},loadTableData:function(){var e=this;this.loading=!0,this.getRequest("position"==this.state?"/system/basic/positions":"/system/basic/joblevels").then(function(t){e.loading=!1,t&&200==t.status&&(e.posData=t.data)})}},data:function(){return{positionName:"",updatePosName:"",updateTitleLevel:"",titleLevel:"",updatePosId:-1,loading:!1,dialogVisible:!1,multipleSelection:[],type:[],titleLevels:["Senior","Intermediate","Primary","Internship"],nameLabelName:"position"==this.state?"Position Name":"Title Name",posData:[]}},props:["state"]},a,!1,null,null,null);t.default=n.exports},"1L+s":function(e,t,i){"use strict";var a={render:function(){this.$createElement;this._self._c;return this._m(0)},staticRenderFns:[function(){var e=this.$createElement,t=this._self._c||e;return t("div",[t("h1",[this._v("Title Management")])])}]};t.a=a},FvOz:function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a=i("bOdI"),n=i.n(a),l={data:function(){return{keywords:"",depName:"",treeLoading:!1,dialogVisible:!1,allDeps:[],pDep:"",treeData:[],defaultProps:{label:"name",isLeaf:"leaf",children:"children"}}},mounted:function(){this.treeLoading=!0,this.loadTreeData()},watch:{keywords:function(e){this.$refs.tree.filter(e)}},methods:{filterNode:function(e,t){return!e||-1!==t.name.indexOf(e)},loadTreeData:function(){var e=this;this.getRequest("/system/basic/dep/-1").then(function(t){e.treeLoading=!1,t&&200==t.status&&(e.treeData=t.data)})},setDataToTree:function(e,t,i){for(var a=0;a<e.length;a++){var n=e[a];if(n.id==t)return void(e[a].children=e[a].children.concat(i));this.setDataToTree(n.children,t,i)}},addDep:function(){var e=this;this.dialogVisible=!1,this.treeLoading=!0,this.postRequest("/system/basic/dep",{name:this.depName,parentId:this.pDep}).then(function(t){if(e.treeLoading=!1,t&&200==t.status){var i=t.data;e.depName="",e.setDataToTree(e.treeData,e.pDep,i.msg)}})},loadAllDeps:function(){var e=this;this.getRequest("/system/basic/deps").then(function(t){t&&200==t.status&&(e.allDeps=t.data)})},showAddDepView:function(e,t){this.loadAllDeps(),this.dialogVisible=!0,this.pDep=e.id,t.stopPropagation()},deleteDep:function(e,t){var i=this;e.children.length>0?this.$message({message:"this department cannot be deleted because of under departments!",type:"warning"}):this.$confirm("Delete["+e.name+"]department, continue?","reminder",{confirmButtonText:"Confirm",cancelButtonText:"Cancel",type:"warning"}).then(function(){i.treeLoading=!0,i.deleteRequest("/system/basic/dep/"+e.id).then(function(t){if(i.treeLoading=!1,t&&200==t.status){t.data;i.deleteLocalDep(i.treeData,e)}})}).catch(function(){i.$message({type:"info",message:"Delete Canceled"})}),t.stopPropagation()},deleteLocalDep:function(e,t){for(var i=0;i<e.length;i++){var a=e[i];if(a.id==t.id)return void e.splice(i,1);this.deleteLocalDep(a.children,t)}},renderContent:function(e,t){var i,a,l=this,s=t.node,o=t.data;t.store;return e("span",{style:"flex: 1; display: flex; align-items: center; justify-content: space-between; font-size: 14px; padding-right: 8px;"},[e("span",null,[e("span",null,[s.label])]),e("span",null,[e("el-button",(i={style:"font-size: 12px;",attrs:{type:"primary",size:"mini"}},n()(i,"style","padding:3px"),n()(i,"on",{click:function(){return l.showAddDepView(o,event)}}),i),["Add Department"]),e("el-button",(a={style:"font-size: 12px;",attrs:{type:"danger",size:"mini"}},n()(a,"style","padding:3px"),n()(a,"on",{click:function(){return l.deleteDep(o,event)}}),a),["Delete Department"])])])}}},s={render:function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",[i("div",{staticStyle:{"text-align":"left"}},[i("el-input",{staticStyle:{width:"500px",margin:"0px",padding:"0px"},attrs:{placeholder:"Please input department name...",size:"mini","prefix-icon":"el-icon-search"},model:{value:e.keywords,callback:function(t){e.keywords=t},expression:"keywords"}})],1),e._v(" "),i("div",[i("el-tree",{directives:[{name:"loading",rawName:"v-loading",value:e.treeLoading,expression:"treeLoading"}],ref:"tree",staticStyle:{width:"500px","margin-top":"10px"},attrs:{props:e.defaultProps,data:e.treeData,"filter-node-method":e.filterNode,"render-content":e.renderContent}}),e._v(" "),i("div",{staticStyle:{"text-align":"left"}},[i("el-dialog",{attrs:{title:"Add Department",visible:e.dialogVisible,width:"25%"},on:{"update:visible":function(t){e.dialogVisible=t}}},[i("div",[i("span",[e._v("Higher Department")]),e._v(" "),i("el-select",{staticStyle:{width:"200px"},attrs:{placeholder:"Please select",size:"mini"},model:{value:e.pDep,callback:function(t){e.pDep=t},expression:"pDep"}},e._l(e.allDeps,function(e){return i("el-option",{key:e.id,attrs:{label:e.name,value:e.id}})}))],1),e._v(" "),i("div",{staticStyle:{"margin-top":"10px"}},[i("span",[e._v("Department Name")]),e._v(" "),i("el-input",{staticStyle:{width:"200px"},attrs:{size:"mini",placeholder:"Please input department name..."},nativeOn:{keyup:function(t){if(!("button"in t)&&e._k(t.keyCode,"enter",13,t.key))return null;e.addDep(t)}},model:{value:e.depName,callback:function(t){e.depName=t},expression:"depName"}})],1),e._v(" "),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{attrs:{size:"small"},on:{click:function(t){e.dialogVisible=!1}}},[e._v("Cancel")]),e._v(" "),i("el-button",{attrs:{size:"small",type:"primary"},on:{click:e.addDep}},[e._v("Add")])],1)])],1)],1)])},staticRenderFns:[]},o=i("VU/8")(l,s,!1,null,null,null);t.default=o.exports},LJAE:function(e,t,i){var a={"./SysBasic.vue":"fc7a","./SysHr.vue":"ewEk","./basic/DepMana.vue":"FvOz","./basic/JobTitleMana.vue":"c98W","./basic/MenuRole.vue":"eLaH","./basic/PosMana.vue":"/LNZ"};function n(e){return i(l(e))}function l(e){var t=a[e];if(!(t+1))throw new Error("Cannot find module '"+e+"'.");return t}n.keys=function(){return Object.keys(a)},n.resolve=l,e.exports=n,n.id="LJAE"},XSWk:function(e,t){},bOdI:function(e,t,i){"use strict";t.__esModule=!0;var a,n=i("C4MV"),l=(a=n,a&&a.__esModule?a:{default:a});t.default=function(e,t,i){return t in e?(0,l.default)(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}},c98W:function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a=i("XSWk"),n=i.n(a);for(var l in a)"default"!==l&&(s=l,i.d(t,s,function(){return a[s]}));var s,o=i("1L+s"),r=i("VU/8")(n.a,o.a,!1,null,null,null);t.default=r.exports},eLaH:function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a=i("oAV5"),n={mounted:function(){this.loading=!0,this.initRoles()},methods:{deleteRole:function(e,t){var i=this;this.$confirm("Delete role["+t+"], continue?","reminder",{confirmButtonText:"Confirm",cancelButtonText:"Cancel",type:"warning"}).then(function(){i.loading=!0,i.deleteRequest("/system/basic/role/"+e).then(function(e){e&&200==e.status?i.initRoles():i.loading=!1})}).catch(function(){i.$message({type:"info",message:"Delete Canceled"})})},addNewRole:function(){if(Object(a.b)(this.newRole,this.newRoleZh)){this.loading=!0;var e=this;this.postRequest("/system/basic/addRole",{role:this.newRole,roleZh:this.newRoleZh}).then(function(t){if(t&&200==t.status){t.data;e.initRoles(),e.newRole="",e.newRoleZh=""}else e.loading=!1})}},updateRoleMenu:function(e){var t=this.$refs.tree[e].getCheckedKeys(!0),i=this;this.putRequest("/system/basic/updateMenuRole",{rid:this.activeColItem,mids:t}).then(function(e){e&&200==e.status&&(i.activeColItem=-1)})},collapseChange:function(e){if(""!=e){var t=this;this.getRequest("/system/basic/menuTree/"+e).then(function(e){if(e&&200==e.status){var i=e.data;t.treeData=i.menus,t.checkedKeys=i.mids}})}},handleCheckChange:function(e,t,i){},initRoles:function(){var e=this;this.getRequest("/system/basic/roles").then(function(t){e.loading=!1,t&&200==t.status&&(e.roles=t.data,e.activeColItem=-1)})},cancelUpdateRoleMenu:function(){this.activeColItem=-1}},data:function(){return{props:{label:"name",children:"children"},newRole:"",newRoleZh:"",roles:[],treeData:[],checkedKeys:[],loading:!1,activeColItem:-1}}},l={render:function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",[i("div",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticStyle:{"text-align":"left"}},[i("el-input",{staticStyle:{width:"250px"},attrs:{placeholder:"Please input role English name...",size:"mini"},model:{value:e.newRole,callback:function(t){e.newRole=t},expression:"newRole"}},[i("template",{slot:"prepend"},[e._v("ROLE_")])],2),e._v(" "),i("el-input",{staticStyle:{width:"250px"},attrs:{placeholder:"Please input role Chinese name...",size:"mini"},model:{value:e.newRoleZh,callback:function(t){e.newRoleZh=t},expression:"newRoleZh"}}),e._v(" "),i("el-button",{staticStyle:{"margin-left":"5px"},attrs:{type:"primary",size:"mini"},on:{click:e.addNewRole}},[e._v("Add Role")])],1),e._v(" "),i("div",{staticStyle:{"margin-top":"10px","text-align":"left"}},[i("el-collapse",{staticStyle:{width:"500px"},attrs:{accordion:""},on:{change:e.collapseChange},model:{value:e.activeColItem,callback:function(t){e.activeColItem=t},expression:"activeColItem"}},e._l(e.roles,function(t,a){return i("el-collapse-item",{key:t.name,attrs:{title:t.nameZh,name:t.id}},[i("el-card",{staticClass:"box-card"},[i("div",{attrs:{slot:"header"},slot:"header"},[i("span",[e._v("Available Resources")]),e._v(" "),i("el-button",{staticStyle:{color:"#f6061b",margin:"0px",float:"right",padding:"3px 0",width:"15px",height:"15px"},attrs:{type:"text",icon:"el-icon-delete"},on:{click:function(i){e.deleteRole(t.id,t.nameZh)}}})],1),e._v(" "),i("div",[i("el-tree",{key:t.id,ref:"tree",refInFor:!0,attrs:{props:e.props,data:e.treeData,"default-checked-keys":e.checkedKeys,"node-key":"id","show-checkbox":"","highlight-current":""},on:{"check-change":e.handleCheckChange}})],1),e._v(" "),i("div",{staticStyle:{display:"flex","justify-content":"flex-end","margin-right":"10px"}},[i("el-button",{attrs:{size:"mini"},on:{click:e.cancelUpdateRoleMenu}},[e._v("Cancel Modification")]),e._v(" "),i("el-button",{attrs:{type:"primary",size:"mini"},on:{click:function(t){e.updateRoleMenu(a)}}},[e._v("Confirm Modification")])],1)])],1)}))],1)])},staticRenderFns:[]},s=i("VU/8")(n,l,!1,null,null,null);t.default=s.exports},ewEk:function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a={data:function(){return{keywords:"",fullloading:!1,hrs:[],cardLoading:[],eploading:[],allRoles:[],moreBtnState:!1,selRoles:[],selRolesBak:[]}},mounted:function(){this.initCards(),this.loadAllRoles()},methods:{searchClick:function(){this.initCards(),this.loadAllRoles()},updateHrRoles:function(e,t){this.moreBtnState=!1;var i=this;if(this.selRolesBak.length==this.selRoles.length){for(var a=0;a<this.selRoles.length;a++)for(var n=0;n<this.selRolesBak.length;n++)if(this.selRoles[a]==this.selRolesBak[n]){this.selRolesBak.splice(n,1);break}if(0==this.selRolesBak.length)return}this.eploading.splice(t,1,!0),this.putRequest("/system/hr/roles",{hrId:e,rids:this.selRoles}).then(function(a){if(i.eploading.splice(t,1,!1),a&&200==a.status){"success"==a.data.status&&i.refreshHr(e,t)}})},refreshHr:function(e,t){var i=this;i.cardLoading.splice(t,1,!0),this.putRequest("/system/hr/id/"+e).then(function(e){i.cardLoading.splice(t,1,!1),i.hrs.splice(t,1,e.data)})},loadSelRoles:function(e,t){var i=this;this.moreBtnState=!0,this.selRoles=[],this.selRolesBak=[],e.forEach(function(e){i.selRoles.push(e.id),i.selRolesBak.push(e.id)})},loadAllRoles:function(){var e=this;this.getRequest("/system/basic/roles").then(function(t){e.fullloading=!1,t&&200==t.status&&(e.allRoles=t.data)})},switchChange:function(e,t,i){var a=this;a.cardLoading.splice(i,1,!0),this.putRequest("/system/hr/",{enabled:e,id:t}).then(function(e){if(a.cardLoading.splice(i,1,!1),e&&200==e.status){"error"==e.data.status&&a.refreshHr(t,i)}else a.refreshHr(t,i)})},initCards:function(){this.fullloading=!0;var e,t=this;e=""===this.keywords?"all":this.keywords,this.getRequest("/system/hr/"+e).then(function(e){if(e&&200==e.status){t.hrs=e.data;var i=e.data.length;t.cardLoading=Array.apply(null,Array(i)).map(function(e,t){return!1}),t.eploading=Array.apply(null,Array(i)).map(function(e,t){return!1})}})},deleteHr:function(e){var t=this;this.fullloading=!0,this.deleteRequest("/system/hr/"+e).then(function(e){if(t.fullloading=!1,e&&200==e.status){"success"==e.data.status&&(t.initCards(),t.loadAllRoles())}})}}},n={render:function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{directives:[{name:"loading",rawName:"v-loading",value:e.fullloading,expression:"fullloading"}],staticStyle:{"margin-top":"10px"}},[i("div",{staticStyle:{"margin-bottom":"10px",display:"flex","justify-content":"center","align-items":"center"}},[i("el-input",{staticStyle:{width:"400px","margin-right":"10px"},attrs:{placeholder:"Show some users by default, you can search for more users by username...","prefix-icon":"el-icon-search",size:"small"},model:{value:e.keywords,callback:function(t){e.keywords=t},expression:"keywords"}}),e._v(" "),i("el-button",{attrs:{size:"small",type:"primary",icon:"el-icon-search"},on:{click:e.searchClick}},[e._v("Search")])],1),e._v(" "),i("div",{staticStyle:{display:"flex","justify-content":"space-around","flex-wrap":"wrap","text-align":"left"}},e._l(e.hrs,function(t,a){return i("el-card",{directives:[{name:"loading",rawName:"v-loading",value:e.cardLoading[a],expression:"cardLoading[index]"}],key:t.id,staticStyle:{width:"350px","margin-bottom":"20px"}},[i("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[i("span",[e._v(e._s(t.name))]),e._v(" "),i("el-button",{staticStyle:{color:"#f6061b",margin:"0px",float:"right",padding:"3px 0",width:"15px",height:"15px"},attrs:{type:"text",icon:"el-icon-delete"},on:{click:function(i){e.deleteHr(t.id)}}})],1),e._v(" "),i("div",[i("div",{staticStyle:{width:"100%",display:"flex","justify-content":"center"}},[i("img",{staticStyle:{width:"70px",height:"70px","border-radius":"70px"},attrs:{src:t.userface,alt:"item.name"}})]),e._v(" "),i("div",{staticStyle:{"margin-top":"20px"}},[i("div",[i("span",{staticClass:"user-info"},[e._v("Username:"+e._s(t.name))])]),e._v(" "),i("div",[i("span",{staticClass:"user-info"},[e._v("Phone Number:"+e._s(t.phone))])]),e._v(" "),i("div",[i("span",{staticClass:"user-info"},[e._v("Tel Number:"+e._s(t.telephone))])]),e._v(" "),i("div",[i("span",{staticClass:"user-info"},[e._v("Address:"+e._s(t.address))])]),e._v(" "),i("div",{staticClass:"user-info",staticStyle:{display:"flex","align-items":"center","margin-bottom":"3px"}},[e._v("\n              User Status:\n              "),i("el-switch",{key:t.id,staticStyle:{display:"inline","margin-left":"5px"},attrs:{"active-color":"#13ce66","inactive-color":"#aaaaaa","active-text":"Start","inactive-text":"Disable"},on:{change:function(i){e.switchChange(t.enabled,t.id,a)}},model:{value:t.enabled,callback:function(i){e.$set(t,"enabled",i)},expression:"item.enabled"}})],1),e._v(" "),i("div",{staticClass:"user-info"},[e._v("\n              User Role:\n              "),e._l(t.roles,function(t){return i("el-tag",{key:t.id,staticStyle:{"margin-right":"5px"},attrs:{type:"success",size:"mini","disable-transitions":!1}},[e._v(e._s(t.nameZh)+"\n              ")])}),e._v(" "),i("el-popover",{directives:[{name:"loading",rawName:"v-loading",value:e.eploading[a],expression:"eploading[index]"}],key:t.id,attrs:{placement:"right",title:"Role List",width:"200",trigger:"click"},on:{hide:function(i){e.updateHrRoles(t.id,a)}}},[i("el-select",{attrs:{multiple:"",placeholder:"Please select role"},model:{value:e.selRoles,callback:function(t){e.selRoles=t},expression:"selRoles"}},e._l(e.allRoles,function(e){return i("el-option",{key:e.id,attrs:{label:e.nameZh,value:e.id}})})),e._v(" "),i("el-button",{staticStyle:{color:"#09c0f6","padding-top":"0px"},attrs:{slot:"reference",type:"text",icon:"el-icon-more",disabled:e.moreBtnState},on:{click:function(i){e.loadSelRoles(t.roles,a)}},slot:"reference"})],1)],2),e._v(" "),i("div",[i("span",{staticClass:"user-info"},[e._v("Remark:"+e._s(t.remark))])])])])])}))])},staticRenderFns:[]};var l=i("VU/8")(a,n,!1,function(e){i("hgG6")},null,null);t.default=l.exports},fc7a:function(e,t,i){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var a=i("eLaH"),n=i("FvOz"),l=i("c98W"),s=i("/LNZ"),o={data:function(){return{defaultTab:"depMana"}},methods:{},components:{"menu-role":a.default,"dep-mana":n.default,"jobtitle-mana":l.default,"pos-mana":s.default}},r={render:function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticStyle:{"margin-top":"10px"}},[i("el-tabs",{attrs:{type:"card"},model:{value:e.defaultTab,callback:function(t){e.defaultTab=t},expression:"defaultTab"}},[i("el-tab-pane",{attrs:{label:"Department Management",name:"depMana"}},[i("dep-mana")],1),e._v(" "),i("el-tab-pane",{attrs:{label:"Position Management",name:"positionMana"}},[i("pos-mana",{attrs:{state:"position"}})],1),e._v(" "),i("el-tab-pane",{attrs:{label:"Title Management",name:"jobTitleMana"}},[i("pos-mana",{attrs:{state:"jobtitle"}})],1),e._v(" "),i("el-tab-pane",{attrs:{label:"Permission Group",name:"menuRole"}},[i("menu-role")],1)],1)],1)},staticRenderFns:[]},d=i("VU/8")(o,r,!1,null,null,null);t.default=d.exports},hgG6:function(e,t){}});
//# sourceMappingURL=1.fdbb112d3950d3e9c2f7.js.map