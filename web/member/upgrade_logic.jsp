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
  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);
  MemberDTO memberDTO = memberController.selectOne(id);

  ArrayList<MemberDTO> promoteList = memberController.selectUpgrade();

  if (promoteList.contains(memberDTO)) {
    memberDTO.setLevel(memberDTO.getUpgradeLevel());
  }

  memberController.rankUp(memberDTO);
  System.out.println(memberDTO);


  response.sendRedirect("/index.jsp");
%>
</body>
</html>
