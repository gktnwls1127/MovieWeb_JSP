<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page import="model.FilmDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }
  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);
  MemberDTO memberDTO = memberController.selectOne(id);

  String oldPassword = request.getParameter("oldPassword");
  String newPassword = request.getParameter("newPassword");

  if (!oldPassword.equals(newPassword)){

  %>
  <script>
    alert("입력하신 비밀번호가 일치하지 않습니다.")
    history.back();
  </script>
  <%
  }
  else {
    memberDTO.setNickname(request.getParameter("nickname"));
    memberDTO.setPassword(newPassword);

    memberController.update(memberDTO);

    response.sendRedirect("/index.jsp");
  }
%>
</body>
</html>
