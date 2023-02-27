<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="model.TheaterDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상영정보 등록하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null || logIn.getLevel() != 3) {
            response.sendRedirect("/index.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);
        TheaterController theaterController = new TheaterController(connectionMaker);

        ArrayList<FilmDTO> film_list = filmController.selectAll();
        ArrayList<TheaterDTO> theater_list = theaterController.selectAll();


        pageContext.setAttribute("film_list", film_list);
        pageContext.setAttribute("theater_list", theater_list);

    %>
</head>
<body>
<header class="p-3 mb-3 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>

<div class="container">
    <div class="row align-items-center text-center">
        <div class="row justify-content-center">
            <div class="m-5 text-start">
                <h2>상영정보 등록하기</h2>
            </div>
            <form action="/onBoard/write_logic.jsp" method="post">
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <select class="form-select" name="filmId" id="film">
                                <option selected>상영정보 등록하고 싶은 영화</option>
                                <c:forEach items="${film_list}" var="film" >
                                    <option value="${film.id}">${film.id}. ${film.title}</option>
                                </c:forEach>
                            </select>
                            <label for="film">영화 선택</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <select class="form-select" name="theaterId" id="theater">
                                <option selected>상영정보 등록하고 싶은 극장</option>
                                <c:forEach items="${theater_list}" var="theater" >
                                    <option value="${theater.id}">${theater.id}. ${theater.theaterName}</option>
                                </c:forEach>
                            </select>
                            <label for="theater">극장 선택</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="runningTime" type="text" name="runningTime" class="form-control">
                            <label for="runningTime">영화 상영 시간</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-10">
                        <button class="btn btn-outline-primary">작성하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
