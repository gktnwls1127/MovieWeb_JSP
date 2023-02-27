<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="model.TheaterDTO" %>
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
  TheaterController theaterController = new TheaterController(connectionMaker);
  TheaterDTO theaterDTO = theaterController.selectOne(id);
  if (logIn.getLevel() != 3){
    response.sendRedirect("/theater/printOne.jsp?id="+id);
  }

  theaterDTO.setTheaterName(request.getParameter("theaterName"));
  theaterDTO.setTheaterPlace(request.getParameter("theaterPlace"));
  theaterDTO.setTheaterNumber(request.getParameter("theaterNumber"));

  theaterController.update(theaterDTO);

  response.sendRedirect("/theater/printOne.jsp?id="+id);
%>
</body>
</html>
