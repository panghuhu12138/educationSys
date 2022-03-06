<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <%@ include file="../head.jsp" %>
    <title>用户管理</title>
    <style>
        .el-badge sup {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block !important;
            padding: 0;
        }
        .el-checkbox__label {
            font-size: 12px;
        }
    </style>
</head>
<body style="margin:0;padding:0 10px;">
<div id="yhgl" v-cloak>
    <!-- 查询条件，操作按钮 -->
    <div class="opt-area">
        <div class="opt-button">
            <el-button icon="el-icon-plus" type="primary" plain size="small"
                       @click="ChildAddTabs('用户管理-新增','用户管理-新增','','<%=request.getContextPath()%>/user/toUserEdit.do')">新增</el-button>
            <el-button icon="el-icon-delete" type="primary" plain size="small"
                       @click="MultipleDel(multipleSelection.length)">
                删除</el-button>
            <el-button icon="el-icon-refresh" type="primary" size="small" plain @click="resetPassword(multipleSelection.length)">重置密码</el-button>
        </div>
        <div class="opt-search">
            <!-- 设置 inline 属性可以让表单域变为行内的表单域 el-form中的size,label-width参数可继承到全部子el-form-item-->
            <!-- label-width默认auto -->
            <el-form :inline="true" :model="formInline" size="mini">
                <!-- el-form-item就相当于label -->
                <el-form-item label="学号或工号">
                    <el-input v-model="formInline.userNum" placeholder="请输入学号或者工号" />
                </el-form-item>
                <el-form-item label="姓名">
                    <el-input v-model="formInline.username" placeholder="请输入姓名" />
                </el-form-item>
                <el-form-item class="tmove">
                    <el-button-group>
                        <el-button icon="el-icon-search" size="small" type="primary" @click="search">查询</el-button>
                    </el-button-group>
                    <el-button icon="el-icon-caret-bottom" size="small" type="primary" plain @click="drawer = true">高级查询
                    </el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
    <el-drawer title="高级查询" :visible.sync="drawer" direction="rtl" size="36%">
        <el-form ref="formInline" :model="formInline" size="small" label-width="100px" style="padding: 0 15px;">
            <!-- el-form-item就相当于label -->
            <el-row>
                <el-col :span="24">
                    <el-form-item label="学号或工号">
                        <el-input v-model="formInline.userNum" placeholder="请输入学号或者工号" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="24">
                    <el-form-item label="姓名">
                        <el-input v-model="formInline.username" placeholder="请输入姓名" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="24">
                    <el-form-item label="手机号">
                        <el-input v-model="formInline.phone" placeholder="请输入手机号" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="24">
                    <el-form-item label="状态" prop="status">
                        <el-radio-group v-model="formInline.status">
                            <el-radio label="1">正常</el-radio>
                            <el-radio label="2">停用</el-radio>
                        </el-radio-group>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="24" style="text-align: center;">
                    <el-form-item label="">
                        <el-button size="medium" type="primary" @click="submitForm()">确 定</el-button>
                        <el-button size="medium" type="primary" @click="reset()" plain>重 置</el-button>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>
    </el-drawer>
    <!--table 各种用法详见 https://element.eleme.cn/#/zh-CN/component/table -->
    <!--参数详解 stripe 基偶换色，border 带边框，:data 数据来源数组，名称对应prop，:default-sort 默认按什么排序，size 有 medium / small / mini-->
    <!--用slice(star,end)截取字符串按当前分页显示的内容;currpage:当前页数;pagesize:每页显示数量-->
    <!--slice((currentPage-1)*pagesize,currentPage*pagesize):截取第一条到最后一条-->
    <el-table ref="multipleTable" stripe :data="tableData"
              @selection-change="handleSelectionChange" :default-sort="{prop: 'date', order: 'descending'}" size="mini"
              height="calc(100vh - 94px)" highlight-current-row >
        <!--width,height可写数值，不能是百分比，也能直接按css表达式写，不要写成style="height:width:"形式，有问题-->
        <!--width 必须是数值，不能是百分比-->
        <el-table-column type="selection" width="45" align="center" fixed="left"></el-table-column>
        <!-- <el-table-column type="index" :index="indexMethod" label="序号" width="60" align="center" fixed="left">
            </el-table-column> -->
        <!--需要某项可点击排序，加上sortabel即可-->
        <el-table-column prop="userNum" label="学号或工号" width="160" align="center" fixed="left">
        </el-table-column>
        <el-table-column prop="username" label="姓名" min-width="140" align="center"></el-table-column>
        <el-table-column prop="phone" label="手机号码" width="120" align="center"></el-table-column>
        <el-table-column prop="identity" label="角色" min-width="160" align="center" :show-overflow-tooltip="true">
            <template #default="scope">
          <span>
            </el-badge> {{scope.row.identity | getIdentity}}
          </span>
            </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="140" align="center"
                         filter-placement="bottom-end">
            <template #default="scope">
          <span>
            <el-badge :type="scope.row.style">
            </el-badge> {{scope.row.status | getStatus}}
          </span>
            </template>
        </el-table-column>
        <el-table-column prop="options" label="操作" width="240" align="center" fixed="right">
            <!-- 通过 Scoped slot 可以获取到 row, column, $index 和 store（table 内部的状态管理）的数据 -->
            <template #default="scope" >
                <el-link style="margin:0 5px;font-size:12px;" :underline="false" type="primary"
                         @click=ChildAddTabs("用户管理-修改","用户管理-修改","","<%=request.getContextPath()%>/user/toUserEdit.do?userId="+scope.row.userId)>
                    <i class="el-icon-edit"></i> 编辑</el-link>
            </template>
        </el-table-column>
    </el-table>
    <div class="pagi">
        <!--分页:total="tableData.length来取共有多少条数据"-->
        <!--分页参数https://element.eleme.cn/#/zh-CN/component/pagination"-->
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                       :page-sizes="[10, 20, 50]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                       :total="total">
        </el-pagination>
    </div>
    <!--数据较多，拖到底部一键返回顶部-->
    <el-backtop target=".el-table__body-wrapper" :bottom="70" :right="150">
        <div class="backtop"><i class="fal fa-chevron-circle-up fa-lg" title="返回顶部"></i></div>
    </el-backtop>
