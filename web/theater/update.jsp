<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="model.TheaterDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>

    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);

        TheaterDTO theaterDTO = theaterController.selectOne(id);
        if (logIn.getLevel() != 3) {
            response.sendRedirect("/theater/printOne.jsp?id=" + id);
        }
    %>
    <title><%=theaterDTO.getTheaterName()%>영화관 수정하기</title>
</head>
<body>

<header class="p-3 mb-3 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
</header>
<div class="container">
    <div class="row align-items-center text-center">
        <div class="row justify-content-center">
            <div class="m-5 text-start">
                <h2>극장 등록하기</h2>
            </div>
            <form action="/theater/update_logic.jsp?id=<%=id%>" method="post">
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterId" class="form-control" value="<%=theaterDTO.getId()%>" disabled>
                            <label for="theaterId">극장번호</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterName" type="text" name="theaterName" class="form-control" value="<%=theaterDTO.getTheaterName()%>">
                            <label for="theaterName">극장이름</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterPlace" type="text" name="theaterPlace" class="form-control" value="<%=theaterDTO.getTheaterPlace()%>">
                            <label for="theaterPlace">극장 위치</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="theaterNumber" type="text" name="theaterNumber" class="form-control" value="<%=theaterDTO.getTheaterNumber()%>">
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
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row align-items-center vh-100 justify-content-center">
        <div class="col-10">
            <form action="/theater/update_logic.jsp?id=<%=id%>" method="post">
                <table class="table table-striped table-dark">
                    <tr>
                        <th class="col-2">극장 번호</th>
                        <td class="col-10"><%=theaterDTO.getId()%>
                        </td>
                    </tr>
                    <tr>
                        <th>극장 이름</th>
                        <td><input type="text" name="theaterName" value="<%=theaterDTO.getTheaterName()%>"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <th>극장 위치</th>
                        <td><input type="text" name="theaterPlace" value="<%=theaterDTO.getTheaterPlace()%>"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <th>극장 번호</th>
                        <td>
                            <input type="text" name="theaterNumber" value="<%=theaterDTO.getTheaterNumber()%>"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            <button class="btn btn-outline-success">수정하기</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
</body>
</html>
