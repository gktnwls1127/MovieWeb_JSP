<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.IOException" %>
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

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  FilmController filmController = new FilmController(connectionMaker);
  FilmDTO filmDTO = filmController.selectOne(id);

  if (logIn.getLevel() != 3){
    response.sendRedirect("/film/printOne.jsp?id="+id);
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

    filmDTO.setTitle(title);
    filmDTO.setSummary(summary);
    filmDTO.setRating(rating);
    filmDTO.setImages("/upload/"+images);


    filmController.update(filmDTO);

    response.sendRedirect("/film/printOne.jsp?id="+id);
  } catch (IOException e){
    request.setAttribute("error", "최대파일 용량을(5KB)초과하였습니다.");
  }

%>
</body>
</html>
