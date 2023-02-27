<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오후 3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  String savePath="upload"; // 저장하고싶은 파일,
  ServletContext context = request.getSession().getServletContext();//프로젝트 절대경로
  String uploadFilePath = context.getRealPath(savePath);

  try{
    MultipartRequest multi = new MultipartRequest(request, uploadFilePath, 1024 * 1024 * 5, "UTF-8",
            new DefaultFileRenamePolicy());

    String title = multi.getParameter("title");
    String summary = multi.getParameter("summary");
    String rating = multi.getParameter("rating");
    String images = multi.getOriginalFileName("images");

    ConnectionMaker connectionMaker = new MySqlConnectioMaker();
    FilmController filmController = new FilmController(connectionMaker);
    FilmDTO filmDTO = new FilmDTO();

    filmDTO.setTitle(title);
    filmDTO.setSummary(summary);
    filmDTO.setRating(rating);
    filmDTO.setImages("/upload/"+images);

    filmController.insert(filmDTO);

    response.sendRedirect("/film/printList.jsp");
  } catch (IOException e){
    request.setAttribute("error", "최대파일 용량을(5KB)초과하였습니다.");
  }



%>
</body>
</html>
