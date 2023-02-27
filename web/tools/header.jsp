<%@ page import="model.MemberDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    request.setCharacterEncoding("UTF-8");
    MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
  %>
  <title>Title</title>
  <script>
    function logout(){
      let result = confirm("로그아웃 하시겠습니까?");
      if (result){
        location.href="/member/logout.jsp"
      }
    }
  </script>
</head>
<body>
<c:set value="<%=logIn%>" var="logIn"/>
  <div class="container">
    <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
      <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
        <h4 style="margin-right: 15px">MOVIE</h4>
      </a>

      <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
        <li><a href="/film/printList.jsp" class="nav-link px-2 link-secondary">영화</a></li>
        <li><a href="/theater/printList.jsp" class="nav-link px-2 link-dark">극장</a></li>
        <li><a href="/onBoard/printList.jsp" class="nav-link px-2 link-dark">상영중인 영화</a></li>
      </ul>

      <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search" action="/search/film_search.jsp" method="post">
        <input type="search" class="form-control" placeholder="영화제목 검색" aria-label="Search" name="title">
      </form>

      <c:choose>
        <c:when  test="${logIn eq null}">
          <button type="button" class="btn btn-outline-primary me-2" onclick="location.href = '/member/logIn.jsp'">Login</button>
          <button type="button" class="btn btn-primary" onclick="location.href='/member/register.jsp'">Sign-up</button>
        </c:when>
        <c:otherwise>
          <div class="dropdown text-end">
            <a href="/" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                ${logIn.nickname}
              <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
              </svg>
            </a>
            <ul class="dropdown-menu text-small" style="">
              <c:choose>
                <c:when test="${logIn.level eq 3}">
                  <li><a class="dropdown-item" href="/member/upgradeList.jsp">등업 신청 현황</a></li>
                </c:when>
                <c:otherwise>
                  <li><a class="dropdown-item" href="/member/promote.jsp?id=${logIn.id}">등업 신청</a></li>
                </c:otherwise>
              </c:choose>
              <li><a class="dropdown-item" href="/member/printOne.jsp?id=${logIn.id}">회원 정보</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" onclick="logout()">로그아웃</a></li>
            </ul>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</body>
</html>
