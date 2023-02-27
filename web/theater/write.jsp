<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.TheaterDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>극장 등록하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);

        ArrayList<TheaterDTO> list = theaterController.selectAll();

        pageContext.setAttribute("list", list);
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
                <h2>극장 등록하기</h2>
            </div>
            <form action="/theater/write_logic.jsp" method="post">
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id= "theaterName" type="text" name="theaterName" class="form-control">
                            <label for="theaterName">극장이름</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterPlace" type="text" name="theaterPlace" class="form-control">
                            <label for="theaterPlace">극장 위치</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterNumber" type="text" name="theaterNumber" class="form-control">
                            <label for="theaterNumber">극장 전화번호</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-10">
                        <button class="btn btn-outline-primary">작성하기</button>
                    </div>
                </div>
            </form>
            <hr>
            <div class="m-5 text-start">
                <h2 class="mb-3">등록된 극장 목록</h2>
                <c:forEach items="${list}" var="list">
                    <h5>${list.id}. ${list.theaterName}</h5>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html>
