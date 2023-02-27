<%@ page import="model.MemberDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.MemberController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);
        ArrayList<MemberDTO> promoteList = memberController.selectUpgrade();

        pageContext.setAttribute("promoteList", promoteList);
    %>
</head>
<body>
<header class="p-3 mb-5 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container">
    <div class="py-5 text-center">
        <h2>등업신청 현황</h2>
    </div>
    <c:choose>
        <c:when test="${promoteList.isEmpty()}">
            <div class="row mb-5">
                <div class="col-6">
                    <span>등업신청이 존재하지 않습니다.</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row justify-content-center">
                <div class="col-10 mb-5">
                    <div class="text-end">
                        <h6 style="color: blue"><b>등급 : 1. 일반회원 2. 평론가 3. 관리자</b></h6>
                    </div>
                    <table class="table table-stripped table-hover text-center">
                        <thead>
                        <tr>
                            <th>회원 번호</th>
                            <th>회원 아이디</th>
                            <th>회원 닉네임</th>
                            <th>현재 등급</th>
                            <th>신청한 등급</th>
                            <th>진행사항</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="member" items="${promoteList}">
                            <tr>
                                <td>
                                        ${member.id}
                                </td>
                                <td>
                                        ${member.username}
                                </td>
                                <td>
                                        ${member.nickname}
                                </td>
                                <td>
                                        ${member.level}
                                </td>
                                <td>
                                        ${member.upgradeLevel}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${member.level != member.upgradeLevel}">
                                            <button class="btn btn-outline-success"
                                                    onclick="location.href='/member/upgrade_logic.jsp?id=${member.id}'">승인
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            승인완료
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