</div>
<script>
    new Vue({
        el: '#yhgl',
        //参数初始化
        data() {
            return {
                drawer: false,
                formInline: {
                    userId: '${sessionScope.user.userId}',
                    userNum: '',
                    username: '',
                    identity: '',
                    status:'',
                    phone: ''
                },
                pageNum: 1, //当前页
                pageSize: 30, //每页显示条数
                tableData: [], //表格数据
                Deletedata: [], //删除数据存放
                multipleSelection: [], //多选的数据
                total: 0, //数据条数
            }
        },
        filters: {
          getStatus(status) {
            return status === 1 ? '正常' : status === 2 ? '停用' : '';
          },
          getIdentity(identity) {
            return identity === 1 ? '学生' : identity === 2 ? '教职工' : identity === 3 ? '管理员' : '';
          }
        },
        methods: {
            //获取json数据
            getTableData: function () {
              this.formInline.pageNum = this.pageNum;
              this.formInline.pageSize = this.pageSize;
              const params = this.formInline;
                axios({
                    url: '<%=request.getContextPath()%>/user/getUserInfo.do',
                    method: 'get',
                    params: params
                }).then((res) =>{
                  const _res = res.data.data;
                  _res.list.forEach(user => user.style = (user.status === 1 ? 'success' : 'warning'))
                  this.tableData = _res.list;
                  this.total = _res.total;
                })
            },
            // 删除按钮，取得是multipleSelection.length，为0则未选
            MultipleDel: function (snum) {
                if (snum != 0) {
                    let delStr = "";
                    // 选中的数据name都放进删除数组
                    for (let i = 0; i < snum; i++) {
                        delStr = delStr + this.multipleSelection[i].userId + ",";
                        //this.Deletedata.push(this.multipleSelection[i].name) //顶部按钮传递参数的数组multipleSelection
                    };
                    this.$confirm('要删除这' + snum + '条数据吗？删除不可恢复，请确认！', '删除确认', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        axios({
                            url: '<%=request.getContextPath()%>/user/deleteUser.do',
                            method: 'get',
                            params:{
                                ids:delStr
                            }
                        }).then(() => {
                            this.$message({
                                type: 'success',
                                message: '这' + snum + '条数据已成功删除！'
                            },setTimeout(() => {
                              this.refreshiframe('用户管理');
                            },1000));
                        })
                    }).catch(() => {
                        this.$message({
                            message: '已取消删除'
                        });
                    })
                } else {
                    this.$alert('未选中任何数据', '提示！', {
                        type: 'warning'
                    })
                }
            },
            //重置密码
            resetPassword: function (snum) {
                if (snum !== 0) {
                    let idStr = "";
                    // 选中的数据userId都拼成字符串
                    for (let i = 0; i < snum; i++) {
                        idStr = idStr + this.multipleSelection[i].userId + ",";
                    }
                    this.$confirm('是否对这' + snum + '条数据进行密码重置？重置后不可恢复，请确认！', '重置确认', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        axios({
                            url: '<%=request.getContextPath()%>/user/resetPassword.do',
                            method: 'get',
                            params:{
                              ids:idStr
                            }
                        }).then(res => {
                            this.$confirm('密码重置成功，初始密码为：' + res.data.data, '提示', {
                                confirmButtonText: '确定',
                                type: 'success'
                            })
                        })
                    })
                } else {
                  this.$message.warning('请勾选需要重置密码的账号！')
                }
            },
          refreshiframe: function(value) {
            window.parent.Refreshiframe(value)
          },
            //自定义索引
            indexMethod: function (index) {
                return (this.pageNum - 1) * this.pageSize + index + 1;
            },
            handleSizeChange: function (val) {
                this.pageSize = val;
                this.pageNum = 1
                this.getTableData();
            },
            handleCurrentChange: function (val) {
                this.pageNum = val;
              this.pageSize = 10;
                this.getTableData();
            },
            handleSelectionChange: function (val) {
                this.multipleSelection = val;
            },
            // 选中行
            setCurrent(row) {
                this.$refs.singleTable.setCurrentRow(row);
            },
            // 高级查询提交
            submitForm() {
                this.getTableData();
                this.drawer = false;
            },
            //查询
            search(){
                this.getTableData();
            },
            //重置参数
            reset() {
                Object.keys(this.formInline).forEach(key => this.formInline[key] = '');
            },
            // 子页面新增tab
            ChildAddTabs: function (activeTab, nvname, icon, url) {
                window.parent.opentab(activeTab, nvname, icon, url)
            },

        },
        mounted: function () {
            this.getTableData();
        }
    });
</script>
</body>

</html>
