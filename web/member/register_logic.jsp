<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="controller.MemberController" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오전 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  String nickname = request.getParameter("nickname");

  MemberDTO memberDTO = new MemberDTO();
  memberDTO.setUsername(username);
  memberDTO.setPassword(password);
  memberDTO.setNickname(nickname);

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);
  boolean result = memberController.insert(memberDTO);

  if (result) {
    response.sendRedirect("/index.jsp");
  } else {
%>
  <script>
    alert("중복된 아이디로 가입하실 수 없습니다.")
    history.go(-1); // 한 페이지 뒤로 이동
  </script>
<%
  }
%>
</body>
</html>
