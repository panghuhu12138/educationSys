<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<script type="text/javascript">
    var domainurl='<%=request.getContextPath()%>';
    window.top.location.href = domainurl+"/login/loginpage.do";
</script>
</body>
</html>
