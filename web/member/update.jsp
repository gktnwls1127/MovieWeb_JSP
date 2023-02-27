<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page import="connector.MySqlConnectioMaker" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-15
  Time: 오전 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원정보 수정</title>
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
        MemberController memberController = new MemberController(connectionMaker);

        MemberDTO memberDTO = memberController.selectOne(id);

        pageContext.setAttribute("memberDTO", memberDTO);
    %>
</head>
<body>
<header class="p-3 mb-3 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container-fluid">
    <div class="py-5 text-center">
        <h2>회원 정보 수정</h2>
    </div>
    <div class="container">
        <h4 class="mb-3">${memberDTO.username}님</h4>
        <hr class="my-4">
        <form class="needs-validation" action="/member/update_logic.jsp?id=<%=id%>" method="post">
            <div class="row g-3">
                <div class="col-12">
                    <h6 class="form-label">Member Number : <b>${memberDTO.id}</b></h6>
                </div>
                <div class="col-12">
                    <h6 class="form-label">Username : <b>${memberDTO.username}</b></h6>
                </div>

                <hr class="my-4">

                <div class="col-12">
                    <label class="form-label">Nickname</label>
                    <input type="text" class="form-control" name="nickname" value="${memberDTO.nickname}">
                </div>

                <div class="col-12">
                    <label class="form-label">NewPassword</label>
                    <input type="password" class="form-control" name="newPassword">
                </div>

                <div class="col-12">
                    <label class="form-label">OldPassword</label>
                    <input type="password" class="form-control" name="oldPassword">
                </div>


                <hr class="my-4">

                <button class="w-100 btn btn-success btn-lg col-5" type="submit">회원정보 수정</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
