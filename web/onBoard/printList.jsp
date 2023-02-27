<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.OnBoardController" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.OnBoardDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.FilmController" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상영중인 영화 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/onBoard/printList.css">
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        if (logIn == null) {
            response.sendRedirect("/assets/logInError.jsp");
        }

        int pageNo;
        try {
            String pageStr = request.getParameter("pageNo");
            pageNo = Integer.parseInt(pageStr);
        } catch (Exception e) {
            pageNo = 1;
        }

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        OnBoardController onBoardController = new OnBoardController(connectionMaker);
        FilmController filmController = new FilmController(connectionMaker);

        ArrayList<OnBoardDTO> list = onBoardController.selectAll(pageNo);

        int totalPage = onBoardController.countTotalPage();

        int startNum;
        int endNum;

        if (pageNo < 3) {
            startNum = 1;
            endNum = 5;
        } else if (pageNo > totalPage - 3) {
            startNum = totalPage - 4;
            endNum = totalPage;
        } else if (totalPage <= 5) {
            startNum = 1;
            endNum = totalPage;
        } else {
            startNum = pageNo - 2;
            endNum = pageNo + 2;
        }

        pageContext.setAttribute("list", list); //page 단위의 변수를 저장
        pageContext.setAttribute("filmController", filmController);
        pageContext.setAttribute("currentPage", pageNo);
        pageContext.setAttribute("startPage", startNum);
        pageContext.setAttribute("endPage", endNum);
        pageContext.setAttribute("totalPage", totalPage);
    %>
</head>
<body>
<header class="p-3 mb-5 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<c:choose>
<c:when test="${list.isEmpty()}">
    <div class="row">
        <div class="col-6">
            <span>아직 상영중인 영화가 존재하지 않습니다.</span>
        </div>
    </div>
</c:when>
<c:otherwise>
<div class="container">
    <div class="align-items-center justify-center-center">
        <h5 class="mb-5 text-center">현재 상영중인 영화</h5>
        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
            <c:forEach var="onboard" items="${list}">
                <div class="col">
                    <div class="card"
                         onclick="location.href='/onBoard/printOne.jsp?filmId=${onboard.filmId}'">
                        <img src="${filmController.selectOne(onboard.filmId).images}"
                             class="img-thumbnail rounded-start img-object"
                             alt="${filmController.selectOne(onboard.filmId).title}">
                        <div class="card-body">
                            <h5 class="card-title">${filmController.selectOne(onboard.filmId).title}</h5>
                            <p class="card-text"><small
                                    class="text-muted">${filmController.selectOne(onboard.filmId).rating}</small></p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        </c:otherwise>
        </c:choose>
        <c:if test="${logIn.level == 3}">
            <div class="row mb-5">
                <div class="col-12 text-end">
                    <span class="btn btn-outline-info" onclick="location.href='/onBoard/write.jsp'">상영 정보 추가하기</span>
                </div>
            </div>
        </c:if>
        <tr>
            <td colspan="5">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a href="/onBoard/printList.jsp?pageNo=${1}" class="page-link">
                            <span>&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <c:choose>
                            <c:when test="${currentPage eq i}">
                                <li class="page-item active">
                                    <a href="/onBoard/printList.jsp?pageNo=${i}" class="page-link">
                                        <span>${i}</span>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a href="/onBoard/printList.jsp?pageNo=${i}" class="page-link">
                                        <span>${i}</span>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <li class="page-item">
                        <a href="/onBoard/printList.jsp?pageNo=${totalPage}" class="page-link">
                            <span>&raquo;</span>
                        </a>
                    </li>
                </ul>
            </td>
        </tr>
    </div>
</div>

</body>
</html>
