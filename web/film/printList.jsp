<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>영화 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/film/printList.css">
</head>
<body>

<header class="p-3 mb-5 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container">
    <div class="align-items-start justify-center-center">
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
            FilmController filmController = new FilmController(connectionMaker);

            ArrayList<FilmDTO> list = filmController.selectPageALl(pageNo);

            int totalPage = filmController.countTotalPage();

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
            pageContext.setAttribute("currentPage", pageNo);
            pageContext.setAttribute("startPage", startNum);
            pageContext.setAttribute("endPage", endNum);
            pageContext.setAttribute("totalPage", totalPage);
        %>
        <c:set var="logIn" value="<%=logIn%>"/>
        <c:choose>
        <c:when test="${list.isEmpty()}">
            <div class="row">
                <div class="col-6">
                    <span>아직 등록된 영화가 존재하지 않습니다.</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
        <c:set var="list" value="<%=list%>"/>
        <c:forEach var="f" items="${list}">
            <div class="m-5">
                <div class="card" onclick="location.href='/film/printOne.jsp?id=${f.id}'">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img src="${f.images}" class="img-fluid rounded-start" alt="${f.title}">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title">${f.title}</h5>
                                <p class="card-text text-overflow">${f.summary}</p>
                                <p class="card-text"><small class="text-muted">${f.rating}</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    </c:otherwise>
    </c:choose>

    <c:if test="${logIn.level == 3}">
        <div class="row">
            <div class="col-12 text-end">
                <span class="btn btn-outline-info" onclick="location.href='/film/write.jsp'">영화 추가하기</span>
            </div>
        </div>
    </c:if>
    <tr class="mt-5">
        <td colspan="5">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a href="/film/printList.jsp?pageNo=${1}" class="page-link">
                        <span>&laquo;</span>
                    </a>
                </li>
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <c:choose>
                        <c:when test="${currentPage eq i}">
                            <li class="page-item active">
                                <a href="/film/printList.jsp?pageNo=${i}" class="page-link">
                                    <span>${i}</span>
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a href="/film/printList.jsp?pageNo=${i}" class="page-link">
                                    <span>${i}</span>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <li class="page-item">
                    <a href="/film/printList.jsp?pageNo=${totalPage}" class="page-link">
                        <span>&raquo;</span>
                    </a>
                </li>
            </ul>
        </td>
    </tr>
</div>
</body>
</html>















