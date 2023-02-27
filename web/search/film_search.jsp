<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        request.setCharacterEncoding("UTF-8");
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/assets/logInError.jsp");
        }

        String title = request.getParameter("title");

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);

        ArrayList<FilmDTO> list = filmController.search(title);

        pageContext.setAttribute("list", list);
    %>
    <title>
        검색하신 영화
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/search/film_search.css">
</head>
<body>
<header class="p-3 mb-5 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container">
    <div class="row mb-2">
        <c:if test="${list.isEmpty()}">
            <span>검색하신 "<%=title%>" 포함하는 제목의 영화가 없습니다.</span>
        </c:if>
        <span class="mb-5">검색하신 "<%=title%>" 포함하는 제목의 영화</span>
        <c:forEach items="${list}" var="film">
            <div class="col-md-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div class="col p-4 d-flex flex-column position-static">
                        <h3 class="mb-2 film-title">${film.title}</h3>
                        <div class="rating-color mb-1 text-end"><b>${film.rating}</b>
                        </div>
                        <p class="card-text mb-auto film-summary">${film.summary}</p>
                        <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link">더보기</a>
                    </div>
                    <div class="col-auto d-none d-lg-block">
                        <img class="bd-placeholder-img" width="200" height="250"
                             src="${film.images}"/>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>




















