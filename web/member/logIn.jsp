<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  <link href="/member/logIn.css" rel="stylesheet" type="text/css">
</head>
<body class="text-center">

<main class="form-signin w-100 m-auto">
  <form action="/member/auth.jsp" method="post">
    <h1 class="h3 mb-3 fw-normal">로그인</h1>

    <div class="form-floating">
      <input type="text" id="username" name="username" class="form-control" placeholder="아이디">
      <label for="username">아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호">
      <label for="username">비밀번호</label>
    </div>
    <button class="w-100 btn btn-lg btn-outline-primary" type="submit">로그인</button>
  </form>
</main>
</body>
</html>
