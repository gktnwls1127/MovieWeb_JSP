<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
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
    TheaterController theaterController = new TheaterController(connectionMaker);

    theaterController.delete(id);

    response.sendRedirect("/theater/printList.jsp");
%>
</body>
</html>
