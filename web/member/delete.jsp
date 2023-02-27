<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%
  MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  if (logIn.getId() == 1) {
%>
<script>
  alert("기본 관리자는 탈퇴하실 수 없습니다.")
  history.back();
</script>
<%

  } else {

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);

  memberController.delete(id);
  session.setAttribute("logIn", null);

  response.sendRedirect("/index.jsp");
  }
%>
</body>
</html>
