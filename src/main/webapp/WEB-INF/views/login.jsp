<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>로그인 페이지</h2>
<form action="/login" method="post">
    <div>
        <label for="username">아이디</label>
        <input type="text" id="username" name="username" required/>
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required/>
    </div>
    <div>
        <button type="submit">로그인</button>
    </div>
</form>

</body>
</html>
