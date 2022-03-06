<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
  <title>登录</title>
  <link href="<%=request.getContextPath()%>/lib/theme/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/lib/theme/materialdesignicons.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/lib/theme/style.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/theme/font-awesome.min.css">
  <style>
    .login-form .has-feedback {
      position: relative;
    }

    .login-form .has-feedback .form-control {
      padding-left: 36px;
    }

    .login-form .has-feedback .mdi {
      position: absolute;
      top: 0;
      left: 0;
      right: auto;
      width: 36px;
      height: 36px;
      line-height: 36px;
      z-index: 4;
      color: #dcdcdc;
      display: block;
      text-align: center;
      pointer-events: none;
    }

    .login-form .has-feedback.row .mdi {
      left: 15px;
    }

    .card-shadowed,
    .card-hover-shadow:hover {
      box-shadow: 0 0 20px 2px rgba(19, 35, 113, 0.9);
      border-radius: 8px;
    }

    .titlog {
      position: absolute;
      top: 50%;
      left: 50%;
      margin-top: -300px;
      margin-left: -480px;
      font-size: 40px;
      color: #fff;
      font-weight: bold;
      letter-spacing: 4px;
      width: 1000px;
      text-align: center;
      text-shadow: 0 5px 5px #0a1a59;
    }

    .card {
      background: rgba(254, 254, 254, .9);
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .forget {
      cursor: pointer;
    }

    #forgetlogin {
      display: none;
      position: relative;
    }

    i.backlogin {
      cursor: pointer;
      position: absolute;
      right: 14px;
      top: 14px;
    }

    /*.btn-block {*/
    /*  display: block;*/
    /*  width: 105%;*/
    /*}*/

    /*.form-control {*/
    /*  display: block;*/
    /*  width: 105%;*/
    /*  height: calc(1.5em + .75rem + 2px);*/
    /*  padding: .375rem .75rem;*/
    /*  font-size: 1rem;*/
    /*  font-weight: 400;*/
    /*  line-height: 1.5;*/
    /*  color: #495057;*/
    /*  background-color: #fff;*/
    /*  background-clip: padding-box;*/
    /*  border: 1px solid #ced4da;*/
    /*  border-radius: .25rem;*/
    /*  transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;*/
    /*}*/
  </style>
</head>

