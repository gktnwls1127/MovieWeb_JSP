<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }

    int filmId = Integer.parseInt(request.getParameter("filmId"));

    ConnectionMaker connectionMaker = new MySqlConnectioMaker();
    ReviewController reviewController = new ReviewController(connectionMaker);
    ReviewDTO reviewDTO = new ReviewDTO();

    reviewDTO.setFilmId(filmId);
    reviewDTO.setWriterId(logIn.getId());
    reviewDTO.setScore(Integer.parseInt(request.getParameter("score")));
    reviewDTO.setReview(request.getParameter("review"));

    reviewController.insert(reviewDTO);

    response.sendRedirect("/film/printOne.jsp?id=" + filmId);

%>
</body>
</html>
