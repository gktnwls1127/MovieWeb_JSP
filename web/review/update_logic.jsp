<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="model.ReviewDTO" %>
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
    ReviewController reviewController = new ReviewController(connectionMaker);
    ReviewDTO reviewDTO = reviewController.selectOne(id);

    reviewDTO.setScore(Integer.parseInt(request.getParameter("score")));
    reviewDTO.setReview(request.getParameter("review"));

    reviewController.update(reviewDTO);
%>
<script>
    opener.parent.location.reload();
    window.close();
</script>

</body>
</html>
