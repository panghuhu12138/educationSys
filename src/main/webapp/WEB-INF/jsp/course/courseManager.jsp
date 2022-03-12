<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
  <%@ include file="../head.jsp" %>
  <title>选课管理</title>
  <style>
    .el-table thead.is-group th {
      background: #f9f9f9;
    }
    .el-table .el-tag {
      border: none !important;
      background: none !important;
      height: 29px;
      line-height: 28px;
    }

    .el-tag.el-tag--success {
      color: red;
    }

    .el-checkbox__label {
      font-size: 12px;
    }

    .opt-search {
      max-width: 1020px !important;
    }

    .opt-search {
      max-width: 1020px !important;
    }

    .el-badge {
      margin-top: 5px;
    }

    .el-badge sup {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      display: inline-block !important;
      padding: 0;
    }
  </style>
</head>

<body style="margin:0;padding:0 10px;">
  <div id="txsqsh" v-cloak>
    <!-- 查询条件，操作按钮 -->
    <div class="opt-area" style="height: 55px;">
      <div class="opt-button">
        <el-button icon="el-icon-check" size="small" @click="check(2)" type="primary" plain>开课</el-button>
        <el-button icon="el-icon-close" size="small" @click="check(3)" type="primary" plain>结课</el-button>
      </div>
      <div class="opt-search">
        <!-- 设置 inline 属性可以让表单域变为行内的表单域 el-form中的size,label-width参数可继承到全部子el-form-item-->
        <!-- label-width默认auto -->
        <el-form :inline="true" :model="formInline" size="mini" style="height: 30px;">
          <!-- el-form-item就相当于label -->
          <el-form-item label="课程名称">
            <el-input v-model="formInline.courseName" placeholder="请填写课程名称" style="width: 100%" >
            </el-input>
          </el-form-item>
          <el-form-item label="课程进度">
            <el-select v-model="formInline.status" placeholder="请选择课程进度" style="width: 100%" >
              <el-option label="未开课" :value="1"></el-option>
              <el-option label="已开课" :value="2"></el-option>
              <el-option label="已结课" :value="3"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button-group>
              <el-button icon="el-icon-search" @click="search()" size="small" type="primary">查询</el-button>
              <el-button size="small" type="primary" @click="reset()" plain>重置
              </el-button>
            </el-button-group>
          </el-form-item>
        </el-form>
      </div>
    </div>
    <!--table 各种用法详见 https://element.eleme.cn/#/zh-CN/component/table -->
    <!--参数详解 stripe 基偶换色，border 带边框，:data 数据来源数组，名称对应prop，:default-sort 默认按什么排序，size 有 medium / small / mini-->
    <!--用slice(star,end)截取字符串按当前分页显示的内容;currpage:当前页数;pagesize:每页显示数量-->
    <!--slice((currentPage-1)*pagesize,currentPage*pagesize):截取第一条到最后一条-->
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
      <el-table-column prop="studentNum" label="选课人数" min-width="120" align="center"></el-table-column>
      <el-table-column prop="status" label="课程状态" width="100" align="left">
        <template #default="scope">
            <span>
              <el-badge :type="scope.row.style">
              </el-badge>
              {{scope.row.status | getStatus}}
            </span>
        </template>
      </el-table-column>
      <el-table-column prop="options" label="操作" width="90" align="center" fixed="right">
        <!-- 通过 Scoped slot 可以获取到 row, column, $index 和 store（table 内部的状态管理）的数据 -->
        <template slot-scope="scope">
          <template>
            <el-link :underline="false" type="primary"
                     @click="ChildAddTabs('选课管理-详情','选课管理-详情','','<%=request.getContextPath()%>/chooseCourse/toCourseCheck.do?courseId='+scope.row.courseId+'&&status='+scope.row.status)" style="margin:0 5px;font-size:12px;"><i
                    class="el-icon-view el-icon--right"></i> 详情
            </el-link>
          </template>
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
      <div class="backtop"><i class="fa fa-arrow-circle-up fa-lg" title="返回顶部"></i></div>
    </el-backtop>
  </div>
  <script>
    const domaiUrl = '<%=request.getContextPath()%>';
    new Vue({
      el: '#txsqsh',
      //参数初始化
      data: {
        total: '',
        pageNum: 1, //当前页
        pageSize: 10, //每页显示条数
        tableData: [], //表格数据
        Deletedata: [], //删除数据存放
        multipleSelection: [], //多选的数据
        formdia: {},
        formInline: {
          courseName: '',
          status: ''
        },
      },
      filters: {
        getStatus(status) {
          return status === 1 ? '未开课' : status === 2 ? '已开课' : status === 3 ? '已结课' : '';
        }
      },
      methods: {
        search() {
          this.getTableData();
        },
        filterTag1(value, row) {
          return row.type === value;
        },
        filterTag2(value, row) {
          return row.zt === value;
        },
        filterTag3(value, row) {
          return row.dkcpType === value;
        },
        filterTag4(value, row) {
          return row.fdyh === value;
        },
        // 获取级联选择器的值
        handleChange(value) {
          console.log(value);
        },
        submitUpload: function () {
          this.$refs.upload.submit();
        },
        handleRemove: function (file, fileList) {
          console.log(file, fileList);
        },
        handlePreview: function (file) {
          console.log(file);
        },
        //获取json数据
        getTableData: function () {
          let params = this.formInline;
          params.pageNum = this.pageNum;
          params.pageSize = this.pageSize;
          axios({
            url: domaiUrl + '/chooseCourse/queryAllCourse2.do',
            method: 'get',
            params: params
          }).then((res) =>{
            var _res = res.data
            _res.data.list.forEach(data => {
              data.style = data.status === 2 ? 'success' : data.status === 3 ? 'warning' : '';
            })
            this.tableData = _res.data.list //获取json里data下的数据给 tableData
            this.total = _res.data.total //获取json数据条数 给分页总数据条数
          })
        },

        check(status) {
          if (this.multipleSelection.length === 0) {
            this.$message.warning('请勾选需要操作的数据！');
            return;
          }
          let message;
          if (status === 2) {
            message = '开课';
          } else if (status === 3) {
            message = '结课';
          }
          this.$confirm('是否对这' + this.multipleSelection.length + '门课' + message, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            let idStr = '';
            for (let i = 0; i < this.multipleSelection.length; i++) {
              idStr = idStr + this.multipleSelection[i].courseId + ",";
            }
            axios({
              url: domaiUrl + '/chooseCourse/updateCourse.do',
              method: 'get',
              params: {
                ids: idStr,
                status: status,
              }
            }).then((res) =>{
              this.refreshiframe('选课管理');
              this.$message.success(message + '成功！');
            })
          })
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
          this.getTableData();
        },
        handleCurrentChange: function (val) {
          this.pageNum = val
          this.getTableData();
        },
        handleSelectionChange: function (val) {
          this.multipleSelection = val;
        },
        // 高级查询提交
        submitForm: function () {
          this.drawer = false;
        },
        // 高级查询重置
        reset() {
          // 都赋值为空字符
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