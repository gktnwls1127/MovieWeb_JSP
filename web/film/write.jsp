<%@ page import="model.MemberDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 등록하기</title>
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
                <h2>영화 등록하기</h2>
            </div>
            <form action="/film/write_logic.jsp" method="post" enctype="multipart/form-data">
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="title" type="text" name="title" class="form-control">
                            <label for="title">영화제목</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <input id="rating" type="text" name="rating" class="form-control">
                            <label for="rating">영화등급</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-10">
                        <div class="form-floating">
                            <textarea id="summary" type="text" name="summary" class="form-control"
                                      style="height: 100px"></textarea>
                            <label for="summary">영화 줄거리</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-4">
                    <div class="col-10">
                        <input type="file" name="images"/>
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
