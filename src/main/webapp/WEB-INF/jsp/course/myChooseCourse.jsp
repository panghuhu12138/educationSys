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
        <el-button icon="el-icon-download" size="small" type="primary" plain>一键全选</el-button>
        <el-button icon="el-icon-document-checked" size="small" type="primary" plain>我的选课</el-button>
      </div>
      <div class="opt-search">
        <!-- 设置 inline 属性可以让表单域变为行内的表单域 el-form中的size,label-width参数可继承到全部子el-form-item-->
        <!-- label-width默认auto -->
        <el-form :inline="true" :model="formInline" size="mini" style="height: 30px;">
          <!-- el-form-item就相当于label -->
          <el-form-item label="课程号">
            <el-input v-model="formInline.courseNum" placeholder="请输入课程号" />
          </el-form-item>
          <el-form-item label="课程名">
            <el-input v-model="formInline.courseName" placeholder="请输入课程名" />
          </el-form-item>
          <el-form-item label="任课老师">
            <el-input v-model="formInline.teacherName" placeholder="请输入任课老师姓名" />
          </el-form-item>
          <el-form-item>
            <el-button-group>
              <el-button icon="el-icon-search" size="small" type="primary">查询</el-button>
              <el-button size="medium" type="primary" @click="reset()" plain>重置
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
    <el-table ref="multipleTable"  :data="tableData.slice((currentPage-1)*pagesize,currentPage*pagesize)"
      @selection-change="handleSelectionChange" :default-sort="{prop: 'date', order: 'descending'}" size="mini"
      height="calc(100vh - 98px)" highlight-current-row>
      <!--width,height可写数值，不能是百分比，也能直接按css表达式写，不要写成style="height:width:"形式，有问题-->
      <!--width 必须是数值，不能是百分比-->
      <el-table-column type="selection" width="45" align="center">
      </el-table-column>
      <el-table-column type="index" :index="indexMethod" label="序号" width="60" align="center" fixed="left">
      </el-table-column>
      <el-table-column prop="courseName" label="课程号" width="100" align="left" fixed="left"></el-table-column>
      <el-table-column prop="courseNum" label="课程号" width="100" align="left" fixed="left"></el-table-column>
      <el-table-column prop="courseCredit" label="学分" min-width="250" align="left"></el-table-column>
      <el-table-column prop="teacherName" label="任课老师姓名" min-width="180" align="center"></el-table-column>
      <el-table-column prop="teacherPhone" label="任课老师电话" min-width="180" align="center"></el-table-column>
      <el-table-column prop="status" label="选课状态" width="120" align="left">
        <template #default="scope">
          <span>
            <el-badge :type="scope.row.style">
            </el-badge>
            {{scope.row.status}}
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="options" label="操作" width="90" align="center" fixed="right">
        <!-- 通过 Scoped slot 可以获取到 row, column, $index 和 store（table 内部的状态管理）的数据 -->
        <template slot-scope="scope">
          <template>
            <el-link :underline="false" type="primary"
              @click="" style="margin:0 5px;font-size:12px;"><i
                class="el-icon-view el-icon--right"></i> 删除
            </el-link>
          </template>
        </template>
      </el-table-column>
    </el-table>
    <div class="pagi">
      <!--分页:total="tableData.length来取共有多少条数据"-->
      <!--分页参数https://element.eleme.cn/#/zh-CN/component/pagination"-->
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
        :page-sizes="[30, 60, 90]" :page-size="pagesize" layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </div>
    <!--数据较多，拖到底部一键返回顶部-->
    <el-backtop target=".el-table__body-wrapper" :bottom="70" :right="150">
      <div class="backtop"><i class="fa fa-arrow-circle-up fa-lg" title="返回顶部"></i></div>
    </el-backtop>
  </div>
  <script>
    new Vue({
      el: '#txsqsh',
      //参数初始化
      data: {
        total: '',
        currentPage: 1, //当前页
        pagesize: 30, //每页显示条数
        tableData: [], //表格数据
        Deletedata: [], //删除数据存放
        multipleSelection: [], //多选的数据
        formInline: {},
        sztxxsDialog: false,
        drawer: false, // 新高级查询
        defaultProps: {
          children: 'children',
          label: 'label'
        },
        formdia: {},
        formInline: {
          place: '',
          type: '',
          name: '',
          owner: '',
          jlhndml: '',
          bmdj: '',
          level: '',
          state: '',
          jylx: '',
          year: '',
          options: [{
            value: '南京市',
            label: '南京市',
            children: [{
              value: '玄武区',
              label: '玄武区',
              children: [{
                value: '玄第一街道',
                label: '玄第一街道',
                children: [{
                  value: '玄第一村',
                  label: '玄第一村',
                }, {
                  value: '玄第二村',
                  label: '玄第二村',
                }]
              }, {
                value: '玄第二街道',
                label: '玄第二街道',
                children: [{
                  value: '玄第三村',
                  label: '玄第三村',
                }, {
                  value: '玄第四村',
                  label: '玄第四村',
                }]
              }, {
                value: '玄第三街道',
                label: '玄第三街道'
              }, {
                value: '玄第四街道',
                label: '玄第四街道'
              }]
            }, {
              value: '鼓楼区',
              label: '鼓楼区',
              children: [{
                value: '鼓第一街道',
                label: '鼓第一街道',
                children: [{
                  value: '玄第一村',
                  label: '玄第一村',
                }, {
                  value: '玄第二村',
                  label: '玄第二村',
                }]
              }, {
                value: '鼓第二街道',
                label: '鼓第二街道',
                children: [{
                  value: '鼓第三村',
                  label: '鼓第三村',
                }, {
                  value: '鼓第四村',
                  label: '鼓第四村',
                }]
              }]
            }]
          }, {
            value: '无锡市',
            label: '无锡市',
            children: [{
              value: '锡山区',
              label: '锡山区',
              children: [{
                value: '锡第一街道',
                label: '锡第一街道',
                children: [{
                  value: '锡第一村',
                  label: '锡第一村',
                }, {
                  value: '锡第二村',
                  label: '锡第二村',
                }]
              }, {
                value: '锡第二街道',
                label: '锡第二街道',
                children: [{
                  value: '锡第三村',
                  label: '锡第三村',
                }, {
                  value: '锡第四村',
                  label: '锡第四村',
                }]
              }, {
                value: '锡第三街道',
                label: '锡第三街道',
                children: [{
                  value: '锡第五村',
                  label: '锡第五村',
                }, {
                  value: '锡第六村',
                  label: '锡第六村',
                }]
              }, {
                value: '锡第四街道',
                label: '锡第四街道'
              }, {
                value: '锡第五街道',
                label: '锡第五街道',
                children: [{
                  value: '锡第七村',
                  label: '锡第七村',
                }, {
                  value: '锡第八村',
                  label: '锡第八村',
                }]
              }]
            }, {
              value: '惠山区',
              label: '惠山区',
              children: [{
                value: '惠第一街道',
                label: '惠第一街道',
                children: [{
                  value: '惠第一村',
                  label: '惠第一村',
                }, {
                  value: '惠第二村',
                  label: '惠第二村',
                }]
              }, {
                value: '惠第二街道',
                label: '惠第二街道',
                children: [{
                  value: '惠第三村',
                  label: '惠第三村',
                }, {
                  value: '惠第四村',
                  label: '惠第四村',
                }]
              }, {
                value: '惠第三街道',
                label: '惠第三街道'
              }, {
                value: '惠第四街道',
                label: '惠第四街道'
              }, {
                value: '惠第五街道',
                label: '惠第五街道'
              }, {
                value: '惠第六街道',
                label: '惠第六街道'
              }, {
                value: '惠第七街道',
                label: '惠第七街道'
              }]
            }, {
              value: '滨湖区',
              label: '滨湖区',
              children: [{
                value: '滨第一街道',
                label: '滨第一街道',
                children: [{
                  value: '滨第一村',
                  label: '滨第一村',
                }, {
                  value: '滨第二村',
                  label: '滨第二村',
                }]
              }, {
                value: '滨第二街道',
                label: '滨第二街道',
                children: [{
                  value: '滨第三村',
                  label: '滨第三村',
                }, {
                  value: '滨第四村',
                  label: '滨第四村',
                }]
              }, {
                value: '滨第三街道',
                label: '滨第三街道',
                children: [{
                  value: '滨第五村',
                  label: '滨第五村',
                }, {
                  value: '滨第六村',
                  label: '滨第六村',
                }]
              }, {
                value: '滨第四街道',
                label: '滨第四街道',
                children: [{
                  value: '滨第七村',
                  label: '滨第七村',
                }, {
                  value: '滨第八村',
                  label: '滨第八村',
                }]
              }, {
                value: '滨第五街道',
                label: '滨第五街道',
                children: [{
                  value: '滨第九村',
                  label: '滨第九村',
                }, {
                  value: '滨第十村',
                  label: '滨第十村',
                }]
              }, {
                value: '滨第五街道',
                label: '滨第五街道',
                children: [{
                  value: '滨第十一村',
                  label: '滨第十一村',
                }, {
                  value: '滨第十二村',
                  label: '滨第十二村',
                }]
              }]
            }]
          }, {
            value: '徐州市',
            label: '徐州市',
            children: [{
              value: '鼓楼区',
              label: '鼓楼区'
            }, {
              value: '云龙区',
              label: '云龙区'
            }, {
              value: '贾汪区',
              label: '贾汪区'
            }]
          }],

        },
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
        //获取json数据
        getTableData: function () {
          var self = this
          axios({
            url: 'static/json/txsqsh.json',
            // url: 's',
            method: 'get'
          }).then(function (res) {
            var _res = res.data
            self.tableData = _res.data //获取json里data下的数据给 tableData
            self.total = _res.total //获取json数据条数 给分页总数据条数
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
          return (this.currentPage - 1) * this.pagesize + index + 1;
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