<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.OnBoardController" %>
<%@ page import="model.OnBoardDTO" %>
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
  OnBoardController onBoardController = new OnBoardController(connectionMaker);
  OnBoardDTO onBoardDTO = new OnBoardDTO();

  onBoardDTO.setFilmId(Integer.parseInt(request.getParameter("filmId")));
  onBoardDTO.setTheaterId(Integer.parseInt(request.getParameter("theaterId")));
  onBoardDTO.setRunningTime(request.getParameter("runningTime"));

  onBoardController.insert(onBoardDTO);

  response.sendRedirect("/onBoard/printList.jsp");

%>
</body>
</html>
