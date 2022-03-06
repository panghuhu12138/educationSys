<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
  <%@ include file="../head.jsp" %>
  <title>学生选课</title>
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
        <el-button icon="el-icon-back" size="small" type="primary" plain @click="ChildAddTabs('学生选课-选课','学生选课-选课','','<%=request.getContextPath()%>/chooseCourse/toChooseCourse.do')">前往选课
        </el-button>
      </div>
      <div class="opt-search">
        <!-- 设置 inline 属性可以让表单域变为行内的表单域 el-form中的size,label-width参数可继承到全部子el-form-item-->
        <!-- label-width默认auto -->
        <el-form :inline="true" :model="formInline" size="mini" style="height: 30px;">
          <!-- el-form-item就相当于label -->
          <el-form-item label="课程名">
            <el-input v-model="formInline.courseName" placeholder="请输入课程名" />
          </el-form-item>
          <el-form-item label="选课状态">
            <el-select clearable="true" v-model="formInline.status" placeholder="请选择选课状态" style="width: 100%" >
              <el-option label="待确认" :value="1"></el-option>
              <el-option label="已确认" :value="2"></el-option>
              <el-option label="退回" :value="3"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button-group>
              <el-button icon="el-icon-search" @click="search" size="small" type="primary">查询</el-button>
              </el-button>
            </el-button-group>
            <el-button-group>
              <el-button icon="el-icon-refresh" size="small" type="primary" @click="reset()" plain>重置
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
      <el-table-column prop="courseNum" label="课程号" width="120" align="left" fixed="left"></el-table-column>
      <el-table-column prop="courseName" label="课程名" min-width="120" align="left" fixed="left"></el-table-column>
      <el-table-column prop="courseCredit" label="学分" width="100" align="left"></el-table-column>
      <el-table-column prop="teacherName" label="任课老师姓名" min-width="120" align="center"></el-table-column>
      <el-table-column prop="teacherPhone" label="任课老师电话" width="120" align="center"></el-table-column>
      <el-table-column prop="status" label="选课状态" width="150" align="left">
        <template #default="scope">
          <span>
            <el-badge :type="scope.row.style">
            </el-badge>
            {{scope.row.status | getStatus}}
          </span>
          <span>
            <el-link style="margin-bottom: 4px;
    margin-left: 6px" v-if="scope.row.status === 3" :underline="false" type="primary"
                     @click="getRefuseReason(scope.row.reason)" style="margin:0 5px;font-size:12px;"><i
                    class="el-icon-discount"></i> 被退原因
            </el-link>
          </span>
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
        total: 0,
        pageNum: 1, //当前页
        pageSize: 30, //每页显示条数
        tableData: [], //表格数据
        Deletedata: [], //删除数据存放
        multipleSelection: [], //多选的数据
        formInline: {
          courseName: '',
          status: '',
        },
        sztxxsDialog: false,
        formdia: {}
      },
      filters: {
        getStatus(status) {
          return status === 1 ? '待确认' : status === 2 ? '已确认' : status === 3 ? '退回' : '';
        }
      },
      methods: {
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
        getRefuseReason(message) {
          this.$alert(message, "退回原因", {
            type: 'error'
          })
        },
        //查询
        search(){
          this.getTableData();
        },
        //获取json数据
        getTableData: function () {
          let params = this.formInline;
          params.pageNum = this.pageNum;
          params.pageSize = this.pageSize;
          console.log(params);
          axios({
            url: domaiUrl + '/chooseCourse/queryAllChooseCourseByUser.do',
            method: 'get',
            params: params
          }).then((res)=> {
            console.log(res);
            var _res = res.data
            _res.data.list.forEach(data => {
              data.style = data.status === 2 ? 'success' : data.status === 3 ? 'warning' : '';
            })
            this.tableData = _res.data.list //获取json里data下的数据给 tableData
            this.total = _res.data.total //获取json数据条数 给分页总数据条数
          })
        },

        // table内删除按钮
        handleDelete: function (index, row) {
          this.Deletedata.push(row.name); // 每行操作按钮传递参数的数组scope.row
          this.$confirm('要删除这条数据吗？删除不可恢复，请确认！', '删除确认', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(function () {
            //删除操作参考
            //this.$axios.get("/api/delPackTotalMade.do",{
            //       params:{					 
            //           Deletedata:this.Deletedata					 
            //   }					 
            //}),
            this.$message({
              type: 'success',
              message: '这条数据已成功删除！'
            });
          }).catch(function () {
            this.$message({
              message: '已取消删除'
            });
          })
        },
        //自定义索引
        indexMethod: function (index) {
          return (this.pageNum - 1) * this.pageSize + index + 1;
        },
        handleSizeChange: function (val) {
          this.pageSize = val;
          this.pageNum = 1;
          this.getTableData();
        },
        handleCurrentChange: function (val) {
          this.pageNum = val;
          this.pageSize = 10
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
          Object.keys(this.formInline).forEach(key=> this.formInline[key] = '')
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