<body class="center-vh" style="background-color: #fff;">
  <div class="titlog">教务管理系统</div>
  <div class="card card-shadowed p-5 w-420 mb-0 mr-2 ml-2" id="login">
    <form action="#!" method="post" class="login-form">
      <div class="form-group has-feedback">
        <span class="mdi mdi-account" aria-hidden="true"></span>
        <input type="text" class="form-control" id="userNum" value="${userNum}" placeholder="学号"  style="width: 340px">
      </div>
      <div class="form-group has-feedback" id="usernameDiv" style="display: none">
        <span class="mdi mdi-account" aria-hidden="true"></span>
        <input type="text" class="form-control" id="username" placeholder="姓名"  style="width: 340px">
      </div>
      <div class="form-group has-feedback">
        <span class="mdi mdi-lock" aria-hidden="true"></span>
        <input type="password" class="form-control" id="password" style="width: 340px" placeholder="密码长度为8-15且包含字母、数字、特殊字符">
      </div>
      <div id="captchaDiv" class="form-group has-feedback row">
        <div class="col-6" style="padding-right: 0">
          <span class="mdi mdi-check-all form-control-feedback" aria-hidden="true"></span>
          <input type="text" id="code" name="captcha" class="form-control" onkeyup="checkCaptcha()" placeholder="验证码">
          <input type="hidden" id="isTrue" value="">
        </div>
        <div class="col-1" style="padding: 0;display: flex; align-items: flex-end; justify-content: center">
          <img id="checkImg" onerror=this.style.display="none">
        </div>
        <div class="col-5 text-right">
          <img src="<%=request.getContextPath()%>/login/getCodeImg.do" class="pull-right" id="captcha" style="cursor: pointer;width: 100%;height: 36px" title="点击刷新" alt="captcha">
        </div>
      </div>
    </form>
    <div class="form-group">
      <button id="loginBtn" class="btn btn-block btn-primary" onclick="loginIn()"  style="width: 340px">登录</button>
      <button id="registerBtn" class="btn btn-block btn-primary" onclick="register()"  style="width: 340px; display: none">注册</button>
    </div>
    <p class="text-left text-muted mb-0 forget" id="toRegisterBtn" onclick="toRegister(this)">立即注册</p>
  </div>

  <script type="text/javascript" src="<%=request.getContextPath()%>/lib/jquery-1.9.1.min.js"></script>
  <script>
    //window.location.href = "http://218.94.87.6:81/";
    function getBrowserType(){
      var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
      var browser='unknown';
      if (userAgent.indexOf("IE")!=-1) {
        browser="IE";
      }else if(userAgent.indexOf('Trident')!=-1){
        browser='IE 11';
      }
      return browser;
    }

    // 返回登陆
    $('.backlogin').click(function () {
      $('#login').show();
      $('#forgetlogin').hide();
    })
    //刷新验证码
    $(document).ready(function() {
      if (getBrowserType() === 'IE 11' || getBrowserType() === 'IE') {
        $("#content").html("<p style='margin: 0;'>推荐浏览器（谷歌浏览器）下载网址：<a style='color: #1e6eb9;' target='view_window' href='https://www.google.cn/chrome/'>https://www.google.cn/chrome/</a></p>")
        $('#login').hide();
        $("#close").remove();
        $('#forgetlogin').show();
        alert('为了更好的用户体验，请使用其它浏览器。');
        return false;
      }
      $("#captcha").click(function () {
        this.src = this.src + '?d=' + Math.random();
        clear();
      })
    });

    function clear() {
      $("#code").val('');
      $("#checkImg").hide();
    }

    //校验验证码
    function checkCaptcha() {
      $("#checkImg").hide();
      if ($("#code").val().length < 4) {
        return;
      }
      $("#checkImg").css('width',"20");
      $("#checkImg").css('height',"20");
      if ($("#code").val().length === 4) {
        $.ajax({
          type: "post",
          url: "<%=request.getContextPath()%>/login/checkCaptcha.do",
          dataType: "json",
          data: {
            code: $("#code").val()
          },
          success: function (resp) {
            console.log(resp);
            if (resp.reCorde === 0) {
              $("#checkImg").attr('src',"<%=request.getContextPath()%>/images/icon_true.png");
              $("#isTrue").val(1);
            } else {
              $("#checkImg").attr('src',"<%=request.getContextPath()%>/images/icon_false.png");
              $("#isTrue").val(0);
            }
          }
        })
      } else if ($("#code").val().length > 4) {
        $("#checkImg").attr('src',"<%=request.getContextPath()%>/images/icon_false.png");
      }
      $("#checkImg").show();
    }
    //登陆
    function loginIn() {
      const userNum = $("#userNum").val().trim();
      const password = $("#password").val().trim();
      const code = $("#code").val().trim();
      if (userNum.length === 0) {
        alert("账号不能为空！");
        return;
      }
      if (password.length === 0) {
        alert("密码不能为空！");
        return;
      }
      if ($("#isTrue").val() !== '' && code.length === 0) {
        alert("验证码不能为空！")
        return;
      }
      if ($("#isTrue").val() === '0') {
        alert("验证码错误！");
        return;
      }
      $.ajax({
        type: "post",
        url: "<%=request.getContextPath()%>/login/loginIn.do",
        dataType: "json",
        data: {
          userNum : userNum,
          password : password,
          code : code
        },
        success: function (resp) {
          if (resp.reCorde === 0) {
            window.location.replace("<%=request.getContextPath()%>/login/toMainPage.do");
          } else {
            $("#isTrue").val(0);
            alert(resp.msg);
            clear();
            $("#captcha").click();
          }
        }
      })
    }

    //加载注册dom
    function toRegister(e) {
      $(e).hide();
      $("#loginBtn").hide();
      $("#registerBtn").show();
      $("#captchaDiv").hide();
      $("#usernameDiv").show();
    }

    function toLogin() {
      $("#toRegisterBtn").show();
      $("#loginBtn").show();
      $("#registerBtn").hide();
      $("#captchaDiv").show();
      $("#usernameDiv").hide();
    }

    //注册
    function register() {
      const userNum = $("#userNum").val().trim();
      const password = $("#password").val().trim();
      const username = $("#username").val().trim();
      if (userNum.length === 0) {
        alert("账号不能为空！");
        return;
      }
      if (password.length === 0) {
        alert("密码不能为空！");
        return;
      }
      if (username.length === 0) {
        alert("姓名不能为空！");
        return;
      }
      $.ajax({
        type: "post",
        url: "<%=request.getContextPath()%>/login/register.do",
        dataType: "json",
        data: {
          userNum : userNum,
          password : password,
          username: username
        },
        success: function (resp) {
          console.log(resp);
          if (resp.reCorde === 0) {
            alert('注册成功！')
            toLogin();
          } else {
            alert(resp.msg)
          }
        }
      })
    }

    //回车登录
    document.onkeydown = function (event) {
      var e = event || window.event;
      if (e && e.keyCode == 13) { //回车键的键值为13
        loginIn(); //调用登录按钮的登录事件
      }
    };
  </script>
</body>

</html>