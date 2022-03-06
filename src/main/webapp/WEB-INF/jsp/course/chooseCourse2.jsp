<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <%@ include file="../head.jsp" %>
    <title>学生选课-选课</title>
    <style>
        .el-table th {
            font-size: 12px;
            padding: 5px 0;
        }

        .el-main {
            padding: 0 10px 10px 10px
        }

        .el-footer {
            padding: 0;
            border-bottom: 0;
        }

        .el-form-item__label {
            width: 200px !important;
        }

        .el-form-item__content {
            margin-left: 200px !important;
        }

        .opt-search {
            margin-top: 0px;
            margin-bottom: 10px;
        }

        .opt-search .el-form-item__label {
            width: 100px !important;
        }

        .opt-search .el-form-item__content {
            margin-left: 0px !important;
        }

        .user-def .el-form {
            padding-top: 0px;
        }
    </style>
</head>

<body style="margin:0;padding:0;">
    <div id="txdxgl-add" v-cloak>
        <el-container>
            <el-main style="height:calc(100vh - 60px);" class="user-def">
                <!-- 基本信息 -->
                    <div class="opt-search" style="margin-top: 14px;">
                        <!-- 设置 inline 属性可以让表单域变为行内的表单域 el-form中的size,label-width参数可继承到全部子el-form-item-->
                        <!-- label-width默认auto -->
                        <el-form :inline="true" :model="formInline" size="mini" style="height: 30px;">
                            <!-- el-form-item就相当于label -->
                            <el-form-item label="课程名">
                                <el-col :span="12">
                                    <el-input v-model="formInline.courseName" placeholder="请输入课程名" />
                                </el-col>
                            </el-form-item>
                            <el-form-item>
                                <el-button-group>
                                    <el-button icon="el-icon-search" size="small" type="primary" >查询</el-button>
                                </el-button-group>
                                <el-button-group>
                                    <el-button icon="el-icon-refresh" size="small" type="primary" @click="reset()" plain>重置
                                    </el-button>
                                </el-button-group>
                            </el-form-item>
                        </el-form>
                    </div>
                <el-table ref="multipleTable"  :data="tableData"
                          @selection-change="handleSelectionChange" :default-sort="{prop: 'date', order: 'descending'}" size="mini"
                          height="calc(100vh - 98px)" highlight-current-row>
                    <!--width,height可写数值，不能是百分比，也能直接按css表达式写，不要写成style="height:width:"形式，有问题-->
                    <!--width 必须是数值，不能是百分比-->
                    <el-table-column type="selection" width="45" align="center">
                    </el-table-column>
                    <el-table-column type="index" :index="indexMethod" label="序号" width="60" align="center" fixed="left">
                    </el-table-column>
                    <el-table-column prop="courseName" label="课程号" min-width="120" align="left" fixed="left"></el-table-column>
                    <el-table-column prop="courseNum" label="课程名" min-width="120" align="left" fixed="left"></el-table-column>
                    <el-table-column prop="courseCredit" label="学分" width="100" align="left"></el-table-column>
                    <el-table-column prop="teacherName" label="任课老师姓名" min-width="120" align="center"></el-table-column>
                    <el-table-column prop="teacherPhone" label="任课老师电话" min-width="120" align="center"></el-table-column>
                    <el-table-column prop="status" label="课程状态" width="100" align="left">
                        <template #default="scope">
                          <span>
                            <el-badge :type="scope.row.style">
                            </el-badge>
                            {{scope.row.status}}
                          </span>
                        </template>
                    </el-table-column>
                </el-table>
            </el-main>
            <el-footer>
                <el-button type="primary" size="medium" @click="submit,closeTab('金融机构管理-新增')" icon="el-icon-check">
                    保存</el-button>
                <el-button type="primary" plain size="medium" @click="cancel,closeTab('金融机构管理-新增')"
                    icon="el-icon-close">
                    取消</el-button>
            </el-footer>
        </el-container>
    </div>
    <script>
        new Vue({
            el: '#txdxgl-add',
            //参数初始化
            data: {
              formInline:{},
                tableData: [],
                tableData2: [],
                filedialog: false,
                form: {
                    sjhdtxze: 323.4,
                    syktktxzj: 32,
                },
                urlList: [
                    './images/1.jpg',
                ],
                fileList1: [
                    './images/1.jpg',
                    './images/2.jpg'
                ],
            },
            methods: {
              //自定义索引
              indexMethod: function (index) {
                return (this.currentPage - 1) * this.pagesize + index + 1;
              },
                filterTag1: function (value, row) {
                    return row.ztlx === value;
                },
                filterTag(value, row) {
                    return row.szjd === value;
                },
                submit() {
                    console.log('submit!')
                },
                // 点击link预览图片
                previewPic: function () {
                    this.$refs.previewImg.showViewer = true
                },
                // 获取级联选择器的值
                handleChange(value) {
                    console.log(value);
                },
                handleSizeChange: function (val) {
                    this.pagesize = val;
                },
                handleCurrentChange: function (val) {
                    this.currentPage = val
                },
                handleSelectionChange: function (val) {
                    this.multipleSelection = val;
                },
                // 子页面关闭tab
                closeTab: function (value) {
                    window.parent.removeTab(value)
                },
                cancel() {
                    console.log('cancel!')
                },
                // 子页面新增tab
                ChildAddTabs: function (activeTab, nvname, icon, url) {
                    window.parent.opentab(activeTab, nvname, icon, url)
                },
                // 附件管理
                filemanage: function () {
                    this.filedialog = true;
                },
                handleSizeChange: function (val) {
                    this.pagesize = val;
                },

                handleCurrentChange(val) {
                    this.currentRow = val;
                },
                //获取json数据
                getTableData: function () {
                    var self = this
                    axios({
                        url: 'static/json/txdxgl-add.json',
                        method: 'get'
                    }).then(function (res) {
                        var _res = res.data
                        self.tableData = _res.data //获取json里data下的数据给 tableData
                        self.total = _res.total //获取json数据条数 给分页总数据条数
                    })
                },
            },
            mounted: function () {
                this.getTableData();
            }
        });
    </script>
</body>

</html>