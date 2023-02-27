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

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  OnBoardController onBoardController = new OnBoardController(connectionMaker);
  OnBoardDTO onBoardDTO = onBoardController.selectOne(id);

  onBoardDTO.setFilmId(Integer.parseInt(request.getParameter("filmId")));
  onBoardDTO.setTheaterId(Integer.parseInt(request.getParameter("theaterId")));
  onBoardDTO.setRunningTime(request.getParameter("runningTime"));

  onBoardController.update(onBoardDTO);

  response.sendRedirect("/onBoard/printOne.jsp?filmId="+ onBoardDTO.getFilmId());

%>
</body>
</html>
