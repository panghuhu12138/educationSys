<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<%@ include file="./head.jsp" %>
	<title>教务管理系统</title>
	<style>
		.el-badge__content.is-fixed {
			top: 3px;
		}

		.bdwxm .el-input__inner {
			border: none;
		}

		.contextmenu {
			margin: 0;
			background: #fff;
			z-index: 3000;
			position: absolute;
			list-style-type: none;
			padding: 5px 0;
			border-radius: 4px;
			font-size: 12px;
			font-weight: 400;
			color: #333;
			box-shadow: 2px 2px 3px 0 rgba(0, 0, 0, .3);
		}

		.contextmenu li {
			margin: 0;
			padding: 7px 16px;
			cursor: pointer;
		}

		.contextmenu li:hover {
			background: #eee;
		}

		#tab-补贴管理 span .el-icon-wallet {
			display: none;
		}

		.el-badge__content.is-fixed {
			z-index: 9;
		}

		/* 弹窗 */
		.formdb-main {
			width: 100%;
		}

		.formdb-main span {
			color: #FA9C41;
		}

		.formdb-top {
			height: 50px;
			padding: 0 30px;
			display: flex;
			justify-content: space-between;
		}

		.formdb-title {
			color: #000;
			font-size: 18px;
			font-weight: bolder;
			line-height: 20px;
		}

		.formdb-tiword {
			font-size: 14px;
			color: #6e6e6e;
		}

		/* 标题 */
		.formdb-bt {
			height: 25px;
			font-size: 16px;
			color: #098fdc;
			padding: 0 25px;
			margin: 5px 10px;
		}

		.formdb-bt p {
			width: 3px;
			height: 16px;
			margin-top: 3px;
			float: left;
			margin-right: 5px;
			background: #098fdc;
		}
		.formdb-xxsbdsh{
			width: 100%;
			margin-bottom: 15px;
		}

		.formdb-xxsbdsh tr {
			width: 100%;
		}

		.formdb-xxsbdsh th {
			padding: 0 30px;
			background: #F5F5F5;
			height: 30px;
			font-weight: lighter;
			border: 1px solid #F5F5F5;
			margin: 0;
		}
		.formdb-xxsbdsh td{
			height: 30px;
			padding: 0 30px;
			font-weight: lighter;
			margin: 0;

		}
	</style>
</head>

