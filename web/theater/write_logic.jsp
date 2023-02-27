<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="model.TheaterDTO" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오후 3:36
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
  TheaterController theaterController = new TheaterController(connectionMaker);
  TheaterDTO theaterDTO = new TheaterDTO();

  theaterDTO.setTheaterName(request.getParameter("theaterName"));
  theaterDTO.setTheaterPlace(request.getParameter("theaterPlace"));
  theaterDTO.setTheaterNumber(request.getParameter("theaterNumber"));

  theaterController.insert(theaterDTO);

  response.sendRedirect("/theater/printList.jsp");

%>
</body>
</html>
