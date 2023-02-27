<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.ReviewDTO" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-21
  Time: 오전 11:01
  To change this template use File | Settings | File Templates.
--%>
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

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  ReviewController reviewController = new ReviewController(connectionMaker);

  reviewController.delete(id);

  response.sendRedirect("/film/printList.jsp");

%>
</body>
</html>
