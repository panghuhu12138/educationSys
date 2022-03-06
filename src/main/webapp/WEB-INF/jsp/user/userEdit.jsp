<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <%@ include file="../head.jsp" %>
    <title>用户管理-修改</title>
    <style>
        .el-main {
            padding: 0 10px 10px 10px
        }

        .el-footer {
            padding: 0;
            border-bottom: 0;
        }
        .ssbm {
            display: none;
        }
    </style>
</head>
<body style="margin:0;padding:0;">
<div id="yhgl-edit" v-cloak>
    <el-container>
        <el-main style="height:calc(100vh - 60px);" class="user-def">
            <el-card class="box-card" shadow="none">
                <template #header>
                    <div class="card-header">
                        <span>编辑用户信息</span>
                    </div>
                </template>
                <el-form :model="user" label-width="140px" size="medium"
                         style="padding:0 20px 0 0">
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="学号或者工号" prop="userNum" required>
                                <el-input :readonly="isModify" v-model="user.userNum" style="width: 100%;"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="姓名" prop="username" required>
                                <el-input v-model="user.username" style="width: 100%;"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="角色" prop="identity" required>
                                <el-radio-group v-model="user.identity">
                                    <el-radio :label="1">学生</el-radio>
                                    <el-radio :label="2">教职工</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="联系电话" prop="tel">
                                <el-input v-model="user.phone" style="width: 100%;"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="24">
                            <el-form-item label="账号状态" prop="status" required>
                                <el-radio-group v-model="user.status" @change="statusChange">
                                    <el-radio :label="1">启用</el-radio>
                                    <el-radio :label="2">禁用</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </el-card>
        </el-main>
        <el-footer>
            <el-button type="primary" size="medium" @click="submit" icon="el-icon-check">
                确定</el-button>
            <el-button type="primary" plain size="medium" style="margin-left: 20px" @click="isModify ? closeTab('用户管理-修改') : closeTab('用户管理-新增');" icon="el-icon-s-order">关闭
            </el-button>
        </el-footer>
    </el-container>
</div>
<script>
    new Vue({
        el: '#yhgl-edit',
        //参数初始化
        data() {
            return{
              isModify: true,
                restaurants: [],
                user: {
                    userId: '',
                    userNum: '',
                    username:'',
                    identity: 1,
                    phone: '',
                    status: 1,
                },
                currentPage: 1, //当前页
                pagesize: 30, //每页显示条数
                tableData: [], //表格数据
                Deletedata: [], //删除数据存放
                multipleSelection: [], //多选的数据
                total: 0, //数据条数
                dialogVisible: false,
            }

        },
        methods: {
            // 模糊查询
            querySearch(queryString, cb) {
                let restaurants = this.restaurants;
                let results = queryString ? restaurants.filter(this.createFilter(queryString)) : restaurants;
                // 调用 callback 返回建议列表的数据
                cb(results);
            },
            createFilter(queryString) {
                let self=this;
                return (restaurant) => {
                    if(self.form.userType==='2'){
                        return (restaurant.orgName.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                    }else if(self.form.userType==='3'){
                        return (restaurant.unitName.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                    }

                };
            },
            handleIconClick(ev) {
                console.log(ev);
            },
            submit() {
                let message;
                if (this.isModify) {
                  message = '修改'
                } else {
                  message = '新增';
                  if (this.user.userNum.trim() === '') {
                    this.$message.warning("请输入学号或者工号！");
                    return;
                  }
                  if (this.user.username.trim() === '') {
                    this.$message.warning("请输入姓名！");
                    return;
                  }
                  if (this.user.identity === '') {
                    this.$message.warning("请选择角色！");
                    return;
                  }
                  if (this.user.status === '') {
                    this.$message.warning("请选择用户状态！");
                    return;
                  }
                }
              if(this.user.phone.trim() !== '' && !(/^1[34578]\d{9}$/.test(this.user.phone.trim()))){
                this.$message.warning("手机号码格式不正确!");
                return;
              }
              this.$confirm('确认' + message + '？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
              }).then(() => {
                axios({
                  url: '<%=request.getContextPath()%>/user/editUser.do',
                  method: 'post',
                  data: this.user
                }).then((res) => {
                  console.log(res);
                  if (res.data.reCorde === 0) {
                      this.$message({
                        type: 'success',
                        message: message + '成功！'
                      }, setTimeout(() => {
                        this.closeTab('用户管理-'+message);
                        this.refreshiframe('用户管理');
                      }, 1000));
                  } else {
                    this.$message.warning(res.data.msg)
                  }
                })
              })
            },
            closeTab: function (value) {
                window.parent.removeTab(value)
            },
            refreshiframe: function(value) {
                window.parent.Refreshiframe(value)
            },
            check() {
                this.dialogVisible = false;
            },

          //获取url后边拼接的字符串参数
          getParamsFromUrl() {
            let params = {};
            let afterUrl =  window.location.search.substring(1);//(问号以后的字符串)
            afterUrl = afterUrl.replaceAll('&&','&');
            const paramStrs = afterUrl.split('&');
            for (let param of paramStrs) {
              if (param !== '') {
                const key = param.substring(0,param.indexOf('='));
                params[key] = param.substring(param.indexOf('=') + 1);
              }
            }
            return params;
          },

            getInitData(){
              const params = this.getParamsFromUrl();
              if (params.userId == null) {
                this.isModify = false;
                return;
              }
              axios({
                    url: '<%=request.getContextPath() %>/user/getUserEditData.do',
                    method: 'get',
                    params: params
                }).then(res => {
                  const _res = res.data;
                  Object.keys(this.user).forEach(key => this.user[key] = _res.data[key]);
                })
            },

            statusChange(value){
                if(value === 2){
                    this.$confirm('账号禁用后将无法登陆平台，确定禁用？', '禁用确认', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.user.status = 2;
                    }).catch(() => {
                        this.user.status = 1;
                    })
                }
            },
        },
        mounted: function () {

        },
        created:function (){
            this.getInitData()
        }
    });
</script>
</body>

</html>
