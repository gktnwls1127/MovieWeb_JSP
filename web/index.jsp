<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

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
    <title>영화 메인 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
</head>
<body>
<c:set value="<%=logIn%>" var="logIn"/>
<c:set value="<%=list%>" var="list"/>
<header class="p-3 mb-5 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container">
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <c:forEach var="f" items="${list}">
            <div class="col">
                <div class="card text-dark">
                    <img style="object-fit: fill" src="${f.images}" class="card-img" alt="${f.title}"
                         onclick="location.href='/film/printOne.jsp?id=${f.id}'">
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="mt-5">
        <tr>
            <td colspan="5" >
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a href="/index.jsp?pageNo=${1}" class="page-link">
                            <span>&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <c:choose>
                            <c:when test="${currentPage eq i}">
                                <li class="page-item active">
                                    <a href="/index.jsp?pageNo=${i}" class="page-link">
                                        <span>${i}</span>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a href="/index.jsp?pageNo=${i}" class="page-link">
                                        <span>${i}</span>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <li class="page-item">
                        <a href="/index.jsp?pageNo=${totalPage}" class="page-link">
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
