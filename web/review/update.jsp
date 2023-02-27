<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="model.ReviewDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/film/printOne.css">
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        ReviewController reviewController = new ReviewController(connectionMaker);

        ReviewDTO reviewDTO = reviewController.selectOne(id);

        pageContext.setAttribute("logIn", logIn);

    %>
    <title>평점 수정</title>
</head>
<body>
<div class="container">
    <div class="row align-items-center text-center justify-content-center">
        <div class="m-5 text-center">
            <h2>평점 수정하기</h2>
        </div>
        <form action="/review/update_logic.jsp?id=<%=reviewDTO.getId()%>" method="post">
            <div class="row justify-content-center mb-3">
                <div class="star-rating space-x-4 mx-auto mb-5" id="score">
                    <input type="radio" id="5-stars" name="score" value="5"/>
                    <label for="5-stars" class="star pr-4">★</label>
                    <input type="radio" id="4-stars" name="score" value="4"/>
                    <label for="4-stars" class="star">★</label>
                    <input type="radio" id="3-stars" name="score" value="3"/>
                    <label for="3-stars" class="star">★</label>
                    <input type="radio" id="2-stars" name="score" value="2"/>
                    <label for="2-stars" class="star">★</label>
                    <input type="radio" id="1-star" name="score" value="1"/>
                    <label for="1-star" class="star">★</label>
                </div>
            </div>
            <c:if test="${logIn.level eq 2}">
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="review" type="text" name="review" class="form-control">
                            <label for="review">평론</label>
                        </div>
                    </div>
                </div>
            </c:if>
            <div class="row justify-content-center">
                <div class="col-10">
                    <button class="btn btn-outline-primary">수정하기</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
