<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/theme-chalk/index.css">
    <!-- 引入自定义样式 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/theme/main.css">
    <!-- 引入Font Awesome字体图标样式 http://www.fontawesome.com.cn/v5/-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/theme/FA5Pro/css/all.min.css">
    <!-- 引入vue -->
    <script src="<%=request.getContextPath()%>/lib/vue.min.js"></script>
    <!-- 引入ajax -->
    <script src="<%=request.getContextPath()%>/lib/axios.min.js"></script>
    <!-- 引入组件库 -->
    <script src="<%=request.getContextPath()%>/lib/index.js"></script>
    <![if IE]>
    <script src="<%=request.getContextPath()%>/lib/polyfill.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/compatible.js"></script>
    <![endif]>
    <title>无标题文档</title>
    <style>
        .zhhnsy-img{
            height: 100vh;
            width: 100%;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .zhhnsy-img img{
            text-align: center;
        }
    </style>
</head>


<body style="margin:0;padding:0 10px;overflow-x:hidden;">

<div id="app" v-cloak>
    <div class="zhhnsy-img">
        <img src="<%=request.getContextPath()%>/images/index5.png" alt="">
    </div>
</div>
<script>
    new Vue({
        el: '#app',
        //参数初始化
        data: {
            tableData: [{
                time: '2021-05-02',
                name: '溧水区王乡村王大陆家庭农场',
            }, {
                time: '2021-05-04',
                name: '溧水区王乡村王大陆家庭农场',
            }, {
                time: '2021-05-01',
                name: '溧水区王乡村王大陆家庭农场',
            }, {
                time: '2021-05-03',
                name: '溧水区王乡村王大陆家庭农场',
            }, {
                time: '2021-05-03',
                name: '溧水区王乡村王大陆家庭农场',
            }, {
                time: '2021-05-03',
                name: '溧水区王乡村王大陆家庭农场',
            }]
        }
    });
</script>
</body>

</html>