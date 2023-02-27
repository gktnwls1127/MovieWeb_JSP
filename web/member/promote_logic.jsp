<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-20
  Time: 오후 4:27
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
  MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);

  int id = Integer.parseInt(request.getParameter("id"));

  MemberDTO memberDTO = memberController.selectOne(id);

  int newLevel = Integer.parseInt(request.getParameter("level"));

  if (newLevel == 1){
    memberDTO.setUpgradeLevel(1);
  } else if (newLevel == 2) {
    memberDTO.setUpgradeLevel(2);
  } else {
    memberDTO.setUpgradeLevel(3);
  }

  response.sendRedirect("/index.jsp");
%>
</body>
</html>