<body style="margin:0;padding:0;height:100%">
	<div id="app" v-cloak>
		<!--element ui用的自定义标签，标签名即对应的样式名-->
		<!--总布局容器-->
		<el-container>
			<!--侧边导航-->
			<el-aside style="height:100vh;width:auto">
				<!--MenuActive用于和tab name双向绑定，点击tab定位到对应菜单-->
				<el-menu :Collapse="isCollapse" unique-opened="true" class="el-menu-setwidth"
					:default-active="MenuActive">
					<!--系统logo-->
					<div class="logo"></div>
					<!-- <div class="logo"></div> -->
					<!--历遍一级菜单，没有二级菜单的用el-menu-item显示，并添加@click事件打开url-->
					<!--一级菜单，菜单名必须用span单独包裹，且必须设置icons，收起的时候需要根据容器判断图标和标题-->
					<el-menu-item v-if="!firstMenu.children" v-for="firstMenu in menus" :index="firstMenu.name"
						:key="firstMenu.id"
						@click="opentab(activeTab,firstMenu.name,firstMenu.iconClass,firstMenu.url)"><i
							:class="firstMenu.iconClass"></i><span>{{firstMenu.name }}</span></el-menu-item>
					<!--v-else有二级菜单的用el-submenu显示-->
					<!--一级菜单，菜单名必须用span单独包裹，收起的时候需要根据容器判断图标和标题-->
					<el-submenu :index="firstMenu.id" v-else :key="firstMenu.id">
						<template slot="title"><i
								:class="firstMenu.iconClass"></i><span>{{firstMenu.name}}</span></template>
						<!--历遍二级菜单，没有三级菜单的用el-menu-item显示，并添加@click事件打开url-->
						<!--二级菜单也可以加小图标，同一级写法-->
						<el-menu-item v-if="!secondMenu.children" v-for="secondMenu in firstMenu.children"
							:index="secondMenu.name" :key="secondMenu.id"
							@click="opentab(activeTab,secondMenu.name,secondMenu.iconClass,secondMenu.url)">
							<i style="padding-left:4px;"></i>{{ secondMenu.name }}
						</el-menu-item>
						<!--v-else有三级菜单的用el-submenu显示-->
						<el-submenu :index="secondMenu.id" v-else :key="secondMenu.id"><template slot="title"><i
									style="padding-left:4px;"></i>{{secondMenu.name}}</template>
							<!--opentab()函数参数，activeTab用于向tabs传递当前激活标签和标签总数，.name传递标签名称，url传递标签内容地址-->
							<el-menu-item v-for="thirdMenu in secondMenu.children" :index="thirdMenu.name"
								:key="thirdMenu.id"
								@click="opentab(activeTab,thirdMenu.name,thirdMenu.iconClass,thirdMenu.url)">
								{{ thirdMenu.name }}
							</el-menu-item>
						</el-submenu>
					</el-submenu>
				</el-menu>
			</el-aside>
			<!--数据展示区域容器-->
			<el-container>
				<!--头部-->
				<el-header style="height:38px;padding:0;margin-bottom:7px;">
					<div class="col-icon"><i @click="change" v-bind:class="handClass" title="侧边栏收起"></i></div>
					<div class="sys-title">教务管理系统管理系统</div>
					<div class="logout">
						<el-dropdown class="user-head-drop">
							<!--头像、用户下拉-->
							<el-button type="text" size="small"><i class="el-icon-user"></i>${sessionScope.user.username},<i
									class="el-icon-caret-bottom"></i></el-button>
							<el-dropdown-menu slot="dropdown">
								<!-- 下拉菜单内click事件必须是@click.native -->
								<el-dropdown-item @click.native="dialogpassword = true"><span>修改密码</span>
								</el-dropdown-item>
							</el-dropdown-menu>
						</el-dropdown>
						<el-button @click="exit" type="text" size="small"><i class="el-icon-switch-button"></i>退出</el-button>
					</div>
				</el-header>
				<!--主显示区域-->
				<el-main>
					<div v-show="visible" :style="{left:left+'px',top:top+'px'}" class="contextmenu">
						<li @click="Refreshiframe">刷新</li>
						<li @click="closeOthers">关闭其他</li>
						<li @click="closeall">关闭所有</li>
					</div>
					<!-- 标签切换显示区域 -->
					<el-tabs v-model="activeTab" type="card" closable @tab-remove="removeTab" @tab-click="tabClick"
						@contextmenu.prevent.native="openMenu(activeTab,$event)">
						<!-- label 是tabs名称（必要），name 在判断当前标签和导航菜单对应关系是要用到（必要）-->
						<el-tab-pane v-for="(item, index) in editableTabs" :name="item.name" :key="item.name">
							<span slot="label"><i :class="item.icon"></i> {{item.title}}</span>
							<!--iframe地址用tabs item.content传递,id=itmen.name点击刷新按钮时需要通过该id找到对应iframe-->
							<iframe frameborder="0" style="width:100%;height:calc(100vh - 80px);vertical-align:bottom;"
								:id="item.name" :src="item.content"></iframe>
						</el-tab-pane>
					</el-tabs>
				</el-main>
				<!-- 修改密码弹窗 -->
				<el-dialog title="修改密码" :visible.sync="dialogpassword" width="500px">
					<el-form :model="form" :label-width="formLabelWidth">
						<el-row>
							<el-col :span="24">
								<el-form-item label="原密码">
									<el-input v-model="form.old" placeholder="请输入原密码" autocomplete="off" size="medium">
									</el-input>
								</el-form-item>
								<el-form-item label="新密码">
									<el-input v-model="form.New" placeholder="请输入新密码" autocomplete="off" size="medium">
									</el-input>
								</el-form-item>
								<el-form-item label="确认新密码">
									<el-input v-model="form.confirm" placeholder="请再次输入新密码" autocomplete="off"
										size="medium"></el-input>
								</el-form-item>
							</el-col>
						</el-row>
					</el-form>
					<div slot="footer" class="dialog-footer">
						<el-button type="primary" @click="dialogpassword = false" size="medium">确定</el-button>
						<el-button @click="dialogpassword = false" size="medium">关闭</el-button>
					</div>
				</el-dialog>
				<!-- 绑定微信弹窗 -->
				<el-dialog title="绑定微信" :visible.sync="dialogweixin" width="600px">
					<el-form :model="form" label-width="120px">
						<el-row>
							<el-col :span="24">
								<el-form-item class="bdwxm" label="当前绑定微信名">
									<el-input v-model="form.wxname" placeholder="请输入微信名" autocomplete="off"
										size="medium" readonly>
									</el-input>
								</el-form-item>
								<div style="display: flex;">
									<el-form-item>
										<div style="padding-left: 15px;">
											<el-image :src="form.ewm" style="width: 100px; height: 100px;" fit="fill">
											</el-image>
											<div style="width: 126px;position: relative; bottom: 20px;  left: -6px;">
												扫一扫打开小程序</div>
										</div>
									</el-form-item>
									<el-form-item>
										<div style="padding-left: 15px;">
											<el-image :src="form.ewm" style="width: 100px; height: 100px;" fit="fill">
											</el-image>
											<div style="width: 126px;position: relative; bottom: 20px;  left: -15px;">
												打开小程序扫码绑定</div>
										</div>
									</el-form-item>
								</div>
							</el-col>
						</el-row>
					</el-form>
					<div slot="footer" class="dialog-footer">
						<el-button type="primary" @click="dialogweixin = false" size="medium">确定</el-button>
						<el-button @click="dialogweixin = false" size="medium">取消</el-button>
					</div>
				</el-dialog>
				<!-- 待办事项 -->
				<el-drawer title="" :visible.sync="drawerdb" direction="rtl" size="35%">
					<div class="formdb-main">
						<div class="formdb-top">
							<div class="formdb-title">待办事项</div>
							<div class="formdb-tiword">共计<span>4</span>条待处理</div>
						</div>
						<div class="formdb-bt">
							信息申报待审核 <span>2</span>条
						</div>
						<table class="formdb-xxsbdsh" border="0">
							<tr>
								<th align="left">名称</th>
								<th align="left">时间</th>
							</tr>
							<tr>
								<td>溧水区大王村忘情水家庭农场</td>
								<td>2021-09-18</td>
							</tr>
							<tr>
								<td>溧水区大王村忘情水家庭农场</td>
								<td>2021-09-18</td>
							</tr>
						</table>
						<div class="formdb-bt">
							示范等级申请待审核 <span>2</span>条
						</div>
						<table class="formdb-xxsbdsh" border="0">
							<tr>
								<th align="left">名称</th>
								<th align="left">时间</th>
							</tr>
							<tr>
								<td>溧水区大王村忘情水家庭农场</td>
								<td>2021-09-18</td>
							</tr>
							<tr>
								<td>溧水区大王村忘情水家庭农场</td>
								<td>2021-09-18</td>
							</tr>
						</table>
					</div>
				</el-drawer>
			</el-container>
		</el-container>
	</div>
	<script>
		"use strict";
		new Vue({
			el: '#app',
			// 基础参数初始化
			data: {
				visible: false,
				top: 0,
				left: 0,
				selectedTag: {},
				affixTags: [],
				/*初始化侧边栏展开*/
				isCollapse: false,
				/*初始化activeTab变量，对应页面tabs v-model，注意 // 菜单和tabs都用 [菜单名称] 做对应标识*/
				activeTab: '首页',
				MenuActive: '首页', //左侧选中菜单
				/*初始化默认tabs*/
				editableTabs: [{
						title: '首页',
						name: '首页',
						content: '<%=request.getContextPath()%>/user/index.do'
					}
				],
				items: [{
					news: "XXX（指信用服务机构）已转出您辖区，新申报地区为常州，特此通知"
				}, {
					news: "XXX（指信用服务机构）已转出您辖区，新申报地区为常州，特此通知"
				}, {
					news: "XXX（指信用服务机构）已转出您辖区，新申报地区为常州，特此通知"
				}, {
					news: "XXX（指信用服务机构）已转出您辖区，新申报地区为常州，特此通知"
				}],
				tabIndex: 1,
				/*导航初始化*/
				menus: [],
				headurl: 'images/tx.jpg',
				// 表单数据初始化
				dialogpassword: false,
				dialogweixin: false,
				form: {
					old: '',
					New: '',
					confirm: '',
					date2: '',
					wxname: 'weixinxxxxx',
					ewm: '<%=request.getContextPath()%>/images/ewm.png',
				},
				formdb: {
					place: '',
					type: '',
					name: '',
					owner: '',
					sfjlhndml: '',
					bmdj: '',
					level: '',
					state: ''
				},
				drawerdb: false,
				formLabelWidth: '90px'
			},
			//导航展开收起样式绑定v-bind
			computed: {
				handClass: function () {
					return {
						base: true,
						'el-icon-s-fold': !this.isCollapse,
						'el-icon-s-unfold': this.isCollapse
					}
				}
			},
			mounted: function () {
				this.getnavData();
				const me = this;
				window.opentab = me.opentab;
				window.removeTab = me.removeTab;
				window.Refreshiframe = me.Refreshiframe;
			},
			methods: {
				submitForm: function () {
					this.drawerdb = false
				},
				closeDropdown: function (index) {
					console.log(index);
					this.items.splice(index, 1);
				},
				//获取json数据，给导航menus
				getnavData: function () {
					var self = this
					axios({
						url: '<%=request.getContextPath()%>/static/json/navmenu.json',
						method: 'get'
					}).then(function (res) {
						self.menus = res.data.menus
					})
				},
				Refreshiframe: function () {
					// 通过this.acitveTab传递当前iframe id用于判断刷新当前iframe
					var iframeid = this.activeTab
					document.querySelector('#' + iframeid).contentWindow.location.reload()
				},
				closeall: function () {
					//关闭所有tabs
					this.tabIndex = 1
					this.activeTab = "首页"
					this.editableTabs = [{
						title: '首页',
						name: '首页',
						content: 'first.html'
					}]
				},
				closeOthers: function () {
					console.log(this.editableTabs)
				},
				openMenu: function (tag, e) {
					const menuMinWidth = 100
					const offsetLeft = this.$el.getBoundingClientRect().left // container margin left
					const offsetWidth = this.$el.offsetWidth // container width
					const maxLeft = offsetWidth - menuMinWidth // left boundary
					const left = e.clientX - offsetLeft - 15 // 15: margin right

					if (left > maxLeft) {
						this.left = maxLeft
					} else {
						this.left = left
					}

					this.top = e.clientY
					this.visible = true
					this.activeTab = tag
				},
				/*点击打开新tabs*/
				opentab: function (activeTab, nvname, icon, url) {
					let flag = true //判断是否需要新增页面
					var menulist = this.editableTabs
					for (var o in menulist) {
						if (menulist[o].title == nvname) {
							this.activeTab = menulist[o].name //定位到已打开页面
							flag = false;
							break;
						}
					}
					if (nvname == '驾驶舱') {
						window.open('./static/echarts/驾驶舱.html')
					} else if (flag) {
						//动态双向追加tabs
						this.editableTabs.push({
							title: nvname,
							name: nvname,
							icon: icon,
							content: url,
						});
						this.activeTab = nvname;
						//更改菜单激活指向
						this.MenuActive = nvname;
					}
				},
				/*点击tabs菜单定位到对应MenuActive,两边都通过name标识*/
				tabClick: function (tab) {
					this.MenuActive = tab.name
				},
				/*关闭tabs*/
				removeTab: function (targetName) {
					let tabs = this.editableTabs;
					let activeName = this.activeTab;
					if (targetName === '首页') {
						this.$message.warning('首页不可关闭！')
						return
					} else {
						if (activeName === targetName) {
							tabs.forEach(function (tab, index) {
								if (tab.name === targetName) {
									let nextTab = tabs[index + 1] || tabs[index - 1];
									if (nextTab) {
										activeName = nextTab.name;
									}
								}
							});
						}
					}
					this.activeTab = activeName;
					this.editableTabs = tabs.filter(function (tab) {
						return tab.name !== targetName
					});
				},
				// 上传图片
				handleAvatarSuccess: function (res, file) {
					this.headurl = URL.createObjectURL(file.raw);
					console.log(this.headurl)
				},
				// 上传图片限制
				beforeAvatarUpload: function (file) {
					const isJPG = file.type === 'image/jpeg';
					const isPNG = file.type === 'image/png';
					// 取整数有小数点自动个位+1
					const isLt512K = Math.ceil(file.size / 1024) <= 512;
					if (!isJPG && !isPNG) {
						this.$message.error('上传头像图片只能是 JPG或PNG 格式!');
					}
					if (!isLt512K) {
						this.$message.error('上传头像图片大小不能超过 512K');
					}
					return isJPG && isLt512K;
				},
				//导航展开收起
				change: function () {
					if (this.isCollapse === true) {
						this.isCollapse = false
					} else {
						this.isCollapse = true
					}
				},
				// 子页面新增tab
				ChildAddTabs: function (activeTab, nvname, icon, url) {
					window.parent.opentab(activeTab, nvname, icon, url)
				},
				// 返回登录
				backlogin: function () {
					window.open('login.html', '_self')
				},
				closeMenu: function () {
					this.visible = false
				},

				/*退出*/
				exit() {
					this.$confirm('确认退出？', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						window.top.location.replace("<%=request.getContextPath()%>/login/loginOut.do")
					}).catch((err) => {
						if (err !== 'cancel') {
							this.$message({
								type: 'error',
								message: '页面异常！请联系管理员！'
							}, setTimeout(() => {
								window.top.location.replace("<%=request.getContextPath()%>/login/loginOut.do")
							}, 1000));
						}
					})
				},
			},
			watch: {
				visible: function (value) {
					if (value) {
						document.body.addEventListener('click', this.closeMenu)
					} else {
						document.body.removeEventListener('click', this.closeMenu)
					}
				}
			}
		});
	</script>
</body>

</html>