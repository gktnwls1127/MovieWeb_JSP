<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="controller.OnBoardController" %>
<%@ page import="model.OnBoardDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>상영정보 수정하기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  <%
    MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
    if (logIn == null || logIn.getLevel() != 3) {
      response.sendRedirect("/index.jsp");
    }

    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MySqlConnectioMaker();
    FilmController filmController = new FilmController(connectionMaker);
    TheaterController theaterController = new TheaterController(connectionMaker);
    OnBoardController onBoardController = new OnBoardController(connectionMaker);

    ArrayList<TheaterDTO> theater_list = theaterController.selectAll();
    OnBoardDTO onBoardDTO = onBoardController.selectOne(id);

    pageContext.setAttribute("filmController", filmController);
    pageContext.setAttribute("theater_list", theater_list);
    pageContext.setAttribute("theaterController", theaterController);
    pageContext.setAttribute("onBoardDTO", onBoardDTO);

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
        <h4>${filmController.selectOne(onBoardDTO.filmId).title} 상영정보 수정하기</h4>
      </div>
        <h6 class="text-start mb-3">상영번호 ${onBoardDTO.id}</h6>
        <form action="/onBoard/update_logic.jsp?id=${onBoardDTO.id}" method="post">
          <div class="row justify-content-center mb-3">
            <div class="col-10">
              <div class="form-floating">
                <input id="film" type="text" name="filmId" class="form-control" value="${onBoardDTO.filmId}" readonly>
                <label for="film">영화 번호</label>
              </div>
            </div>
          </div>
          <div class="row justify-content-center mb-3">
            <div class="col-10">
              <div class="form-floating">
                <input id="currentTheater" type="text" class="form-control" value="${theaterController.selectOne(onBoardDTO.theaterId).theaterName}" readonly>
                <label for="currentTheater">현재 선택된 극장</label>
              </div>
            </div>
          </div>
          <div class="row justify-content-center mb-3">
            <div class="col-10">
              <div class="form-floating">
                <select class="form-select" name="theaterId" id="theater">
                  <option selected>상영정보 등록하고 싶은 극장</option>
                  <c:forEach items="${theater_list}" var="theater" >
                    <option value="${theater.id}">${theater.id}. ${theater.theaterName}</option>
                  </c:forEach>
                </select>
                <label for="theater">새로운 극장 선택</label>
              </div>
            </div>
          </div>
          <div class="row justify-content-center mb-3">
            <div class="col-10">
              <div class="form-floating">
                <input id="runningTime" type="text" name="runningTime" class="form-control" value="${onBoardDTO.runningTime}">
                <label for="runningTime">영화 상영 시간</label>
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
</body>
</html>
