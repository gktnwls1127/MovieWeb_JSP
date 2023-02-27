<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page import="model.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<%
  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  MemberController memberController = new MemberController(connectionMaker);

  String username = request.getParameter("username");
  String password = request.getParameter("password");

  MemberDTO MemberDTO = memberController.auth(username, password);

  String address;

  if (MemberDTO == null){
    address = "/index.jsp";
  } else {
    address = "/index.jsp";
    session.setAttribute("logIn", MemberDTO);
  }

  response.sendRedirect(address);
%>
</body>
</html>
